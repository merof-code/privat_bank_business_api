# frozen_string_literal: true

require "spec_helper"
RSpec.describe PbAPI::Models::Balance do
  describe ".transformer" do
    it "returns a new instance of PbAPI::Transformers::BalanceTransformer" do
      transformer = described_class.transformer
      expect(transformer).to be_an_instance_of(PbAPI::Transformers::BalanceTransformer)
    end
  end
end
