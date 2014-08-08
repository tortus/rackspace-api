# encoding: UTF-8
module Rackspace
  # Cloud DNS API operations:
  # http://docs.rackspace.com/cdns/api/v1.0/cdns-devguide/content/API_Operations_Wadl-d1e2648.html
  class CloudDNS < API

    def initialize(session, options = {})
      endpoint = session.service_catalog.endpoints('cloudDNS').fetch(0).fetch('publicURL')
      super(endpoint, session.auth_token, options)
    end

    def list_domains(options = {})
      limit = options.delete(:limit) { 10 }
      offset = options.delete(:offset) { 0 }
      get "domains", :limit => limit, :offset => offset
    end

    # http://docs.rackspace.com/cdns/api/v1.0/cdns-devguide/content/GET_searchDomains_v1.0__account__domains_search_domains.html
    def search_domains(name)
      get "domains/search", :name => name
    end

    # to correctly structure domain data, see:
    # http://docs.rackspace.com/cdns/api/v1.0/cdns-devguide/content/POST_createDomain_v1.0__account__domains_domains.html
    def create_domains(domains)
      post "domains", {}, "domains" => domains
    end

    # takes array of domain strings in bind 9 format
    def import_domains(domains)
      post "domains/import", {}, "domains" => domains.map {|domain|
        {"contentType" => "BIND_9", "contents" => domain}
      }
    end
  end

end
