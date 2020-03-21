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

  describe 'PUT /api/v1/users/:id' do
    it 'creates the user and send him a registration email and returns a 200' do
      user = FactoryBot.create(:user, name: 'Old')
      user_params = { name: 'New' }

      put '/api/v1/users/', params: { id: user.id, user: user_params }

      expect(response.status).to eq(200)
      expect(user.reload.name).to eq('New')
    end

    context 'when id is invalid' do
      it 'returns a 404' do
        user_params = { name: 'New' }

        put '/api/v1/users/', params: { id: nil, user: user_params }

        expect(response.status).to eq(404)
        expect(json_body.fetch("errors")).not_to be_empty
      end
    end

    context 'when there are invalid attributes' do
      it 'returns a 422 with errors' do
        user = FactoryBot.create(:user)
        user_params = FactoryBot.attributes_for(:user, :invalid)

        put '/api/v1/users/', params: { id: user.id, user: user_params }

        expect(response.status).to eq(422)
        expect(json_body.fetch("errors")).not_to be_empty
      end
    end

    context 'when attributes are missing' do
      it 'returns a 422 with errors' do
        user = FactoryBot.create(:user)

        put '/api/v1/users/', params: { id: user.id }

        expect(response.status).to eq(422)
        expect(json_body.fetch("errors")).not_to be_empty
      end
    end
  end
end
