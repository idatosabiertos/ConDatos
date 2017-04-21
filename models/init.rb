# encoding: utf-8
require 'sequel'
DB = Sequel.connect(ENV['PG_DB_URL'], :user=>ENV['PG_USER'], :password=>ENV['PG_PWD'])
DB << "SET CLIENT_ENCODING TO 'UTF8';"

Dir["./models/*.rb"].each {|file| require file }
