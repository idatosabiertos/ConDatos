# coding: utf-8
require 'sinatra'
require 'sequel'
require 'csv'
require_relative 'models/init.rb'

get '/' do
  erb :index
end

post '/enviar' do
  Survey.create(
    name: params[:name],
    organization: params[:organization],
    sector: params[:sector],
    country: params[:country],
    comments: params[:comments]
  )
  erb :thanks
end

get '/resultados' do
  Sequel::Plugins::CsvSerializer.configure(
    Survey,
    col_sep: ';',
    encoding: 'UTF-8'
  )
  content_type 'application/csv'
  attachment 'resultados_ogp.csv'
  csv = "Nombre;Organización;Sector;País;Comentarios\n"
  Survey.each do |survey|
    csv << survey.to_csv(except: :id)
  end
  csv
end
