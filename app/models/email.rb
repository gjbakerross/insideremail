class Email < ApplicationRecord
    belongs_to :country
    require 'csv'

    def self.to_email_csv
        headers = %w(email country opt-out, date)
        attributes = %w(email)
        CSV.generate(headers: true) do |csv|
            csv << headers
          
            all.each do |email|
                data = attributes.map{ |attr| email.send(attr) }
                  # byebug
                data << email.country.name 
                data << "true"
                data << email.created_at.strftime("%F")
                csv <<  data
                  # byebug
            end
        end
    end

    # def get_country_name
    #     country = Country.find(self.country_id).name
    # end

end
