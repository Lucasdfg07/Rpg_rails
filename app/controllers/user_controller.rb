class UserController < ApplicationController
  def index
  end

  def create
    @users = User.new
    session[:nome_usuario] = params[:nome]

    if @users.save
      redirect_to welcome_index_path, notice: 'Bem vindo, comece a jogar agora mesmo!'
    else
      redirect_to user_index_path, alert: 'Ocorreu um erro ao tentar salvar, tente novamente mais tarde'
    end
    
    session[:id_user] = User.last.id
  end
end
