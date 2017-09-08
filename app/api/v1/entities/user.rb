module API
  module V1
    module Entities
      class User < Base
        expose :email,
          documentation: { type: 'String', desc: 'User email' }

        expose :type, as: :role,
          documentation: { type: 'String', desc: 'User role: "Admin", "Client" or "Agent"' }

        expose :confirmed_at, format_with: :iso_timestamp, if: -> (user, opts) { user.confirmed_at.present? },
          documentation: { type: 'String', desc: 'Used to indicate user confirmed email and account' }
      end
    end
  end
end
