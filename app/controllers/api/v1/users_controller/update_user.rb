module Api
  module V1
    class UsersController
      class UpdateUser
        def initialize(id, user_params)
          @id = id
          @user_params = user_params
        end

        def call
          user = User.find(@id)
          if user.update(@user_params)
            { status: :ok }
          else
            { json: { errors: user.errors.messages }, status: :unprocessable_entity }
          end
        end
      end
    end
  end
end
