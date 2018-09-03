require 'stellar_sdk_payments_demo'

# Change trust (alphanum4)

SOURCE_SEED = "SBGWU2LWO3HHLALCREMUDNGYD2Q5R53K26ZBC4PTMGM5LF53MZRC6Q4Y"
DESTINATION_SEED = "SAWWAPHO2G5YLECAVFGXSRDAUDLCOIBYQSIH56237E2WYPZZZTMLTVDE"

asset_type = "alphanum4"
# asset_type = "alphanum12"

asset_code = "XRP"

StellarSdkPaymentsDemo::Client.change_trust(asset_type, asset_code, SOURCE_SEED, DESTINATION_SEED)