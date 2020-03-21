module Api
  module V1
    class UsersController < ApplicationController
      def create
        result = CreateUser.new(user_params).call
        render result
      end

      def update
        result = UpdateUser.new(params[:id], user_params).call
        render result
      end

      def destroy
        User.find(params[:id]).delete
        render status: :ok
      end

      private

      def user_params
        params.require(:user).permit(:name, :email, :date_of_birth)
      end
    end
  end
end
