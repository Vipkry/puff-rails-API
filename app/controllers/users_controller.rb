class UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy]

  # GET /users
  def index
    
    @users = User.all

    render json: @users
  end

  # GET /users/1
  def show
    render json: @user
  end

  # POST /users
  def create
    @user = User.new(user_params)

    if @user.save
      render json: @user, status: :created, location: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # POST /login
  def authenticate
    user = User.find_by(reg: params[:reg])
    @ans = false
    if user && user.authenticate(params[:password])
      @ans = true
      render json: @ans
    else
      render json: @ans
    end
  end
  
  # GET /users_reg
  def users_reg
    @user = User.find_by(reg: params[:reg])
    render json: @user
  end

  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  def destroy
    #@user.destroy
  end
  
  # POST /change 
  def change
    @aux = false
    user = User.find_by(reg: params[:reg])
    if user && user.authenticate(params[:password])
      if params[:password_new] == params[:password_new_confirmation]
        user.update(:password => params[:password_new])
        @aux = true
      end
    end
    
    render json: @aux
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def user_params
      params.require(:user).permit(:name, :reg, :admin, :password)
    end
end
