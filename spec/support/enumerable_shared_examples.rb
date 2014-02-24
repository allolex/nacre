require 'spec_helper'

shared_examples_for 'Enumerable' do
  it 'should respond to #each' do
    expect(subject).to respond_to(:each)
  end

  it 'should respond to #count' do
    expect(subject).to respond_to(:count)
  end

  it 'should respond to #first' do
    expect(subject).to respond_to(:first)
  end
end

