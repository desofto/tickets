module ApiHelpers
  def json
    @json ||= JSON.parse(response.body)
  end
end

RSpec.configure do |config|
  config.include ApiHelpers, type: :api
end
