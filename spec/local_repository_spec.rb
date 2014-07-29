describe Apitools::Middleware::LocalRepository do

  subject(:repository) { described_class.new('spec/fixtures/middleware') }
  let(:middleware) { repository.middleware }

  it 'has 3 middlewares' do
    expect(middleware.length).to eq(3)
  end

  context 'all middlewares are valid' do
    before do
      middleware.each {|m| expect(m).to receive(:valid?).and_return(true) }
    end
    expect_it { to be_valid }
  end

  context 'some middleware is invalid' do
    expect_it { to_not be_valid }
  end

  context 'first middleware' do
    let(:first) { subject.middleware.first }

    it 'reads the manifest' do
      expect(first.manifest).to be_valid
    end
  end

  context 'second middleware' do
    let(:second) { subject.middleware[1] }

    it 'does not crash' do
      expect(second.manifest).not_to be_valid
    end
  end

  context 'third middleware' do
    let(:third) { subject.middleware.last }

    it 'is not valid' do
      expect(third).not_to be_valid
    end
  end
end
