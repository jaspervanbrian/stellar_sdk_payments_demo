require 'stellar_sdk_payments_demo'

# Demo create account

SOURCE_SEED = "SBGWU2LWO3HHLALCREMUDNGYD2Q5R53K26ZBC4PTMGM5LF53MZRC6Q4Y"
DESTINATION = "GDUEG27WOR4QD56KLT3WVWT4PPLPUTPX2KMKPA27DBA43ZV2DH3D5I5D"
BALANCE = 100;

StellarSdkPaymentsDemo::Client.create_account(SOURCE_SEED, DESTINATION, BALANCE)