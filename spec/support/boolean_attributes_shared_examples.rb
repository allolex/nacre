require 'spec_helper'

shared_examples_for 'a boolean attribute' do

  context 'when using the default params' do
    it 'should be false' do
      expect(subject.send("#{example.metadata[:method_name]}")).to eq(false)
    end
  end

  it 'should be true when it is set to true' do
    subject.send("#{example.metadata[:method_name]}=",true)
    expect(subject.send("#{example.metadata[:method_name]}")).to eq(true)
  end

  it 'should be true when it is set to "true"' do
    subject.send("#{example.metadata[:method_name]}=",'true')
    expect(subject.send("#{example.metadata[:method_name]}")).to eq(true)
  end

  it 'should be false when it is set to false' do
    subject.send("#{example.metadata[:method_name]}=",false)
    expect(subject.send("#{example.metadata[:method_name]}")).to eq(false)
  end

  it 'should be false when it is set to "false"' do
    subject.send("#{example.metadata[:method_name]}=",'false')
    expect(subject.send("#{example.metadata[:method_name]}")).to eq(false)
  end

  ['1',1,nil,'::','foo'].each do |value|
    it "should be false when set to #{value.to_s}" do
      subject.send("#{example.metadata[:method_name]}=",value)
      expect(subject.send("#{example.metadata[:method_name]}")).to eq(false)
    end
  end
end
