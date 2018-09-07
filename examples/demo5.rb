require 'stellar_sdk_payments_demo'

# Native payment with a channel account

# If stellar-sdk <= 0.5.0,
# edit the stellar-sdk gem to pass
# an argument called `source_account`.
# Then, allow the two secrets to be
# signed by passing the keypairs in
# `payment.to_envelope` method

# run `bundle open stellar-sdk`

# The channel account
transaction_source_account = Stellar::Account.from_seed("SD7I7E5HVN3WD3MOBTCYLHBR5JZ5NGWSMJEUTZJ4CNUYNJSB6NUKLFZE")

# The operation source account (your funding account)
operation_source_account = Stellar::Account.from_seed("SBGWU2LWO3HHLALCREMUDNGYD2Q5R53K26ZBC4PTMGM5LF53MZRC6Q4Y")

# Destination account
destination_account = Stellar::Account.from_address("GDUEG27WOR4QD56KLT3WVWT4PPLPUTPX2KMKPA27DBA43ZV2DH3D5I5D")

client = Stellar::Client.default_testnet
amount = Stellar::Amount.new(200)

# Send payment
client.send_payment(
  from:   transaction_source_account,
  to:     destination_account,
  source_account: operation_source_account,
  amount: amount
)