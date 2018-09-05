module StellarSdkPaymentsDemo
  class Client
    attr_reader :client

    class << self
      def create_account(source, destination, balance)
        new().create_account(source, destination, balance)
      end

      def send_payment(source, destination, amount, asset = nil, asset_type = nil)
        new().send_payment(source, destination, amount, asset, asset_type)
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

    def send_payment(source, destination, amount, asset = nil, asset_type = nil)
      source = Stellar::Account.from_seed(source)
      destination = Stellar::Account.from_address(destination)

      amount = if asset.nil?
                Stellar::Amount.new(amount)
              else
                asset = if asset_type == "alphanum4"
                          Stellar::Asset.alphanum4(asset, source.keypair) if !asset.nil?
                        elsif asset_type == "alphanum12"
                          Stellar::Asset.alphanum12(asset, source.keypair) if !asset.nil?
                        end
                Stellar::Amount.new(amount, asset)
              end

      client.send_payment(
        from:   source,
        to:     destination,
        amount: amount
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