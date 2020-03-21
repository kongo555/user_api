require 'rails_helper'

RSpec.describe 'Users API', type: :request do
  describe 'POST /api/v1/users' do
    it 'creates the user and send him a registration email and returns a 201' do
      user_params = FactoryBot.attributes_for(:user, name: 'Marc')

      expect {
        post '/api/v1/users', params: { user: user_params }
      }.to change { User.count }.by(1)

      expect(response.status).to eq(201)
      expect(User.last.name).to eq('Marc')
      expect(ActionMailer::Base.deliveries.last.subject).to eq('Welcome Marc!')
    end

    context 'when there are invalid attributes' do
      it 'returns a 422 with errors' do
        user_params = FactoryBot.attributes_for(:user, :invalid)

        expect {
          post '/api/v1/users', params: { user: user_params }
        }.to not_change { User.count }
         .and not_change { ActionMailer::Base.deliveries.count }

        expect(response.status).to eq(422)
        expect(json_body.fetch("errors")).not_to be_empty
      end
    end
  end
end
