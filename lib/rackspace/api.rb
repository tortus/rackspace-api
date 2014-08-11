# encoding: UTF-8
require 'net/https'
require 'json'

module Rackspace
  # Provides methods for generating HTTP requests to all API's,
  # wrapping the fairly awful Net::HTTP stuff. Only JSON is supported.
  class API

    # Logging the error message and exiting:
    #
    #     begin
    #       # some api call
    #     rescue Rackspace::API::Error => ex
    #       puts ex
    #       exit 1
    #     end
    #
    # Accessing parsed response JSON directly:
    #
    #     begin
    #       # some api call
    #     rescue Rackspace::API::Error => ex
    #       puts ex.json
    #     end
    class Error < StandardError
      attr_reader :response

      def initialize(response)
        @response = response
        super(response.body)
      end

      def to_s
        "<Rackspace::API::Error #{@response.code} - #{@response.message}: \"#{@response.body}\">"
      end
      alias_method :inspect, :to_s

      def json
        @json ||= JSON.parse(@response.body)
      end
    end


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
      response = Net::HTTP.start(uri.hostname, uri.port, :use_ssl => uri.port == 443) {|http|
        http.request(req)
      }
      if response.is_a?(Net::HTTPSuccess)
        json = JSON.parse(response.body)
        pp json if verbose
        json
      else
        raise Error.new(response)
      end
    end
  end
end
