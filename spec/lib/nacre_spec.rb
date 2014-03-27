describe Nacre do
  describe '.configure' do

    let(:user_id) { 'test_id' }

    it 'should allow configuration in a block' do
      Nacre.configure do |c|
        c.user_id = user_id
      end
      expect(Nacre.configuration.user_id).to eql(user_id)
    end

  end

  describe '.configuration' do
    pending 'specific configuration values'
  end
end
