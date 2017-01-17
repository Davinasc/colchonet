class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_filter :require_no_authentication, only: [:new, :create]
  before_filter :require_authentication, only: [:destroy]
  before_filter :can_change, only: [:edit, :update]

  def index
    @users = User.all
  end

  def show
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(user_params)
      if @user.save
        SignupMailer.confirm_email(@user).deliver
        redirect_to @user, notice: 'User was successfully created.'
      else
        render :new
      end
  end

  def update
      if @user.update(user_params)
        redirect_to @user, notice: 'User was successfully updated.'
      else
        render :edit
      end
  end

  def destroy
    @user.destroy
    redirect_to users_url, notice: 'User was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:full_name, :bio, :password, :password_confirmation, :email, :location)
    end

    def can_change
      unless user_signed_in? && current_user == user
        redirect_to user_path(params[:id]), alert: 'Você não tem permissão para acessar essa página.'      
      end
    end

    def user
      @user ||= User.find(params[:id])
    end
end
