describe Apitools::Middleware::Repository do

  it 'has #content method' do
    expect{ subject.content('path') }.to raise_error(/needs to be reimplemented/)
  end

end
