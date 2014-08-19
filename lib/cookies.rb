require 'grape/cookies/version'

require 'rack'
require 'active_support/concern'
require 'grape'
require 'grape/api'
require 'grape/endpoint'

if defined? Grape::Cookies
  warn "[DEPRECATION] your using an older version of `Grape`.  Please update your  `Grape` version."
  Grape.send(:remove_const, 'Cookies'.to_sym)
end

module Grape
  module Cookies
    require 'grape/cookies/configuration'
    require 'grape/cookies/dsl/configuration'
    require 'grape/cookies/middleware/env_setup'
    require 'grape/cookies/ext/endpoint'
    require 'grape/cookies/ext/request'
    require 'grape/cookies/ext/api'
    require 'grape/cookies/ext/cookie_jar'

    include Configuration.module(
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
end

Grape::Endpoint.send(:include, Grape::Cookies::Ext::Endpoint)
Grape::Request.send(:include, Grape::Cookies::Ext::Request)

unless ActionDispatch::Cookies::CookieJar.instance_methods.include? :read
  ActionDispatch::Cookies::CookieJar.send(:include, Grape::Cookies::Ext::CookieJar)
end
