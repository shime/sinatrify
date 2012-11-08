module Sinatrify
  module DSL
    extend ::ActiveSupport::Concern

    included do
      class_attribute :sinatrify_router
      self.sinatrify_router = ActionDispatch::Routing::RouteSet.new
    end

    module ClassMethods

      def call(env)
        sinatrify_router.call(env)
      end

      def mapper
        @mapper ||= ActionDispatch::Routing::Mapper.new(sinatrify_router)
      end

      %w(get post put delete patch).each do |verb|
        class_eval <<-RUBY, __FILE__, __LINE__ + 1
          def #{verb}(path, options = {}, &block)
            define_action "#{verb}", path, options, block 
          end
        RUBY
      end

      private

      def define_action(verb, path, options, block)
        action_name   = "[#{verb}] #{path}"
        define_method action_name, &block
        options.merge! :via => verb, :to => action(action_name)
        mapper.send(verb, path, options)
      end
    end
  end
end
