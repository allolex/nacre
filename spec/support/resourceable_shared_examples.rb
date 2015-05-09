shared_examples_for "Resourceable" do

  subject { described_class.new(params) }

  class TestResource
    def initialize(*); end
  end

  let!(:class_with_resource) do
    Class.new(described_class) do
      def self.resource_class
        TestResource
      end
    end
  end

  describe "#resource_class" do

    context "when defined by the subclass" do

      subject { class_with_resource.new(params) }

      it "should return the resource class" do
        expect(subject.class.resource_class).to eq(TestResource)
      end
    end

    context "when not defined by the subclass" do
      it "should raise an exception" do
        expect { described_class.resource_class }.to raise_error(NotImplementedError)
      end

      it "should provide a useful error message" do
        expect { subject.class.resource_class }.to raise_error(
          NotImplementedError,
          /must implement .resource_class/
        )
      end
    end
  end

  describe ".resource_name" do

    context "when not overridden" do
      context "when .resource_class is defined" do

        subject { class_with_resource.new(params) }

        it "should return the resource class name in lowercase" do
          expect(subject.class.resource_name).to eq("testresource")
        end
      end

      context "when .resource_class is not defined" do
        it "should raise an exception" do
          expect { subject.class.resource_name }.to raise_error(NotImplementedError)
        end
      end
    end

    context "when overridden" do

      @name = "service_name_override"

      let(:service_name) do
        Class.new(class_with_resource) do
          def self.resource_name
            @name
          end
        end
      end

      subject { service_name.new(params) }

      it "should return the new value" do
        expect(subject.class.resource_name).to eq(@name)
      end
    end

  end
end
