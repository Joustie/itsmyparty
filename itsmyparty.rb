require 'sinatra'
require 'yaml/store'

set :bind, '0.0.0.0'

get '/results' do
  @title = 'Genodigden'
  @yaml = YAML.load_file('attendees.yml')
  @attendees = @yaml['attendees']
  erb :results
end

get '/:guid' do
   @guid = params[:guid]
   @yaml = YAML.load_file('attendees.yml')
   @attendees = @yaml['attendees']
   @attendees.each do |letter, hash|
    if @attendees[letter]['guid'] == @guid
      @personname = @attendees[letter]['name']
    end
  end
   erb :index, :locals => {:guid => params[:guid]}
end

post '/register' do
  @title = 'Bedankt voor het doorgeven!'
  @presence  = params['presence']
  @partner = params['partner']
  @person = params['person']
  @yaml = YAML.load_file('attendees.yml')
  @attendees = @yaml['attendees']
  @attendees.each do |letter, hash|
    if @attendees[letter]['guid'] == @person
      @attendees[letter]['attending'] = @presence
      @attendees[letter]['partner'] = @partner
    end
  end
 
  output = YAML.dump @yaml
  File.write("attendees.yml", output)

  erb :register
end

Choices = {
  'JA' => 'JA',
  'NEE' => 'NEE',
  'MISSCHIEN' => 'MISSCHIEN',
}

Partner = {
  'JA' => 'JA',
  'NEE' => 'NEE',
  'MISSCHIEN' => 'MISSCHIEN',
}

