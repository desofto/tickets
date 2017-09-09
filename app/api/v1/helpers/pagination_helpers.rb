module API
  module V1
    module Helpers
      module PaginationHelpers
        def paginate_collection(collection, params = {})
          skip = params[:skip].presence&.to_i || 0
          per_page = params[:per_page].presence&.to_i || 50
          collection[skip...(skip + per_page)]
        end
      end
    end
  end
end
