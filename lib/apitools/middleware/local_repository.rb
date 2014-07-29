require 'pathname'
require 'apitools/middleware/repository'

module Apitools
  module Middleware
    class LocalRepository < Repository
      PATTERN = "*/#{Spec::MANIFEST_FILE}"

      def initialize(path = Pathname.pwd.join('middleware'), pattern = PATTERN)
        @path = Pathname(path).expand_path
        @manifests = Pathname.glob(@path.join(pattern))
      end

      def content(file)
        Pathname(file).read
      rescue Errno::ENOENT
        false
      end

      def middleware
        @middleware ||= @manifests.map{ |manifest| Apitools::Middleware::Spec.new(self, manifest) }
      end
    end
  end
end
