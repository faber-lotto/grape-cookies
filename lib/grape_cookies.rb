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

  include GrapeCookies::Configuration.module(
            :signed_cookie_salt,
            :encrypted_cookie_salt,
            :encrypted_signed_cookie_salt,
            :secret_token,
            :secret_key_base,
            :cookies_serializer
          )

  # setup defaults
  configure do
    signed_cookie_salt 'signed cookie'
    encrypted_cookie_salt 'encrypted cookie'
    encrypted_signed_cookie_salt 'signed encrypted cookie'
    secret_token 'secret_token'
    secret_key_base nil || ENV['SECRET_KEY_BASE']
    cookies_serializer :json
  end
end

require 'grape'
require 'grape/api'
require 'grape/endpoint'

Grape::Endpoint.send(:include, GrapeCookies::Ext::Endpoint)
Grape::Request.send(:include, GrapeCookies::Ext::Request)

unless ActionDispatch::Cookies::CookieJar.instance_methods.include? :read
  ActionDispatch::Cookies::CookieJar.send(:include, GrapeCookies::Ext::CookieJar)
end
