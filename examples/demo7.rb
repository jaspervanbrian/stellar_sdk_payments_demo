require 'stellar_sdk_payments_demo'

first = "SD4IWHHQ5ENER7LAZV5LQQIWY4KZSIQB3W6ZVQHGQXZDH3QYQYZUQBV7"
# second = "SABEPZQXI5BZGTWFXORQVI6IHNZ7N2QCEILQWWP6QLKYVWCUM3JB3SJG"
# third = "SACDKOJG2O6L6SLJZ4TT7B3FO5TUZDQH5QY375SSTOTNPDHIVGW4LTYX"
# fourth = Stellar::Account.from_seed("SBTBD65YWRKA4UBQI3EGNAXBTYJ2GYOJ43NWG6UIACA7H537I2JUSA6M")

pool = StellarSdkPaymentsDemo::Pool.new([first])

amount = 100

source = "SBU2HEXULPBFE4SYJJ7UDDU2XB3DDE2SG4WYLA33YUMWFV7FJQWPQUUF"
destination = "GCKUWZ26L6OLH7L52BUIXUISIQFCT2L4BM5QH2CERSS2LW72MX433J4A"

pool.send_payment(
  source_account:   source,
  to:               destination,
  amount:           amount
)

source = "SCYMUVDFPTT47T7264DIO5UCOQE63KGMHFNMRGTJKJNL6GR5B64T4PD7"

pool.send_payment(
  source_account:   source,
  to:               destination,
  amount:           amount
)

pool.send_payment(
  source_account:   source,
  to:               destination,
  amount:           amount
)