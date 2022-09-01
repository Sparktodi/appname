# frozen_string_literal: true

module Admin
  class UsersController < ApplicationController
    before_action :set_user!, only: %i[edit update destroy]
    before_action :authorize_user!
    after_action :verify_authorized

    def index
      @users = User.all.page params[:page]
    end

    def edit; end

    def update
      if params[:user][:password].blank? || params[:user][:password_confirmation].blank?
        @user.update user_params_email_role
        flash[:success] = t('admin.update')
        redirect_to admin_users_path
      elsif @user.update user_params
        flash[:success] = t('admin.update')
        redirect_to admin_users_path
      else
        render :edit
      end
    end

    def destroy
      @user.destroy
      flash[:success] = t('admin.destroy')
      redirect_to admin_users_path
    end

    private

    def set_user!
      @user = User.find params[:id]
    end

    def user_params_email_role
      params.require(:user).permit(:email, :role)
    end

    def user_params
      params.require(:user).permit(:email, :role, :password, :password_confirmation)
    end

    def authorize_user!
      authorize([:admin, (@user || User)])
    end
  end
end
