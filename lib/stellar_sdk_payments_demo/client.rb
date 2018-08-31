module StellarSdkPaymentsDemo
  class Client
    attr_reader :client

    class << self
      def create_account(source, destination)
        new().create_account(source, destination)
      end
    end

    def initialize
      @client = Stellar::Client.default_testnet
    end

    def create_account(source, destination)
      client.create_account(
        funder: Stellar::Account.from_seed(source),
        account: Stellar::Account.from_address(destination),
        starting_balance: 100,
      )
    end

  end
end