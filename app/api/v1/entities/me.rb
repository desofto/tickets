module API
  module V1
    module Entities
      class Me < User
        expose :auth_token,
          documentation: { type: 'String', desc: 'Token for accessing API after authentication' }
      end
    end
  end
end
