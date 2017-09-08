module API
  module V1
    module Entities
      class User < Base
        expose :email
        expose :role do |user|
          user.type
        end
        expose :auth_token
      end
    end
  end
end
