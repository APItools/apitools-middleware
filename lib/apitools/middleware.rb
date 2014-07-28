require 'apitools/middleware/version'

module Apitools
  module Middleware
    autoload :Repository, 'apitools/middleware/repository'
    autoload :LocalRepository, 'apitools/middleware/local_repository'
    autoload :Spec, 'apitools/middleware/spec'
    autoload :Manifest, 'apitools/middleware/manifest'
  end
end
