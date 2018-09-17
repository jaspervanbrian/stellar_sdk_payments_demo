require 'stellar_sdk_payments_demo'

first = Stellar::Account.from_seed("SDIJOQWRVNH6H74GY77SV7YIX5HKCVNJJMU2Q56DASUOE7TDBEMHANLF")
second = Stellar::Account.from_seed("SBM4QWVBFCXVVSWSHXM2WXEBVE435752FXGJ6KGD32CAAQUDTHIC5RND")
third = Stellar::Account.from_seed("SBVULPYPLKNWNYYIPUMUZGAPIORO2RNEZAWMTCRK6ZDKJ24KIOEAVOP2")
fourth = Stellar::Account.from_seed("SAYLDTCG4COR74SRRSTRTPUF3XOEAXSWPYUKEGJGP7ZET2NMORBL7QKW")

channel_accounts = [first, second, third, fourth]

source = Stellar::Account.from_seed("SDWKVTAM6C2643WFCVS6GZOASWHSKYJZS77CV24ARPZHZXBEFXQW24I3")
destination = Stellar::Account.from_address("GCIDYJRG5HV4WEESRA4LEKIMXLCU46XIKXGZK4PWX5K23PJIATMWR3UE")
client = Stellar::Client.default_testnet
amount = Stellar::Amount.new(100)

# Send 400 lumens to destination
worker_threads = channel_accounts.map do |channel|
  Thread.new do
    puts "Sending payment..."
    client.send_payment(
      from:   channel,
      to:     destination,
      source_account: source,
      amount: amount
    )
  end
end
worker_threads.map(&:join)
