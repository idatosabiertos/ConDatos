# coding: utf-8
require 'sinatra/r18n'

module FormData
  def self.countries
    [
      'Argentina', 'Brasil', 'Canada', 'Chile', 'Colombia', 'Costa
      Rica', 'El Salvador', 'Guatemala', 'Honduras', 'Mexico',
      'Panama', 'Paraguay', 'Peru', 'República Dominicana', 'Trinidad
      y Tobago', 'United States', 'Uruguay', '--------', 'Afghanistan', 'Åland
      Islands', 'Albania', 'Algeria', 'American Samoa', 'Andorra',
      'Angola', 'Anguilla', 'Antarctica', 'Antigua and Barbuda',
      'Armenia', 'Aruba', 'Australia', 'Austria', 'Azerbaijan',
      'Bahamas', 'Bahrain', 'Bangladesh', 'Barbados', 'Belarus',
      'Belgium', 'Belize', 'Benin', 'Bermuda', 'Bhutan', 'Bolivia',
      'Bosnia and Herzegovina', 'Botswana', 'Bouvet Island', 'British
      Indian Ocean Territory', 'Brunei Darussalam', 'Bulgaria',
      'Burkina Faso', 'Burundi', 'Cambodia', 'Cameroon', 'Cape Verde',
      'Cayman Islands', 'Central African Republic', 'Chad', 'China',
      'Christmas Island', 'Cocos (Keeling) Islands', 'Comoros',
      'Congo', 'Congo, The Democratic Republic of The', 'Cook
      Islands', 'Cote D\'ivoire', 'Croatia', 'Cuba', 'Cyprus', 'Czech
      Republic', 'Denmark', 'Djibouti', 'Dominica', 'Ecuador',
      'Egypt', 'Equatorial Guinea', 'Eritrea', 'Estonia', 'Ethiopia',
      'Falkland Islands (Malvinas)', 'Faroe Islands', 'Fiji',
      'Finland', 'France', 'French Guiana', 'French Polynesia',
      'French Southern Territories', 'Gabon', 'Gambia', 'Georgia',
      'Germany', 'Ghana', 'Gibraltar', 'Greece', 'Greenland',
      'Grenada', 'Guadeloupe', 'Guam', 'Guernsey', 'Guinea',
      'Guinea-bissau', 'Guyana', 'Haiti', 'Heard Island and Mcdonald
      Islands', 'Holy See (Vatican City State)', 'Hong Kong',
      'Hungary', 'Iceland', 'India', 'Indonesia', 'Iran, Islamic
      Republic of', 'Iraq', 'Ireland', 'Isle of Man', 'Israel',
      'Italy', 'Jamaica', 'Japan', 'Jersey', 'Jordan', 'Kazakhstan',
      'Kenya', 'Kiribati', 'Korea, Democratic People\'s Republic of',
      'Korea, Republic of', 'Kuwait', 'Kyrgyzstan', 'Lao People\'s
      Democratic Republic', 'Latvia', 'Lebanon', 'Lesotho', 'Liberia',
      'Libyan Arab Jamahiriya', 'Liechtenstein', 'Lithuania',
      'Luxembourg', 'Macao', 'Macedonia, The Former Yugoslav Republic
      of', 'Madagascar', 'Malawi', 'Malaysia', 'Maldives', 'Mali',
      'Malta', 'Marshall Islands', 'Martinique', 'Mauritania',
      'Mauritius', 'Mayotte', 'Micronesia, Federated States of',
      'Moldova, Republic of', 'Monaco', 'Mongolia', 'Montenegro',
      'Montserrat', 'Morocco', 'Mozambique', 'Myanmar', 'Namibia',
      'Nauru', 'Nepal', 'Netherlands', 'Netherlands Antilles', 'New
      Caledonia', 'New Zealand', 'Nicaragua', 'Niger', 'Nigeria',
      'Niue', 'Norfolk Island', 'Northern Mariana Islands', 'Norway',
      'Oman', 'Pakistan', 'Palau', 'Palestinian Territory, Occupied',
      'Papua New Guinea', 'Philippines', 'Pitcairn', 'Poland',
      'Portugal', 'Puerto Rico', 'Qatar', 'Reunion', 'Romania',
      'Russian Federation', 'Rwanda', 'Saint Helena', 'Saint Kitts and
      Nevis', 'Saint Lucia', 'Saint Pierre and Miquelon', 'Saint
      Vincent and The Grenadines', 'Samoa', 'San Marino', 'Sao Tome
      and Principe', 'Saudi Arabia', 'Senegal', 'Serbia',
      'Seychelles', 'Sierra Leone', 'Singapore', 'Slovakia',
      'Slovenia', 'Solomon Islands', 'Somalia', 'South Africa', 'South
      Georgia and The South Sandwich Islands', 'Spain', 'Sri Lanka',
      'Sudan', 'Suriname', 'Svalbard and Jan Mayen', 'Swaziland',
      'Sweden', 'Switzerland', 'Syrian Arab Republic', 'Taiwan,
      Province of China', 'Tajikistan', 'Tanzania, United Republic
      of', 'Thailand', 'Timor-leste', 'Togo', 'Tokelau', 'Tonga',
      'Tunisia', 'Turkey', 'Turkmenistan', 'Turks and Caicos Islands',
      'Tuvalu', 'Uganda', 'Ukraine', 'United Arab Emirates', 'United
      Kingdom', 'United States Minor Outlying Islands', 'Uzbekistan',
      'Vanuatu', 'Venezuela', 'Viet Nam', 'Virgin Islands, British',
      'Virgin Islands, U.S.', 'Wallis and Futuna', 'Western Sahara',
      'Yemen', 'Zambia', 'Zimbabwe'
    ]
  end

  def self.interests
    [
      :innovation, :cooperation, :technology, :open_parliament, :open_justice, :mark_zuckerberg, :public_policy, :docs, :public_designations, :public_purchases, :public_contracts, :subnational_governments, :aga_experience, :national_plans, :dialog_mechas, :opendata_development, :opendata_cities, :opendata_environment, :opendata_corruption, :natural_resources, :energy, :extractive_industries, :poverty, :food, :productivity, :public_health, :decent_job, :quality_education, :equality, :decent_housing, :gender_equality, :urban_development, :rural_development, :sustainable_transport, :social_inclusion, :public_safety, :citizen_participation, :integrity, :transparent_elections, :innovation_labs, :public_information, :economic_development, :civic_tech
    ]
  end

  def self.sectors
    [:government, :society, :police_academy, :foundation, :think_tank,
     :multilateral, :private]
  end
end
