module FixturesSupport
  def fixture(name)
    path = File.join('spec', 'fixtures', 'middleware', name, 'apitools.json')
    File.read(path)
  end
end

RSpec.configure do |config|
  config.include FixturesSupport
end
