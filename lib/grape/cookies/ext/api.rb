require 'action_dispatch/middleware/cookies'
require 'action_dispatch/middleware/session/cookie_store'
module Grape
  module Cookies
    module Ext
      module API
        extend ActiveSupport::Concern

        included do

          use Cookies::Middleware::EnvSetup
          use ActionDispatch::Cookies

        end

        module ClassMethods
        end
      end
    end
  end
end