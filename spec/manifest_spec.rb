describe Apitools::Middleware::Manifest do

  context 'invalid manifest' do
    subject(:invalid_manifest) { described_class.invalid_manifest }
    it { is_expected.to_not be_valid }
  end

  context 'empty manifest' do
    subject(:empty_manifest) { described_class.new }
    it { is_expected.to_not be_valid }
  end

  context 'manifest with something' do
    subject(:manifest) { described_class.new(value: true) }
    it { is_expected.to be_valid }
  end
end
