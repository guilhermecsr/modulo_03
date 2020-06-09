namespace :dev do
  desc "Configura o ambiente de desenvolvimento"
  task setup: :environment do
    if Rails.env.development?
      show_spinner("Apagando banco...") {%x(rails db:drop)}
      show_spinner("Criando banco...") {%x(rails db:create)}
      show_spinner("Migrando banco...") {%x(rails db:migrate)}
      %x(rails dev:add_mining_types)
      %x(rails dev:add_coins)
    else
      puts "Voce nao esta em embiente de desenvolvimento"
    end
  end

  desc "Cadastra as Moedas"
  task add_coins: :environment do
    show_spinner("Cadastrando Moendas...") do
      coins = [{
                   description: "Bitcoin",
                   acronym: "BTC",
                   url_image: "https://img2.gratispng.com/20180330/wgw/kisspng-bitcoin-cryptocurrency-monero-initial-coin-offerin-bitcoin-5abdfe6b87dad3.2673609815224008755565.jpg",
                   mining_type: MiningType.find_by(acronym: 'PoW')
               },
               {
                   description: "Ethereum",
                   acronym: "ETH",
                   url_image: "https://s2.coinmarketcap.com/static/img/coins/200x200/1027.png",
                   mining_type: MiningType.all.sample
               },
               {
                   description: "Dash",
                   acronym: "DASH",
                   url_image: "https://i7.pngflow.com/pngimage/37/123/png-dash-bitcoin-cryptocurrency-digital-currency-logo-bitcoin-blue-angle-text-rectangle-clipart.png",
                   mining_type: MiningType.all.sample
               },
               {
                   description: "Iota",
                   acronym: "IOT",
                   url_image: "data:image/png;base64,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",
                   mining_type: MiningType.all.sample
               },
               {
                   description: "ZCash",
                   acronym: "ZEC",
                   url_image: "https://img1.gratispng.com/20180614/bil/kisspng-computer-icons-zcash-cryptocurrency-selecta-5b22aff704b023.0927691415289999270192.jpg",
                   mining_type: MiningType.all.sample
               }]

      coins.each do |coin|
        Coin.find_or_create_by!(coin)
      end
    end
  end

  desc "Cadastra os tipos de mineiracao"
  task add_mining_types: :environment do
    show_spinner("Cadastrando Tipos de Mineiracao...") do
      mining_types = [
          {description: "Proof of Work", acronym: "PoW"},
          {description: "Proof of Stake", acronym: "PoS"},
          {description: "Proof of Capacity", acronym: "PoC"}
      ]
      mining_types.each do |mining_type|
        MiningType.find_or_create_by!(mining_type)
      end
    end
  end


  private

  def show_spinner(msg_start, msg_end = "Concluido")
    spinner = TTY::Spinner.new("[:spinner] #{msg_start}", format: :dots_4)
    spinner.auto_spin
    yield
    spinner.success("(#{msg_end})")

  end
end

