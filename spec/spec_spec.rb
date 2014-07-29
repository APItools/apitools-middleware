describe Apitools::Middleware::Spec do
  let(:repo) { double('repository') }
  let(:path) { Pathname('some/path.json') }

  subject(:spec) { described_class.new(repo, path.to_s) }

  it 'trims path to just folder' do
    expect(spec.path).to eq(path.dirname.to_s)
  end

  it 'remembers manifest from path' do
    expect(spec.manifest_path).to eq(path.basename)
  end

  it 'allows setting manifest as json' do
    spec.manifest = '{ "name": "manifest" }'
    expect(spec.manifest).to eq(name: 'manifest')
  end

  context 'with valid manifest' do
    let(:manifest) do
      {
          name: 'middleware',
          author: '3scale',
          description: 'some description',
          version: '1.2.3-rc.2',
          endpoints: ['*'],
          files: ['middleware.lua']
      }
    end

    before do
      spec.manifest = manifest.to_json
      expect(repo).to receive(:content).with(Pathname('some/middleware.lua')).and_return('code')
    end

    expect_it { to be_valid }
  end

  context 'with empty manifest' do
    before do
      spec.manifest = {}.to_json
    end

    expect_it { to_not be_valid }
  end

  context 'spec with invalid file' do
    before do
      spec.manifest = fixture('test')
      expect(repo).to receive(:content)
    end

    expect_it { to_not be_valid }
  end
end
