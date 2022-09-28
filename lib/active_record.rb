# frozen_string_literal: true

require "active_record/connection_adapter"

module ActiveRecord
  class Base
    class << self
      def primary_abstract_class
        # Not implemented
      end

      def establish_connection(options)
        @@connection = ConnectionAdapter::SqliteAdapter.new(options[:database])
      end

      def connection
        @@connection
      end

      def find(id)
        attributes = connection
          .execute("SELECT * FROM posts where id=#{id.to_i}")
          .first

        new(attributes)
      end
    end

    def initialize(attributes = {})
      @attributes = attributes
    end

    def id
      @attributes[:id]
    end

    def title
      @attributes[:title]
    end
  end
end
