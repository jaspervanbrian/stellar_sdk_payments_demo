require "stellar_sdk_payments_demo/version"
require "stellar-sdk"

module StellarSdkPaymentsDemo
  extend ActiveSupport::Autoload
  autoload :Client
  autoload :Worker
  autoload :Pool
end
