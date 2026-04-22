class UsersController < ApplicationController
  before_action :set_user, only: [ :show, :edit, :update, :destroy ]
  before_action :require_login, except: [ :new, :create ]
  before_action :authorize_user!, only: [ :show, :edit, :update, :destroy ]

  def authorize_user!
    redirect_to root_path, alert: "Not authorized" unless @user == current_user
  end

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      # redirect_to @user, notice: "User created successfully."
      session[:user_id] = @user.id   # auto-login after signup
      redirect_to root_path, notice: "Account created successfully!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @user = User.find(params[:id])
    authorize_user!
  end

  def update
    @user = User.find(params[:id])
    authorize_user!

    if @user.update(user_params)
      redirect_to @user, notice: "User updated successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @user.destroy
    redirect_to users_path, notice: "User deleted successfully."
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(
      :name,
      :email,
      :password,
      :password_confirmation
    )
  end
end
