require 'ostruct'
require 'json'
require 'forwardable'

module Apitools
  module Middleware
    class Manifest < OpenStruct

      extend Forwardable
      def_delegator :to_h, :empty?

      def self.parse(json)
        parsed = JSON.parse(json)
        new(parsed)

      rescue JSON::ParserError
        invalid_manifest
      end

      def self.invalid_manifest
        # TODO: create own class for invalid manifest
        new()
      end

      def ==(other)
        super or to_h == other
      end

      def valid?
        ! empty?
      end
    end
  end
end
