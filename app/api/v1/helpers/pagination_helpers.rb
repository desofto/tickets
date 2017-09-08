module API
  module V1
    module Helpers
      module PaginationHelpers
        def paginate_collection(collection, params = {})
          page = params[:page].present? ? params[:page].to_i : 1
          per_page = params[:per_page].present? ? params[:per_page].to_i : 50
          collection[((page.to_i - 1) * per_page)...(page.to_i * per_page)]
        end
      end
    end
  end
end
