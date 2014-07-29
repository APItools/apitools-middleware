require 'pathname'
require 'semantic'
require 'forwardable'
require 'apitools/middleware/manifest'

module Apitools
  module Middleware
    class Spec
      MANIFEST_FILE = Pathname('apitools.json') # should be apitools.json

      attr_reader :repo

      extend Forwardable
      def_delegators :manifest, :name, :description, :author, :endpoints

      def initialize(repo, path)
        @repo = repo
        @path, @manifest_file = extract_path_and_manifest(path)
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

      def path
        @path.to_s
      end

      def manifest_file
        @manifest_file.to_s
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

      def extract_path_and_manifest(path)
        pathname = Pathname(path)

        if pathname.extname.empty? # no manifest at the end
          [pathname, MANIFEST_FILE]
        else
          [pathname.dirname, pathname.basename]
        end
      end

      protected

      def content(path)
        @repo.content @path.join(path)
      end

      def load_manifest
        content @manifest_file
      end

      def load_code
        content files.first
      end
    end
  end
end
