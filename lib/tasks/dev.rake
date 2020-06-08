namespace :dev do
  desc "Configura o ambiente de desenvolvimento"
  task setup: :environment do
    if Rails.env.development?
      show_spinner("Apagando banco...") {%x(rails db:drop)}
      show_spinner("Criando banco...") {%x(rails db:create)}
      show_spinner("Migrando banco...") {%x(rails db:migrate)}
      %x(rails dev:add_coins)
      %x(rails dev:add_mining_types)
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
                   url_image: "https://img2.gratispng.com/20180330/wgw/kisspng-bitcoin-cryptocurrency-monero-initial-coin-offerin-bitcoin-5abdfe6b87dad3.2673609815224008755565.jpg"
               },
               {
                   description: "Ethereum",
                   acronym: "ETH",
                   url_image: "https://s2.coinmarketcap.com/static/img/coins/200x200/1027.png"
               },
               {
                   description: "Dash",
                   acronym: "DASH",
                   url_image: "https://i7.pngflow.com/pngimage/37/123/png-dash-bitcoin-cryptocurrency-digital-currency-logo-bitcoin-blue-angle-text-rectangle-clipart.png"
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
          {name: "Proof of Work", acronym: "PoW"},
          {name: "Proof of Stake", acronym: "PoS"},
          {name: "Proof of Capacity", acronym: "PoC"}
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

