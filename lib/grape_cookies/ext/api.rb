require 'action_dispatch/middleware/cookies'
require 'action_dispatch/middleware/session/cookie_store'

module GrapeCookies
  module Ext
    module API
      extend ActiveSupport::Concern

      included do

        use GrapeCookies::Middleware::EnvSetup
        use ActionDispatch::Cookies

      end

      module ClassMethods
      end
    end
  end
end
