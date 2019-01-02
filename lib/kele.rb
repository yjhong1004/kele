require 'httparty'
require 'json'


class Kele
  include HTTParty
  def base_uri
    'https://www.bloc.io/api/v1'
  end
  def initialize(email, password)
    @options = {
      body: {
      email: email,
      password: password
      }
    }
    response = self.class.post("#{base_uri}/sessions", @options)
    @auth_token = response['auth_token']
    if @auth_token.nil?
      puts "Sorry, invalid credentials."
    end
  end
end
