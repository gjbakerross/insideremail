class Country < ApplicationRecord
    has_one :apikey
    has_many :emails


end
