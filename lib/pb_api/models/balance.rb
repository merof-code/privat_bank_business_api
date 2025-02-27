# typed: true

module PbAPI
  module Models
    class Balance < BaseStruct
      attribute :account,             Types::String
      attribute :currency,            Types::String
      attribute :counterparty_branch, Types::String
      attribute :account_branch,      Types::String
      attribute :account_name,        Types::String
      attribute :state,               Types::String
      attribute :account_type,        Types::String
      attribute :location,            Types::String

      # Decimal (monetary) attributes: using coercible decimals to convert string values
      attribute :balance_in,          Types::Coercible::Decimal
      attribute :balance_in_uah,      Types::Coercible::Decimal
      attribute :balance_out,         Types::Coercible::Decimal
      attribute :balance_out_uah,     Types::Coercible::Decimal
      attribute :turnover_debt,       Types::Coercible::Decimal
      attribute :turnover_debt_uah,   Types::Coercible::Decimal
      attribute :turnover_cred,       Types::Coercible::Decimal
      attribute :turnover_cred_uah,   Types::Coercible::Decimal

      # DateTime attributes: using Params coercion for strings formatted as dates
      attribute :last_operation_date_time, Types::Params::DateTime
      attribute :open_account_reg_date_time, Types::Params::DateTime
      attribute :open_account_sys_date_time, Types::Params::DateTime
      attribute :close_account_date_time,    Types::Params::DateTime

      # Boolean attribute
      attribute :final_balance, Types::Bool

      # List of monetary attribute names.
      MONEY_FIELDS = %i[
        balance_in balance_in_uah
        balance_out balance_out_uah
        turnover_debt turnover_debt_uah
        turnover_cred turnover_cred_uah
      ]

      # For each monetary field, define a method that returns a Money object.
      MONEY_FIELDS.each do |field|
        define_method("#{field}_money") do
          # Choose the currency based on the field name: if it ends with _uah, use "UAH", otherwise use the model's currency.
          currency_to_use = field.to_s.end_with?("_uah") ? "UAH" : currency
          Money.from_amount(public_send(field), currency_to_use)
        end
      end
    end
  end
end
