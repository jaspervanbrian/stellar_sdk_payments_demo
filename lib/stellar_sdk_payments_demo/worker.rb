require 'sidekiq'

Sidekiq.configure_client do |config|
  config.redis = { db: 1 }
end

Sidekiq.configure_server do |config|
  config.redis = { db: 1 }
end

module StellarSdkPaymentsDemo
  class Worker
    include Sidekiq::Worker

    def perform(method_name, payment_options)
      client = Stellar::Client.default_testnet
      client.send(method_name, payment_options)

    end
  end
end