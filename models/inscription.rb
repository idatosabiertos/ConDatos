# coding: utf-8
class Inscription < Sequel::Model
  plugin :csv_serializer
  plugin :validation_helpers

  def validate
    super
    validates_presence([:name, :organization, :email, :sector], message: :empty)
    errors.add(:country, :empty) unless valid_country
    errors.add(:sector, :empty) unless valid_sector
  end

  private

  def valid_country
    !(['País*', '--------', 'Country*', ''].include? country)
  end

  def valid_sector
    !(['Sector*', '--------', ''].include? sector)
  end
end
