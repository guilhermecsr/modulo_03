# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts "Criando as moedas....."

Coin.create!(
        description: "Bitcoin",
        acronym: "BTC",
        url_image: " https://img2.gratispng.com/20180330/wgw/kisspng-bitcoin-cryptocurrency-monero-initial-coin-offerin-bitcoin-5abdfe6b87dad3.2673609815224008755565.jpg "
)

Coin.create!(
    description: "Ethereum",
    acronym: "ETH",
    url_image: "https://s2.coinmarketcap.com/static/img/coins/200x200/1027.png "
)

Coin.create!(
    description: "Dash",
    acronym: "DASH",
    url_image: "https://i7.pngflow.com/pngimage/37/123/png-dash-bitcoin-cryptocurrency-digital-currency-logo-bitcoin-blue-angle-text-rectangle-clipart.png "
)

puts "Moedas criadas com sucesso!"
