require "csv"
require "yaml"
 
 
data = CSV.read('people.csv', :headers => true).map(&:to_hash)
File.open('attendees.yml', 'w') { |f| f.write(data.to_yaml) }
