require "spec_helper"

describe Nacre::Configuration do

  let(:config) { Nacre::Configuration.new(args) }

  let(:args) { {} }

  context "environment defaults" do
    it "should get the User ID" do
      expect(config.user_id).to eql(ENV["NACRE_USER_ID"])
    end

    it "should get the User Email" do
      expect(config.email).to eql(ENV["NACRE_EMAIL"])
    end

    it "should get the User Password" do
      expect(config.password).to eql(ENV["NACRE_PASSWORD"])
    end
  end

  context "URLs from configuration" do
    it "has the correct precision for money values" do
      expect(config.value_precision).to eql("6")
    end

    it "should have the correct base URL" do
      expect(config.base_url).to eql("https://ws-eu1.brightpearl.com")
    end

    it "should have the correct Resource URL" do
      expect(config.resource_url).to eql("https://ws-eu1.brightpearl.com/public-api/%s" % [ENV["NACRE_USER_ID"]])
    end

    it "should have the correct auth URL" do
      expect(config.auth_url).to eql("https://ws-eu1.brightpearl.com/%s/authorise" % [ ENV["NACRE_USER_ID"] ])
    end
  end

  context "with valid arguments" do
    let(:args) do
      {
        email: "test@example.com",
        password: "password",
      }
    end

    it "should be valid" do
      expect(config).to be_valid
    end
  end

  context "with invalid arguments" do
    let(:args) do
      {
        email: "",
      }
    end

    it "should not be valid" do
      expect(config).to_not be_valid
    end
  end
end
