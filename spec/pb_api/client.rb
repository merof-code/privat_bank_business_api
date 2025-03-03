# spec/pb_api/client_spec.rb
require "spec_helper"

RSpec.describe PbAPI::Client do
  describe "#api_key" do
    it "returns the correct API key" do
      client = PbAPI::Client.new(api_key: "test")
      expect(client.api_key).to eq("test")
    end
  end
end
