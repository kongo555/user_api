module Api
  module V1
    class UsersController
      class CreateUser
        def initialize(user_params)
          @user_params = user_params
        end

        def call
          user = User.new(@user_params)
          if user.save
            send_registration_email(user)
            { status: :created }
          else
            { json: { errors: user.errors.messages }, status: :unprocessable_entity }
          end
        end

        private

        def send_registration_email(user)
          UserMailer.registration(user).deliver_now
        end
      end
    end
  end
end
