# encoding: utf-8
module Rackspace

  # wrap the authentication API response
  Session = Struct.new(:data) do
    def auth_token
      data.fetch('access').fetch('token').fetch('id')
    end

    def tenant_id
      data.fetch('access').fetch('token').fetch('tenant').fetch('id')
    end

    def service_catalog
      ServiceCatalog.new(data.fetch('access').fetch('serviceCatalog'))
    end
  end

end
