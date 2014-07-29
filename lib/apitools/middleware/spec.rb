require 'pathname'
require 'semantic'
require 'forwardable'
require 'apitools/middleware/manifest'

module Apitools
  module Middleware
    class Spec
      MANIFEST_FILE = 'apitools.json' # should be apitools.json

      attr_reader :repo, :path, :manifest_path

      extend Forwardable
      def_delegators :manifest, :name, :description, :author, :endpoints, :files

      def initialize(repo, path)
        @repo = repo
        pathname = Pathname(path)
        @path = pathname.dirname
        @manifest_path = pathname.basename || MANIFEST_FILE
      end

      def manifest=(json)
        @manifest = Manifest.parse(json)
      end

      def manifest
        @manifest ||= Manifest.parse(load_manifest)
      end

      def code
        @code ||= load_code
      end

      def endpoint
        Array(endpoints).first
      end

      def files
        Array(manifest.files)
      end

      def version
        Semantic::Version.new(manifest.version)
      rescue ArgumentError
        false
      end

      def valid?
        required_attributes = [name, path, author, endpoint, version, description]
        return unless required_attributes.all?

        lua_files = Array(files).map { |file| content(file) }
        lua_files.none?{ |file| !file || file.nil? || file.empty? }
      end

      protected

      def content(path)
        @repo.content @path.join(path)
      end

      def load_manifest
        content @manifest_path
      end

      def load_code
        content files.first
      end
    end
  end
end
