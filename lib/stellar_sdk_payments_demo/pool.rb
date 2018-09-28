module StellarSdkPaymentsDemo
  class Pool
    attr_reader :redis
    attr_accessor :channel_accounts
    attr_accessor :pending_jobs

    def initialize(accounts = [])
      @redis = Redis.new

      @channel_accounts = accounts
      @channel_accounts.define_singleton_method(:unlock) do |account|
        puts "Finished."
        self << account
      end
    end

    def method_missing(method_name, **payment_options)
      if !channel_accounts.empty?
        account = channel_accounts.shift
        Worker.perform_async(method_name, payment_options)
      end
    end
  end
end