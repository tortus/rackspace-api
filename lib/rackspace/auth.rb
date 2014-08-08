# encoding: UTF-8
require "rackspace/auth/session"
require "rackspace/auth/service_catalog"

module Rackspace
  class Auth < API

    attr_accessor :username, :api_key

    def initialize(username, api_key, options = {})
      @username = username
      @api_key = api_key
      super("https://identity.api.rackspacecloud.com/v2.0", nil, options)
    end

    def authenticate
      Session.new(tokens)
    end

    # memoize #get_tokens
    def tokens
      @tokens ||= get_tokens
    end

    # POST /tokens
    def get_tokens
      post "tokens", {}, "auth" => {
        "RAX-KSKEY:apiKeyCredentials" => {
          "username" => username,
          "apiKey" => api_key
        }
      }
    end
  end
end
