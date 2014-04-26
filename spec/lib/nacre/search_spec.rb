require 'spec_helper'

describe Nacre::Search do

  let(:options) do

  end

  subject { described_class.new(options) }

  describe '#results' do
    it 'should be a list' do
      expect(subject.results).to be_a(Array)
    end

    it 'each item should respond to #results' do
      expect(subject.results.first).to respond_to(:results)
    end
  end

  describe '#each' do
    it 'should return each result' do
      count = 0
      subject.each do |result|
        count += 1
      end
      expect(count).to eq(3)
    end
  end

  describe '#first' do
    it 'should return the first result' do

    end

    it 'should return two results with #first(2)' do

    end
  end

end
