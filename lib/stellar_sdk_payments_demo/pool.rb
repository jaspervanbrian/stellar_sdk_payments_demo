module StellarSdkPaymentsDemo
  class Pool
    attr_reader :client
    attr_accessor :channel_accounts

    def initialize(accounts = [])
      @client = Stellar::Client.default_testnet
      @channel_accounts = accounts
    end

    def method_missing(method_name, args)
      client.send(method_name, args)
    end
  end
end