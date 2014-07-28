module Apitools
  module Middleware
    class Repository
      attr_accessor :middleware

      def content(path)
        raise 'needs to be reimplemented in subclasses'
      end

      def valid?
        Array(middleware).all?(&:valid?)
      end
    end
  end
end
