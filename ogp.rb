# coding: utf-8
require 'sinatra'
require 'sequel'
require 'csv'
require 'dotenv'
require 'sinatra/r18n'
require 'mail'
require_relative 'models/init.rb'
require_relative 'config.rb'
require_relative 'lib/form_data.rb'

Dotenv.load
R18n::I18n.default = 'es'

# Start Rollbar config
require 'rollbar'
Rollbar.configure do |config|
  config.access_token = ENV['ROLLBAR_ACCESS_TOKEN']
end
# End Rollbar config

before do
  session[:locale] = params.fetch('locale', 'es')
end

get '/' do
  erb :index
end

get '/inscription' do
  inscription = Inscription.new
  erb :form, locals: { inscription: inscription }
end

post '/enviar' do
  inscription = create_inscription(params)
  return erb :form, locals: { inscription: inscription } unless inscription.errors.empty?

  inscription.save
  erb :thanks
end

get '/thanks' do
  erb :thanks
end

get '/agenda' do
  erb :agenda
end

get '/sedes' do
  erb :sedes
end

get '/evento' do
  erb :evento
end

get '/montevideo' do
  erb :montevideo
end

get '/contact' do
  erb :contact
end

post '/contactar' do
  #{"name"=>"", "organization"=>"", "email"=>"", "country"=>"País*"}
  email = params['email']
  name = params['name']
  subject = "[ogp-montevideo] - correo de #{name}"
  message = <<-eos
    Nombre: #{name}
    Correo: #{email}
    Organización: #{params['organization']}
    País: #{params['country']}\n

    Mensaje: #{params['message']}
  eos

  destiny = ENV['CONTACT_EMAIL']
  mail = Mail.new do
    from    email
    to      destiny
    subject subject
    body    message
  end
  if ENV['RACK_ENV'] == 'production'
    mail.deliver
  else
    puts mail.to_s
    mail.to_s
  end

  erb :contactar
end

get '/mode_info' do
  erb :more_info
end

# get '/proceso' do
#   erb :proceso
# end

# get '/criterios' do
#   erb :criterios
# end

# get '/becarios' do
#   erb :becarios
# end

get '/resultados' do
  protected!
  Sequel::Plugins::CsvSerializer.configure(
    Survey,
    col_sep: ';',
    encoding: 'UTF-8'
  )
  content_type 'application/csv'
  attachment 'resultados_ogp.csv'
  csv = "Nombre;Organización;Sector;País;Email;Inscripción Desconferencia;Aportar a desconferencia;Inscripción encuentro Regional;Aportar conferencia temas;Temas de interés;Postulante facilitador;Enlace CV o Linkedin;Necesita transporte;Necesita alojamiento\n"
  Survey.each do |survey|
    csv << survey.to_csv(except: :id)
  end
  csv
end

get '/inscripciones' do
  protected!
  Sequel::Plugins::CsvSerializer.configure(
    Inscription,
    col_sep: ';',
    encoding: 'UTF-8'
  )
  content_type 'application/csv'
  attachment 'inscripciones_ogp.csv'
  csv = "Nombre;Organización;Sector;País;Email;Inscripción Desconferencia;Inscripción encuentro Regional;Requiere ayuda Visa;Comida;Accesibilidad;Idiomas\n"
  Inscription.each do |inscription|
    csv << inscription.to_csv(except: :id)
  end
  csv
end

def create_inscription(params)
  inscription = Inscription.new(
    name: params[:name], organization: params[:organization],
    sector: params[:sector], country: params[:country],
    email: params[:email], unconference: params[:unconference] == 'on' ? 'Sí' : 'No',
    conference: params[:regional] == 'on' ? 'Sí' : 'No',
    visa_help: params[:visa] == 'on' ? 'Sí' : 'No',
    food: params[:food] ? params[:food].join(', ') : '',
    accessibility: params[:accessibility],
    languages: params[:languages] ? params[:languages].join(', ') : ''
  )
  # Check for errors, so we can add custom ones on the next line
  inscription.valid?

  # Add error if the mandatory fields are not checked
  inscription.errors.add(:email_organization, :checked) unless params[:email_organization]
  inscription.errors.add(:register_image, :checked) unless params[:register_image]

  inscription
end

helpers do
  def protected!
    return if authorized?
    headers['WWW-Authenticate'] = 'Basic realm="Restricted Area"'
    halt 401, "No está autorizado\n"
  end

  def authorized?
    @auth ||= Rack::Auth::Basic::Request.new(request.env)
    @auth.provided? && @auth.basic? && @auth.credentials && @auth.credentials == [ENV['RESULTADOS_USER'], ENV['PASSWORD']]
  end

  def home_url
    "#{request.env['rack.url_scheme']}://#{request.env['HTTP_HOST']}"
  end

  def clean_current_url
    regex = /\?.+/
    request.url.gsub(regex, '')
  end

  def language_buttons
    if (session[:locale] == 'es')
      "<a class=\"active\">Español</a>" +
      "<a href=\"#{clean_current_url}?locale=en\">English</a>"
    else
      "<a href=\"#{clean_current_url}?locale=es\">Español</a>" +
      "<a class=\"active\">English</a>"
    end
  end
end
