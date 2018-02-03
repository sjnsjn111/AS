class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :load_user, only: %i(show edit update)

  def show; end

  def edit; end

  def update
    respond_to do |format|
      if @user.update_attributes user_params
        format.js{@success = t "update_success"}
      else
        format.js{@errors = t "update_failure"}
      end
    end
  end

  private

  def load_user
    @user = User.find_by id: params[:id]
    return if @user
    flash[:danger] = t "nil_user"
    redirect_to root_url
  end

  def load_user_ajax
    @user = User.find_by id: params[:id]
    return if @user
    @error = t "nil_user"
  end

  def user_params
    params[:user][:sex] = params[:user][:sex].to_i if params[:user]
    params.require(:user).permit :birthday, :address, :phone, :avatar, :sex,
      :religion, :nation, :nationality
  end
end
