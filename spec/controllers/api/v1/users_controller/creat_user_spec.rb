require 'rails_helper'

RSpec.describe Api::V1::UsersController::CreateUser do
  describe '#call' do
    context 'when attributes are valid' do
      it 'creates the user' do
        user_params = FactoryBot.attributes_for(:user)

        expect {
          Api::V1::UsersController::CreateUser.new(user_params).call
        }.to change { User.count }.by(1)
      end

      it 'assign params to the user' do
        user_params = { name: 'Rob', email: 'rob@email.com', date_of_birth: Date.new(1990, 5, 12) }

        Api::V1::UsersController::CreateUser.new(user_params).call

        last_user = User.last
        expect(last_user.name).to eq('Rob')
        expect(last_user.email).to eq('rob@email.com')
        expect(last_user.date_of_birth).to eq(Date.new(1990, 5, 12))
      end

      it 'sends registration email to the user' do
        user_params = FactoryBot.attributes_for(:user)
        allow(UserMailer).to receive_message_chain(:registration, :deliver_now)

        Api::V1::UsersController::CreateUser.new(user_params).call

        expect(UserMailer).to have_received(:registration).with(User.last)
      end
    end

    context 'when there are invalid attributes' do
      it 'does not create user' do
        user_params = FactoryBot.attributes_for(:user, :invalid)

        expect {
          Api::V1::UsersController::CreateUser.new(user_params).call
        }.to_not change { User.count }
      end

      it 'does not send registration email to the user' do
        user_params = FactoryBot.attributes_for(:user, :invalid)
        allow(UserMailer).to receive_message_chain(:registration, :deliver_now)

        Api::V1::UsersController::CreateUser.new(user_params).call

        expect(UserMailer).to_not have_received(:registration)
      end
    end
  end
end
