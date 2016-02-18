# coding: utf-8
class Survey < Sequel::Model
  plugin :csv_serializer
  plugin :validation_helpers

  def validate
    super
    validates_presence([:name, :organization, :email, :sector], message: 'No puede ser vacío')
  end
end
