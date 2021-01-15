# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

country_list = [
    ["United Kingdom", "UK"],
    ["United States", "US"],
    ["Netherlands","NL"],
    ["France", "FR"],
    ["Germany", "DE"],
    ["Ireland", "IE"],
    ["Australia","AU"],
    ["Italy","IT"]
    
]

country_list.each do |name, code|
    Country.create( name: name, code: code )
end

api_list = [
    ["116f16e223e84f5a97e65e499805f153", "UK"],
    ["l9Ow0OV4aUTi7lVlPdHVrG", "US"],
    ["6UHtC7sq3mvYibOGwQA7Ej","NL"],
    ["lVNMkJimIxSR9BeiyQSC9r", "FR"],
    ["e8jiU2i19OBttJfTJ4ibp0", "DE"],
    ["68F5qT4YhGcguKo05SLNIp", "IE"],
    ["8GjJ2CF0CREpE6tu3qnzmq","AU"],
    ["frPDmDF359Lvvo6D99GfFW","IT"]
]

api_list.each do |key, code|
    Apikey.create(apikey:key, country_id:Country.find_by(code:code).id)
end