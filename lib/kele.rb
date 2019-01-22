require 'httparty'
require 'json'
require_relative 'roadmap'

user_agent = 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/56.0.2924.87 Safari/537.36'
class Kele
  include HTTParty
  include Roadmap
  def base_uri
    'https://www.bloc.io/api/v1'
  end

  def initialize(email, password)
    @options = {
      email: email,
      password: password

    }
    p "#{base_uri}/sessions"
    p @options

    response = self.class.post("#{base_uri}/sessions", :body => @options.to_json, :headers => {'Content-Type' => 'application/json' })
    puts "Response:"
    p response
    @auth_token = response["auth_token"]
    if @auth_token.nil?
      puts "Sorry, invalid credentials."
    end
  end

  def get_me
    response = self.class.get("#{base_uri}/users/me", headers: { "authorization" => @auth_token })
    JSON.parse(response.body)
  end

  def get_mentor_availability(mentor_id)
    response = self.class.get("#{base_uri}/mentors/#{mentor_id}/student_availability", headers: {"authorization" => @auth_token} )
    JSON.parse(response.body)
  end

  def get_messages(page_number)
    if page_number == nil
      response = self.class.get("#{base_uri}/message_threads", body: {}, headers: {"authorization" => @auth_token})
    else
    response = self.class.get("#{base_uri}/message_threads", body: {
      "page": page_number
    }, headers: {"authorization" => @auth_token})
    end

    JSON.parse(response.body)
  end

  def create_message(sender, recipient_id, subject, token, stripped_text)
    response = self.class.post("#{base_uri}/messages", body: {
      "sender": sender,
      "recipient_id": recipient_id,
      "subject": subject,
      "token": string,
      "stripped-text": stripped-text
      }, headers: {"authorization" => @auth_token})
  end


end
