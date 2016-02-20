# coding: utf-8
require 'sinatra'
require 'sequel'
require 'csv'
require 'dotenv'
require_relative 'models/init.rb'
require_relative 'lib/form_data.rb'

Dotenv.load

get '/' do
  erb :index
end

post '/enviar' do
  survey = Survey.new(
    name: params[:name],
    organization: params[:organization],
    sector: params[:sector],
    country: params[:country],
    email: params[:email],
    unconference: params[:unconference] == 'on' ? 'Sí' : 'No',
    unconference_comments: params[:unconference_comments],
    regional: params[:regional] == 'on' ? 'Sí' : 'No',
    interests: params[:interests],
    conference_comments: params[:conference_comments],
    enabler: params[:enabler] == 'on' ? 'Sí' : 'No',
    link: params[:link]
  )
  if survey.valid?
    survey.save
    erb :thanks
  else
    # TODO - Show backend errors on frontend
    redirect to('/')
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
  csv = "Nombre;Organización;Sector;País;Email;Inscripción Desconferencia;Aportar a desconferencia;Inscripción encuentro Regional;Aportar conferencia temas;Temas de interés;Postulante facilitador;Enlace CV o Linkedin\n"
  Survey.each do |survey|
    csv << survey.to_csv(except: :id)
  end
  csv
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
end
