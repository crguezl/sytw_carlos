require 'rest_client'
require 'json'

class User
  class << self
    attr_accessor :base_uri
  end

  def self.find_by_name(name)
    begin
      response = RestClient.get "#{base_uri}/api/v1/users/#{name}"
      JSON.parse(response)['user']
    rescue => e
      if JSON.parse(e.response)['error'] == 'user not found'
        nil
      else
        raise e
      end
    end
  end

  def self.create attributes
    begin
      response = RestClient.post "#{base_uri}/api/v1/users", attributes.to_json
      if response.code == 200
        JSON.parse(response)['user']
      else
        nil
      end
    rescue
      nil
    end
  end

  def self.update(name, attributes)
    begin
      response = RestClient.put "#{base_uri}/api/v1/users/#{name}", attributes.to_json
      if response.code == 200
        JSON.parse(response)['user']
      else
        nil
      end
    rescue
      nil
    end
  end

  def self.destroy(name)
    begin
      response = RestClient.delete "#{base_uri}/api/v1/users/#{name}"
      response.code == 200
    rescue
      nil
    end
  end

  def self.login(name, password)
    begin
      response = RestClient.post "#{base_uri}/api/v1/users/#{name}/sessions", {:password => password}.to_json
      if response.code == 200
        JSON.parse(response)['user']
      else
        nil
      end
    rescue
      nil
    end
  end
end