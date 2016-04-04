require 'sequel'

namespace :db do
  desc "Create database"
  task :create do
    puts 'Creating database'
    DB = Sequel.connect(ENV['DATABASE_URL'] || 'postgres://localhost:5432/ogp')

    puts 'Creating surveys table'
    DB.create_table :surveys do
      primary_key :id
      String :name
      String :organization
      String :sector
      String :country
      String :email
      String :unconference
      String :unconference_comments
      String :regional
      String :conference_comments
      String :interests
      String :enabler
      String :link
      String :needs_transport
      String :needs_hosting
    end
  end

  desc "Create inscriptions"
  task :create_inscriptions do
    puts "Creating inscriptions table"
    DB = Sequel.connect(ENV['DATABASE_URL'] || 'postgres://localhost:5432/ogp')
    DB.create_table :inscriptions do
      primary_key :id
      String :name
      String :organization
      String :sector
      String :country
      String :email
      String :unconference
      String :conference
      String :visa_help
      String :food
      String :accessibility
      String :languages
    end
  end
end

desc "Console"
task :console do
  require 'irb'
  require 'irb/completion'
  require_relative 'ogp.rb'
  ARGV.clear
  IRB.start
end
