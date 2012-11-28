class UsersController < ApplicationController
  before_filter :signed_in_user, only: [:edit, :update, :index, :destroy]
  before_filter :correct_user, only: [:edit, :update]
  before_filter :admin_user, only: :destroy
  before_filter :signined_user, only: [:new, :create]

  def new
	  @user = User.new
  end

  def show
	  @user = User.find(params[:id])
	end

  def create
	  @user = User.new(params[:user])
	  if @user.save
      sign_in @user
	    flash[:success] = "Welcome to Linux News!"
	    redirect_to @user
	  else
	    render 'new'
	  end
	end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated"
      sign_in @user
      redirect_to @user
    else
      render 'edit'
    end
  end

  def index
    @users = User.paginate(page: params[:page])
  end

  def destroy
    @user = User.find(params[:id])
    if @user.admin?
      redirect_to root_path
    else
      @user.destroy
      flash[:success] = "User destroyed"
      redirect_to users_url
    end
  end

  private
  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_path) unless current_user?(@user)
  end

  def admin_user
    redirect_to(root_path) unless current_user.admin?
  end

  def signined_user
    redirect_to(root_path) if sign_in?
  end
end
