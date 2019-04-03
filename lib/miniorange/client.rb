require 'digest'
require 'uri'
require 'json'
require 'net/http'
require 'net/https'

module MiniOrange
  class Client
    def initialize
      @http = Net::HTTP.new uri.host, uri.port
      @http.use_ssl = true
    end

    def uri
      @uri ||= URI.parse(ENV["MINIORANGE_API_URL"] || "https://auth.miniorange.com")
    end

    def customer_key
      ENV["MINIORANGE_CUSTOMER_KEY"]
    end

    def customer_api_key
      ENV["MINIORANGE_CUSTOMER_API_KEY"]
    end

    def customer_token_key
      ENV["MINIORANGE_CUSTOMER_TOKEN_KEY"]
    end

    def microtime
      (Time.now.to_f * 1000).round
    end

    def headers
      current_time = microtime
      hash_value   = "#{customer_key}#{current_time}#{customer_api_key}"
      hash_digest  = Digest::SHA512.hexdigest hash_value
      {
        "Customer-Key"  => customer_key,
        "Timestamp"     => current_time.to_s,
        "Authorization" => hash_digest
      }
    end

    def make_query path, params
      query      = Net::HTTP::Post.new path
      headers.each do |key,value|
        query[key] = value
      end
      query.content_type = "application/json"
      query.body = JSON.dump params
      query
    end

    def perform_query query
      response = @http.request query
      if response.code == "200"
        JSON.parse response.body
      else
        throw response.body
      end
    end  
  end
end
