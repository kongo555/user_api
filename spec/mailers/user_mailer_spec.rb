require "rails_helper"

describe UserMailer do
  describe 'registration' do
    it 'delivers a registration email to given user' do
      user = FactoryBot.build(:user, name: 'Rob', email: 'rob@email.com')

      email = UserMailer.registration(user)

      expect(email.to).to eq(['rob@email.com'])
      expect(email.subject).to eq('Welcome Rob!')
      expect(email.body.encoded).to include('Hello!')
    end
  end
end
