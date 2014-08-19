module Grape
  module Cookies
    module Middleware
      class EnvSetup

        def self.settings
          Cookies.settings
        end

        def self.key_generator
          @caching_key_generator ||= begin
            if settings[:secret_key_base].blank?
              raise ArgumentError, 'A secret is required to generate an integrity hash ' \
                                 'for cookie session data. Set a secret_key_base.'
            end

            key_generator = ActiveSupport::KeyGenerator.new(settings[:secret_key_base], iterations: 1000)
            ActiveSupport::CachingKeyGenerator.new(key_generator)
          end
        end

        def self.settings_for_env
          @settings_for_env ||= {
              ActionDispatch::Cookies::GENERATOR_KEY => key_generator,
              ActionDispatch::Cookies::SIGNED_COOKIE_SALT => settings[:signed_cookie_salt],
              ActionDispatch::Cookies::ENCRYPTED_COOKIE_SALT => settings[:encrypted_cookie_salt],
              ActionDispatch::Cookies::ENCRYPTED_SIGNED_COOKIE_SALT => settings[:encrypted_signed_cookie_salt],
              ActionDispatch::Cookies::SECRET_TOKEN => settings[:secret_token],
              ActionDispatch::Cookies::SECRET_KEY_BASE => settings[:secret_key_base],
              ActionDispatch::Cookies::COOKIES_SERIALIZER => settings[:cookies_serializer]
          }.freeze
        end

        def self.reset_settings_for_env!
          @caching_key_generator = nil
          @settings_for_env = nil
        end

        def initialize(app)
          @app = app
        end

        def call(env)
          env.merge!(self.class.settings_for_env)

          @app.call(env)
        end
      end
    end
  end
end
