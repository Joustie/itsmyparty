require 'net/smtp'
require 'mail'
require 'yaml'


@yaml = YAML.load_file('att.yml')
@attendees = @yaml['attendees']
@attendees.each do |letter, hash|

@partyhost = "party.example.com"
@birthdayboy = "Me"
@phone = "0000"
@mailhost = "smtp.example.com"
@mailfrom = "j.evertse@xs4all.nl"

message = <<MESSAGE_END
<p>Hello!</p>

<p>It's my party. Wanna come?</p>

<p>Please rvsp  <a href="http://#{@partyhost}:4567/#{@attendees[letter]['guid']}"> here</a></p>

<p>Regards,<br/>
#{@birthdayboy}</p>
Mobile: #{@phone}

MESSAGE_END

mailto = "#{@attendees[letter]['name']} <#{@attendees[letter]['email']}>"
  mail = Mail.deliver do
    to      mailto
    delivery_method :smtp, address: @mailhost, port: 25
    from    @mailfrom
    subject 'RVSP It's my party'
  
    text_part do
      body ''
    end
  
    html_part do
      content_type 'text/html; charset=UTF-8'
      body  message
    end
  end


end
