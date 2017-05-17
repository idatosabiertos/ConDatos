# coding: utf-8
require 'sinatra'
require 'sequel'
require 'csv'
require 'dotenv'
require 'sinatra/r18n'
require_relative 'models/init.rb'
require_relative 'lib/form_data.rb'
require 'sendgrid-ruby'
include SendGrid

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

#get '/agenda' do
#  erb :agenda
#end

get '/sedes' do
  erb :sedes
end

get '/evento' do
  erb :evento
end

get '/ciudad' do
  erb :montevideo
end

get '/contact' do
  erb :contact
end

post '/contactar' do
 
  data = JSON.parse('{
    "personalizations": [
      {
        "to": [
          {
            "email":"'+ ENV['CONTACT_EMAIL'] +'"
          }
        ],
        "subject": "[CONDATOS/ABRELATAM] - correo de: '+params['name']+'"
      }
    ],
    "from": {
      "email": "'+params['email']+'"
    },
    "content": [
      {
        "type": "text/plain",
        "value": "Nombre: '+params['name']+' \n Correo: '+params['email']+' \n Organización: '+params['email']+' \n País: '+params['country']+' \n \n Mensaje: '+params['message']+'"
      }
    ]
  }')
  sg = SendGrid::API.new(api_key: ENV['SENDGRID_APIKEY'])
  response = sg.client.mail._("send").post(request_body: data)
  puts response.status_code
  puts response.body

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
    name: params[:name], 
    surname: params[:surname],
    gender: params[:gender],
    email: params[:email],
    country_origin: params[:country_origin],
    country_residence: params[:country_residence],
    job: params[:job],
    open_data_usage: params[:open_data_usage],
    particpated_before: params[:particpated_before] == 'on' ? 'Sí' : 'No',
    scholarship_before: params[:scholarship_before] == 'on' ? 'Sí' : 'No',
    scholarship_more_than_once: params[:scholarship_more_than_once] == 'on' ? 'Sí' : 'No',
    participates_in_representation: params[:participates_in_representation] == 'on' ? 'Sí' : 'No',
    event: params[:event] ? params[:event].join(', ') : '',
    financial_support: params[:financial_support] ? params[:financial_support].join(', ') : '',
    thematic: params[:thematic] ? params[:thematic].join(', ') : '',
    open_data_problem: params[:open_data_problem],
    organization: params[:organization],
    organization_role: params[:organization_role],
    organization_type: params[:organization_type],
    website: params[:website],
    facebook: params[:facebook],
    twitter: params[:twitter],
    instagram: params[:instagram],
    participate_as_colaborator: params[:participate_as_colaborator] == 'on' ? 'Sí' : 'No',
    colaborator_area: params[:colaborator_area] ? params[:colaborator_area].join(', ') : '',
    has_proposition: params[:has_proposition] == 'on' ? 'Sí' : 'No',
    proposition_title: params[:proposition_title],
    proposition_summary: params[:proposition_summary],
    proposition_why_include: params[:proposition_why_include],
    proposition_others_needed: params[:proposition_others_needed])
  # Check for errors, so we can add custom ones on the next line
  # inscription.valid?

  # Add error if the mandatory fields are not checked
  #inscription.errors.add(:email_organization, :checked) unless params[:email_organization]
  #inscription.errors.add(:register_image, :checked) unless params[:register_image]

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
