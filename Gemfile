source 'https://rubygems.org'

# Specify your gem's dependencies in rackspace-api.gemspec
gemspec

# Skip guard if we are on 1.8 (it won't work).
# Guard also needs to be in its own group so Travis won't waste time installing it.
if Gem::Version.new(RUBY_VERSION.dup) >= Gem::Version.new("1.9.3")
  group :guard do
    gem 'ruby_gntp'
    gem 'guard-rspec'
  end
end
