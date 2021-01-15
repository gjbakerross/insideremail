class Email < ApplicationRecord
    belongs_to :country

    # def get_country_name
    #     country = Country.find(self.country_id).name
    # end

end
