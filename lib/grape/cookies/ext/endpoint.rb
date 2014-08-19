module Grape
  module Cookies
    module Ext
      module Endpoint
        extend ActiveSupport::Concern

        included do
        end

        def cookies
          request.cookie_jar
        end

        module ClassMethods
        end
      end
    end
  end
end
