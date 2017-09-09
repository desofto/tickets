RSpec.configure do |config|
  config.before(:each, :js) do
    Capybara.current_driver = Capybara.javascript_driver
  end

  config.prepend_after(:each, :js) do
    Capybara.current_session.driver.reset!
    Capybara.reset_sessions!
  end
end

Capybara.configure do |config|
  config.javascript_driver = :webkit
end

Capybara::Webkit.configure do |config|
  config.allow_url('maps.google.com')
end

Capybara::Webkit.configure do |config|
  # config.debug = true
  config.block_url('fonts.googleapis.com')
  config.skip_image_loading
  config.timeout = 15
end

Capybara.default_max_wait_time = 15

module FeatureMacros
  extend RSpec::Matchers::DSL

  matcher :update do |object, attr_name|
    match do |block|
      if block.is_a? Proc
        old_attributes = attributes(object, attr_name)
        block.call
      else
        attr_name = object
        object = block
        old_attributes = attributes(object, attr_name)
      end
      begin
        Timeout.timeout(Capybara.default_max_wait_time) do
          sleep(0.1) until attributes(object.try(:reload), attr_name) != old_attributes
          true
        end
      rescue TimeoutError
        false
      end
    end

    def supports_block_expectations?
      true
    end

    # Retrieves current state of the object. Checks only attr_name if specified
    # rubocop:disable Metrics/PerceivedComplexity
    def attributes(object, attr_name)
      if object.is_a?(ActiveRecord::Associations::CollectionProxy) && attr_name.blank?
        arr = object.map(&:attributes).map { |k, v| [k, v.try(:to_s)] }.to_h
        if attr_name.present?
          arr = arr.map do |el|
            if attr_name.is_a? Array
              attr_name.map { |k| [k, el.send(k)] }.to_h
            else
              el.send(attr_name)
            end
          end
        end
        arr
      else
        if attr_name.is_a? Array
          attrs = attr_name.map { |k| [k, object.send(k)] }.to_h
        elsif attr_name.present?
          attrs = attr_name.to_s.split('.').inject(object) { |acc, elem| acc.nil? ? nil : acc.send(elem) }
          attrs = attrs.attributes if attrs.respond_to? :attributes
        else
          attrs = object.attributes
        end
        attrs.is_a?(Hash) ? attrs.map { |k, v| [k, v.try(:to_s)] }.to_h : attrs
      end
    end
  end

  matcher :become do |expected_value|
    match do |block|
      begin
        Timeout.timeout(Capybara.default_max_wait_time) do
          sleep(0.1) until block.call == expected_value
          true
        end
      rescue TimeoutError
        false
      end
    end

    def supports_block_expectations?
      true
    end
  end
end

RSpec.configure do |config|
  config.include FeatureMacros
end
