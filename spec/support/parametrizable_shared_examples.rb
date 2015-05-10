shared_examples_for "Parametrizable" do

  describe "#params" do
    it "should output the same parameters as in the input" do
      expect(subject.params).to eql(params)
    end
  end

end
