require 'httparty'
require 'json'
require 'lib/roadmap.rb'


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




end
