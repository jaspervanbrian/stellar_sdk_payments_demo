require 'json'
require 'redis'

module StellarSdkPaymentsDemo
  class Pool
    attr_accessor :redis

    def initialize(accounts = [])
      # @client = Stellar::Client.default_testnet

      @redis = Redis.new
      redis.rpush("available", accounts)
      fork do
        redis.subscribe("unlock") do |on|
          on.message do |channel, account_address|
            p "Finished"
            redis.rpush("available", account_address)
            if redis.llen("pending_jobs") > 0 && redis.llen("available") > 0
              process_pending_jobs
            end
          end
        end
      end
    end

    def method_missing(method_name, **options)
      redis.rpush("pending_jobs", {method_name: method_name, options: options}.to_json)
      if redis.llen("available") > 0
        process_pending_jobs
      end
    end

    def process_pending_jobs
      account_address = redis.lpop("available")
      redis.rpush("locked", account_address)
      tx = JSON.parse(redis.lpop("pending_jobs"))
      Worker.perform_async(tx["method_name"], tx["options"])
    end
  end
end