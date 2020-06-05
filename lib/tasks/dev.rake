namespace :dev do
  desc "Configura o ambiente de desenvolvimento"
  task setup: :environment do
    if Rails.env.development?
      show_spinner("Apagando banco") {%x(rails db:drop)}
      show_spinner("Criando banco") {%x(rails db:create)}
      show_spinner("Migrando banco") {%x(rails db:migrate)}
      show_spinner("Semeando banco") {%x(rails db:seed)}
    else
      puts "Voce nao esta em embiente de desenvolvimento"
    end
  end

  private

  def show_spinner(msg_start, msg_end = "Concluido")
    spinner = TTY::Spinner.new("[:spinner] #{msg_start} ...", format: :dots_4)
    spinner.auto_spin
    yield
    spinner.success("(#{msg_end})")

  end
end
