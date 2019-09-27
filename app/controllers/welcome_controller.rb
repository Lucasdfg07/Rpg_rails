class WelcomeController < ApplicationController
  def index
    @fase_1_1 = 10.times.map
    @fase_1_2 = 10.times.map

    @moedas_totais = CollectedCoin.where("user_id = "+session[:id_user].to_s).count
    @bowser_total = KilledMonster.where("user_id = "+session[:id_user].to_s+" AND monster_id = 2").count(:monster_id)
    @turtle_total = KilledMonster.where("user_id = "+session[:id_user].to_s+" AND monster_id = 1").count(:monster_id)
    @mortes_totais = Death.where("user_id = "+session[:id_user].to_s).count

    @fase_inicial = 1;
    if @moedas_totais == 0 && @bowser_total == 0 && @turtle_total == 0
      if @mortes_totais >= 1
        redirect_to user_index_path, alert: 'Você perdeu o jogo! Mais sorte da próxima vez.'
      end
      @fase_inicial = 1;
    end


    if @moedas_totais >= 1 && @bowser_total >= 1 && @turtle_total >= 1
      if @mortes_totais >= 10
        redirect_to user_index_path, alert: 'Você perdeu o jogo! Mais sorte da próxima vez.'
      end

      @fase_inicial = 2;
    elsif @moedas_totais >= 100 && @bowser_total >= 100 && @turtle_total >= 100
      if @mortes_totais >= 25
        redirect_to user_index_path, alert: 'Você perdeu o jogo! Mais sorte da próxima vez.'
      end

      @fase_inicial = 3;
    elsif @moedas_totais >= 1000 && @bowser_total >= 1000 && @turtle_total >= 1000
      if @mortes_totais >= 50
        redirect_to user_index_path, alert: 'Você perdeu o jogo! Mais sorte da próxima vez.'
      end

      @fase_inicial = 4;
    elsif @moedas_totais >= 10000 && @bowser_total >= 10000 && @turtle_total >= 10000
      if @mortes_totais >= 75
        redirect_to user_index_path, alert: 'Você perdeu o jogo! Mais sorte da próxima vez.'
      end

      @fase_inicial = 5;
    elsif @moedas_totais >= 100000 && @bowser_total >= 100000 && @turtle_total >= 100000
     redirect_to user_index_path, notice: 'Você ganhou o jogo! Parabéns'
    end
  end

  def moeda
    @moeda = CollectedCoin.new(create_moeda_params)

    @moeda.user_id = User.last.id
    @moeda.value = 10

    if @moeda.save
      redirect_to welcome_index_path, notice: 'Moeda salva!'
    else
      redirect_to welcome_index_path, alert: 'Ocorreu um erro ao tentar salvar, tente novamente mais tarde'
    end
  end

  def monstro
    @monstro = KilledMonster.new(create_monster_params)
    @monstro.user_id = User.last.id

    @nome_monstro = params[:monster]
    @monstro_clicado = Monster.find_by_name(@nome_monstro)

    if @nome_monstro == @monstro_clicado.name
      @monstro.monster_id = @monstro_clicado.id
    else
      @monstro.monster_id = @monstro_clicado.id
    end

    if @monstro.save
      redirect_to welcome_index_path, notice: 'Matou um monstro!'
    else
      redirect_to welcome_index_path, alert: 'Ocorreu um erro ao tentar salvar, tente novamente mais tarde'
    end
  end

  def morte
    @death = Death.new(create_death_params)

    @death.user_id = User.last.id

    if @death.save
      redirect_to welcome_index_path, alert: 'Você morreu!'
    else
      redirect_to welcome_index_path, alert: 'Ocorreu um erro ao tentar salvar, tente novamente mais tarde'
    end
  end

  def create_moeda_params
    params.permit(:user_id, :value)
  end

  def create_monster_params
    params.permit(:user_id, :monster_id)
  end

  def create_death_params
    params.permit(:user_id)
  end
end
