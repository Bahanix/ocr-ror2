class UsersController < ApplicationController
  # GET /users/new
  def new
    @user = User.new
  end

  # POST /users
  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      redirect_to root_url, notice: "Utilisateur créé !"
    else
      render :new
    end
  end

  def login
  end

  def logout
    session[:user_id] = nil
    redirect_to "/users/login", notice: "Vous êtes déconnecté."
  end

  def check
    @current_user = User.where(name: params[:user][:name], password: params[:user][:password]).first
    if @current_user
      session[:user_id] = @current_user.id
      redirect_to root_url, notice: "Bienvenue #{@current_user.name} !"
    else
      redirect_to "/users/login", notice: "Échec de la connexion"
    end
  end

  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :password)
    end
end
