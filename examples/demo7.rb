require 'stellar_sdk_payments_demo'
require 'redis'

first = Stellar::Account.from_seed("SDIJOQWRVNH6H74GY77SV7YIX5HKCVNJJMU2Q56DASUOE7TDBEMHANLF")
second = Stellar::Account.from_seed("SBM4QWVBFCXVVSWSHXM2WXEBVE435752FXGJ6KGD32CAAQUDTHIC5RND")
# third = Stellar::Account.from_seed("SBVULPYPLKNWNYYIPUMUZGAPIORO2RNEZAWMTCRK6ZDKJ24KIOEAVOP2")
# fourth = Stellar::Account.from_seed("SAYLDTCG4COR74SRRSTRTPUF3XOEAXSWPYUKEGJGP7ZET2NMORBL7QKW")

channel_accounts = [first, second]
client = Stellar::Client.default_testnet
amount = Stellar::Amount.new(100)

source = Stellar::Account.from_seed("SBXH4SEH32PENMMB66P4TY6LXUIFMRVFUMX2LJC3P2STHICBJLNQJOH5")
destination = Stellar::Account.from_address("GCIDYJRG5HV4WEESRA4LEKIMXLCU46XIKXGZK4PWX5K23PJIATMWR3UE")


source = Stellar::Account.from_seed("SDWKVTAM6C2643WFCVS6GZOASWHSKYJZS77CV24ARPZHZXBEFXQW24I3")