# encoding: UTF-8
module Rackspace
  class Status < API

    def initialize(session, options = {})
      endpoint = "https://dns.api.rackspacecloud.com/v1.0/#{session.tenant_id}/status/"
      super(endpoint, session.auth_token, options)
    end

  end
end
