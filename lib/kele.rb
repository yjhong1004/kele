require 'httparty'
require 'json'
require_relative 'roadmap'


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
    response = self.class.post("#{base_uri}/sessions", @options)
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
    response = self.class.get("#{base_uri}/message_threads", body: {
      "page": page_number},
      headers: {"authorization" => @auth_token})
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
