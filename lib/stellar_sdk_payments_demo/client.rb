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

      def change_trust(asset_type, asset_code, asset_issuer, destination)
        new().change_trust(asset_type, asset_code, asset_issuer, destination)
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

    def change_trust(asset_type, asset_code, asset_issuer, destination)
      asset_type = asset_type.to_sym
      asset_issuer = Stellar::Account.from_seed(asset_issuer)
      client.change_trust(
        asset: [asset_type, asset_code, asset_issuer.keypair],
        source: Stellar::Account.from_seed(destination),
      )
    end
  end
end