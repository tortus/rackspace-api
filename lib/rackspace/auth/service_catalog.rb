# encoding: utf-8
module Rackspace

  # wrap the serviceCatalog portion of auth api response
  ServiceCatalog = Struct.new(:data) do
    def find(service_name)
      data.find {|s| s['name'] == service_name }
    end

    def endpoints(service_name)
      find(service_name).fetch('endpoints')
    end

    def endpoint_for_region(service_name, region)
      endpoints(service_name).find {|e| e['region'] == region }
    end
  end

end
