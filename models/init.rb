# encoding: utf-8
require 'sequel'
DB = Sequel.connect(ENV['DATABASE_URL'] || 'postgres://localhost:5432/ogp')
DB << "SET CLIENT_ENCODING TO 'UTF8';"

Dir["./models/*.rb"].each {|file| require file }
