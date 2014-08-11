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

## Usage

```ruby
session = Rackspace.authenticate(username, api_key)
dns = Rackspace::CloudDNS.new(session)
dns.list_domains(:limit => 20, :offset => 10)
```

## API Calls

You may execute free-form requests against the API, like so:

```ruby
dns.post "action", {:param => :value}, {"request body" => "json goes here"}
# returns parsed json (as ruby objects)
```
The request body can be a string, or an object that will automatically be
serialized as JSON. The return value will be JSON represented as ruby objects.

In some cases, there are shortcuts for various API calls. Where possible, these
attempt to simplify the task of constructing and validating input.
```ruby
# Instead of:
dns.post "domains/import", {}, {"domains" => [
  {"contentType" => "BIND_9", "contents" => "serialized domain in bind 9 format"},
  {"contentType" => "BIND_9", "contents" => "another domain"}
]}

# You may do:
dns.import_domains(["serialized domain in bind 9 format", "another domain"])
```

## Error handling

If any API call returns a non-success response code, an instance of
Rackspace::API::Error will be raised.

```ruby
# logging the error message and exiting:
begin
  # some api call
rescue Rackspace::API:Error => ex
  puts ex
  exit 1
end

# Accessing error response JSON directly:
rescue Rackspace::API:Error => ex
  puts ex.json
end

# Accessing the HTTPResponse object:
rescue Rackspace::API:Error => ex
  puts ex.response
end
```

## Cloud DNS

See http://docs.rackspace.com/cdns/api/v1.0/cdns-devguide/content/API_Operations_Wadl-d1e2648.html
to understand the expected input and output of any operation.
