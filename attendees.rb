require 'yaml'
require 'securerandom'

yaml_hash = YAML.load_file('attendees.yml')
p yaml_hash

yaml_hash.each do | letter |
  puts letter['name']
end

File.write('attendees.yml', yaml_hash.to_yaml)
