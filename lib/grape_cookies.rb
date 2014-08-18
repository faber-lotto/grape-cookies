require 'grape_cookies/version'

require 'rack'
require 'active_support/concern'

module GrapeCookies
  require 'grape_cookies/configuration'
  require 'grape_cookies/dsl/configuration'
  require 'grape_cookies/middleware/env_setup'
  require 'grape_cookies/ext/endpoint'
  require 'grape_cookies/ext/request'
  require 'grape_cookies/ext/api'
  require 'grape_cookies/ext/cookie_jar'
end

require 'grape'
require 'grape/api'
require 'grape/endpoint'

Grape::Endpoint.send(:include, GrapeCookies::Ext::Endpoint)
Grape::Request.send(:include, GrapeCookies::Ext::Request)

unless ActionDispatch::Cookies::CookieJar.instance_methods.include? :read
  ActionDispatch::Cookies::CookieJar.send(:include, GrapeCookies::Ext::CookieJar)
end
