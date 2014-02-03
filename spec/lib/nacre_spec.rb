describe Nacre do
  describe '.configure' do

    let(:test_url) { 'test_url' }

    it 'should allow configuration in a block' do
      Nacre.configure do |c|
        c.base_url = test_url
      end
      expect(Nacre.configuration.base_url).to eql(test_url)
    end

  end

  describe '.configuration' do

  end
end
