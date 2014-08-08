require "rackspace/version"
require "rackspace/api"
require "rackspace/auth"
require "rackspace/cloud_dns"

module Rackspace

  def self.authenticate(*args)
    Auth.new(*args).authenticate
  end

end
