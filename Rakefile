require 'sequel'

namespace :db do

  desc "Create inscriptions"
  task :create_inscriptions do
    puts "Creating inscriptions table"
    DB = Sequel.connect(ENV['PG_DB_URL'], :user=>ENV['PG_USER'], :password=>ENV['PG_PWD'])
    DB.create_table :inscriptions do
      primary_key :id
      String :name
      String :surname
      String :gender
      String :email
      String :country_origin
      String :country_residence
      String :job
      String :open_data_usage
      String :particpated_before
      String :scholarship_before
      String :scholarship_more_than_once
      String :participates_in_representation
      String :event
      String :financial_support
      String :thematic
      String :open_data_problem
      String :organization      
      String :organization_type 
      String :organization_role
      String :website
      String :facebook
      String :twitter
      String :instagram
      String :github
      String :participate_as_colaborator
      String :colaborator_area
      String :has_proposition
      String :proposition_title
      String :proposition_summary
      String :proposition_why_include
      String :proposition_others_needed
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
