module Admin
  class UsersController < ApplicationController
    before_action :authorize_manage_users!

    def index
      users = User.where(active: true).order(:name)

      render json: users.map { |user|
        Admin::UserPresenter.new(
         user: user
        ).call
      }
    end

    def show
      render json:
        Admin::UserPresenter.new(
          user: user
        ).call
    end

    def create
      user = User.create!(user_params)

      render json:
        Admin::UserPresenter.new(
          user: user
        ).call,
        status: :created
    end

    def update
      user.update!(user_params)

      render json:
        Admin::UserPresenter.new(
          user: user
        ).call
    end

    def destroy
      user.update!(active: false)

      head :no_content
    end

    private

    def user
      @user ||= User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(
        :name,
        :email,
        :role
      )
    end
  end
end