module Admin
  class UsersController < ApplicationController
    before_action :authorize_manage_users!

    def index
      users = User.order(:name)

      render json: users
    end

    def show
      render json: {
        id: user.id,
        name: user.name,
        email: user.email,
        role: user.role,
        active: user.active
      }
    end

    def create
      user = User.create!(user_params)

      render json: user,
             status: :created
    end

    def update
      user.update!(user_params)

      render json: user
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