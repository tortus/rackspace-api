# encoding: UTF-8
module Rackspace
  # Cloud DNS API operations:
  # http://docs.rackspace.com/cdns/api/v1.0/cdns-devguide/content/API_Operations_Wadl-d1e2648.html
  class CloudDNS < API
    MAX_ENTITIES = 100

    def initialize(session, options = {})
      endpoint = session.service_catalog.endpoints('cloudDNS').fetch(0).fetch('publicURL')
      super(endpoint, session.auth_token, options)
    end

    def status(key, params = {})
      get "status/#{key}", params
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
    def create_domains(domains, subdomains = [])
      if domains.length > 100
        raise "Limit is 100 entities per request (including records)"
      end
      post "domains", {}, "domains" => domains, "subdomains" => subdomains
    end

    # takes array of domain strings in bind 9 format
    def import_domains(domains)
      post "domains/import", {}, "domains" => domains.map {|domain|
        {"contentType" => "BIND_9", "contents" => domain}
      }
    end

    # takes array of records
    def create_records(domain_id, records)
      post "domains/#{domain_id}/record", {}, {"records" => records}
    end

    def get_records(domain_id)
      get "domains/#{domain_id}/records"
    end
  end

end
