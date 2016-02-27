# coding: utf-8
require 'sinatra'
require 'sequel'
require 'csv'
require 'dotenv'
require 'sinatra/r18n'
require_relative 'models/init.rb'
require_relative 'lib/form_data.rb'

Dotenv.load
R18n::I18n.default = 'es'

before do
  session[:locale] = if params[:locale]
                       params[:locale]
                     else
                       'es'
                     end
end

get '/' do
  survey = Survey.new
  erb :index, locals: { survey: survey }
end

post '/enviar' do
  survey = create_survey(params)
  if survey.errors.empty?
    survey.save
    erb :thanks
  else
    erb :index, locals: { survey: survey }
  end
end

get '/proceso' do
  erb :proceso
end

get '/criterios' do
  erb :criterios
end

get '/becarios' do
  erb :becarios
end

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

def create_survey(params)
  if params[:interests] && params[:interests].include?('other') && params[:other_interests]
    params[:interests].delete('other')
    params[:interests] << params[:other_interests]
  end
  survey = Survey.new(
    name: params[:name], organization: params[:organization],
    sector: params[:sector], country: params[:country],
    email: params[:email], unconference: params[:unconference] == 'on' ? 'Sí' : 'No',
    unconference_comments: params[:unconference_comments],
    regional: params[:regional] == 'on' ? 'Sí' : 'No', interests: params[:interests],
    conference_comments: params[:conference_comments],
    enabler: params[:enabler] == 'on' ? 'Sí' : 'No', link: params[:link],
    needs_transport: params[:fellows_transport] == 'on' ? 'Sí' : 'No',
    needs_hosting: params[:fellows_hosting] == 'on' ? 'Sí' : 'No'
  )
  # Check for errors, so we can add custom ones on the next line
  survey.valid?
  # Add error if the mandatory fields are not checked
  survey.errors.add(:email_organization, :checked) unless params[:email_organization]
  survey.errors.add(:register_image, :checked) unless params[:register_image]

  survey
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
end
