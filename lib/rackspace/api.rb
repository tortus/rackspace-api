# encoding: UTF-8
module Rackspace
  # Provides methods for generating HTTP requests to all API's,
  # wrapping the fairly awful Net::HTTP stuff. Only JSON is supported.
  class API

    attr_accessor :endpoint, :auth_token, :verbose

    def initialize(endpoint, auth_token, options = {})
      @endpoint = endpoint
      @auth_token = auth_token
      @verbose = options.delete(:verbose) { false }
    end

    def get(*args)
      request(Net::HTTP::Get, *args)
    end

    def post(*args)
      request(Net::HTTP::Post, *args)
    end

    private

    def request(request_klass, path, params = {}, body = nil)
      uri = URI("#{endpoint}/#{path}")
      # encode URL parameters
      if params && params.any?
        uri.query = URI.encode_www_form(params)
      end
      # serialize body to JSON
      if body && !body.is_a?(String)
        body = JSON.generate(body)
      end

      req = request_klass.new(uri)
      req.body = body if body
      req['Accept'] = 'application/json'
      req['Content-Type'] = 'application/json'
      req['X-Auth-Token'] = auth_token if auth_token
      puts "Request:\n  #{req.inspect} #{uri}:#{uri.port}\n  #{req.body}" if verbose

      puts "Response:" if verbose
      response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: uri.port == 443) {|http|
        http.request(req)
      }
      if response.is_a?(Net::HTTPSuccess)
        json = JSON.parse(response.body)
        pp json if verbose
        json
      else
        puts response.inspect
        puts response.body
        raise StandardError, "API request failed"
      end
    end
  end
end
