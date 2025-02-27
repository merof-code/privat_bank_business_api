module PbAPI
  # BaseStruct is a parent class for all models that require a transformer.
  # It dynamically infers the transformer class based on the name of the child class.
  #
  # Example:
  #   class Balance < BaseStruct; end
  #   Balance.transformer # Returns PbAPI::Transformers::BalanceTransformer.new
  #
  #   class Transaction < BaseStruct; end
  #   Transaction.transformer # Returns PbAPI::Transformers::TransactionTransformer.new
  #
  # This ensures that all subclasses of BaseStruct automatically have a transformer method
  # without needing to redefine it in each subclass.
  class BaseStruct < Dry::Struct
    # Returns an instance of the transformer class inferred from the child class name.
    # Example:
    #   class Balance < BaseStruct; end
    #   Balance.transformer # Returns PbAPI::Transformers::BalanceTransformer.new
    def self.transformer
      transformer_class_name = "#{name}Transformer"
      transformer_class = PbAPI::Transformers.const_get(transformer_class_name)
      transformer_class.new
    end
  end
end
