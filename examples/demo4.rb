require 'stellar_sdk_payments_demo'

# Alphanum4 fiat/other assets

SOURCE_SEED = "SBGWU2LWO3HHLALCREMUDNGYD2Q5R53K26ZBC4PTMGM5LF53MZRC6Q4Y"
DESTINATION = "GDUEG27WOR4QD56KLT3WVWT4PPLPUTPX2KMKPA27DBA43ZV2DH3D5I5D"
asset = "XRP"
asset_type = "alphanum4"
amount = 100;

StellarSdkPaymentsDemo::Client.send_payment(SOURCE_SEED, DESTINATION, amount, asset, asset_type)