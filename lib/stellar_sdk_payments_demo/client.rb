module StellarSdkPaymentsDemo
  class Client
    attr_reader :client

    class << self
      def create_account(source, destination, balance)
        new().create_account(source, destination, balance)
      end

      def send_payment(source, destination, amount)
        new().send_payment(source, destination, amount)
      end
    end

    def initialize
      @client = Stellar::Client.default_testnet
    end

    def create_account(source, destination, balance)
      client.create_account(
        funder: Stellar::Account.from_seed(source),
        account: Stellar::Account.from_address(destination),
        starting_balance: balance,
      )
    end

    def send_payment(source, destination, amount)
      client.send_payment(
        from:   Stellar::Account.from_seed(source),
        to:     Stellar::Account.from_address(destination),
        amount: Stellar::Amount.new(amount)
      )
    end

  end
end