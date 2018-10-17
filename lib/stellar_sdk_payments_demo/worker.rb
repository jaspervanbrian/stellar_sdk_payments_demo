require 'sidekiq'
require 'stellar-sdk'

Sidekiq.configure_client do |config|
  config.redis = { db: 1 }
end

Sidekiq.configure_server do |config|
  config.redis = { db: 1 }
end

module StellarSdkPaymentsDemo
  class Worker
    include Sidekiq::Worker
    
    # @channel_accounts = []
    # @pending_transactions = []
    # @pending_tx_options = []
    # @client = Stellar::Client.default_testnet

    # @pending_transactions.define_singleton_method(:process) do |new_tx, channel_accounts|
    #   self << new_tx
    #   if channel_accounts.any?
    #     tx = self.shift
    #     tx.call
    #   end
    # end

    # @channel_accounts.define_singleton_method(:unlock) do |account, pending_transactions|
    #   puts "Finished."
    #   self << account
    #   if pending_transactions.any?
    #     tx = pending_transactions.shift
    #     tx.call
    #   end
    # end

    # class << self
    #   attr_accessor :channel_accounts
    #   attr_accessor :pending_transactions
    #   attr_accessor :pending_tx_options
    #   attr_accessor :client

    #   @channel_accounts = []
    #   @client = Stellar::Client.default_testnet
    #   @pending_transactions = []
    #   @pending_tx_options = []

    #   @pending_transactions.define_singleton_method(:process) do |new_tx, channel_accounts|
    #     self << new_tx
    #     if channel_accounts.any?
    #       tx = self.shift
    #       tx.call
    #     end
    #   end

    #   @channel_accounts.define_singleton_method(:unlock) do |account, pending_transactions|
    #     puts "Finished."
    #     self << account
    #     if pending_transactions.any?
    #       tx = pending_transactions.shift
    #       tx.call
    #     end
    #   end

    #   def method_missing(method_name, **options)
    #     tx = Proc.new { Worker.perform_async(method_name) }
    #     Worker.pending_tx_options << options
    #     Worker.pending_transactions.process(tx, channel_accounts)
    #   end
    # end

    def perform(method_name, options)
      # p options
      # p options["source_account"]
      # p options["to"]
      # p options["amount"]
      redis = Redis.new
      client = Stellar::Client.default_testnet
      channel_account = redis.lpop("locked")

      # response = client.send(method_name, options)
      response = client.send_payment(
        from:   Stellar::Account.from_seed(channel_account),
        to:     Stellar::Account.from_address(options["to"]),
        source_account: Stellar::Account.from_seed(options["source_account"]),
        amount: Stellar::Amount.new(options["amount"])
      )

      redis.publish("unlock", channel_account)
      return response
    end
  end
end