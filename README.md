# Rackspace

Ruby classes to make interacting with the Rackspace JSON API
simpler. Currently only functions synchronously.

## Installation

Add this line to your application's Gemfile:

    gem 'rackspace-api'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rackspace-api

## Cloud DNS usage

```ruby
session = Rackspace.authenticate(username, api_key)
dns = Rackspace::CloudDNS.new(session)
dns.list_domains(:limit => 20, :offset => 10)
# returns parsed json (as ruby objects)
```
