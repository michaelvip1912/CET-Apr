class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_filter :admin_authorize


  def index
    @users = User.where("permission != ?", "student_user").paginate(page: params[:page]).order("academy_encode ASC")
  end


  def index_student_users
    @users = User.where('permission = ?', 'student_user').paginate(page: params[:page]).order('academy_encode DESC')
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
      flash[:success] = "用户创建成功"
      redirect_to users_url
    else
      render 'new'
    end
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:encode, :name, :academy_encode,
                                   :password, :password_confirmation,
                                   :remember_token, :permission)
    end
end
