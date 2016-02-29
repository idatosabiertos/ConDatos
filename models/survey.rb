# coding: utf-8
class Survey < Sequel::Model
  plugin :csv_serializer
  plugin :validation_helpers

  def validate
    super
    validates_presence([:name, :organization, :email, :sector], message: :empty)
    errors.add(:country, :empty) unless valid_country
    errors.add(:sector, :empty) unless valid_sector
    errors.add(:unconference_comments, :max_words) if max_words_unconference
    errors.add(:conference_comments, :max_words) if max_words_conference
  end

  private

  def valid_country
    !(['País*', '--------', 'Country*', ''].include? country)
  end

  def valid_sector
    !(['Sector*', '--------', ''].include? sector)
  end

  def max_words_unconference
    (unconference_comments.split(' ').length > 300)
  end

  def max_words_conference
    (conference_comments.split(' ').length > 300)
  end
end
