class UsersController < ApplicationController
  before_action :authenticate_user!, except: %i[show]
  before_action :set_current_user, except: %i[show]

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(user_params)
    @user.avatar.attach(params[:avatar])

    if @user.save
      redirect_to @user, notice: "User was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @user.update(user_params)
      redirect_to @user, notice: "User was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    redirect_to users_url, notice: "User was successfully destroyed."
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :avatar)
  end

  def set_current_user
    @user = current_user
  end
end
