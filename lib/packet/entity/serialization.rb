require 'active_support/concern'

module Packet
  module Entity
    module Serialization
      extend ActiveSupport::Concern

      class_methods do
        def serializer_key(value)
          define_method :to_value do
            instance_variable_get "@#{value}"
          end
        end
      end

      def to_hash
        instance_variables.reject { |ivar| [:@client].include?(ivar) }.map do |ivar|
          ival = instance_variable_get(ivar)
          [ivar.to_s.tr('@', ''), ival.respond_to?(:to_value) ? ival.to_value : instance_variable_get(ivar)]
        end.to_h
      end

      alias to_h to_hash
    end
  end
end
