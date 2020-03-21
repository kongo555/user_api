require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#birthday?' do
    context 'when today is same day and month as the date_of_birth' do
      it 'returns true' do
        date_of_birth = Date.today - 20.years
        user = FactoryBot.build(:user, date_of_birth: date_of_birth)
        expect(user.birthday?).to eq(true)
      end
    end

    context 'when today is same month but different day from the date_of_birth' do
      it 'returns false' do
        date_of_birth = Date.today - 20.years + 1.day
        user = FactoryBot.build(:user, date_of_birth: date_of_birth)
        expect(user.birthday?).to eq(false)
      end
    end

    context 'when today is same day but different month from the date_of_birth' do
      it 'returns false' do
        date_of_birth = Date.today - 20.years - 1.month
        user = FactoryBot.build(:user, date_of_birth: date_of_birth)
        expect(user.birthday?).to eq(false)
      end
    end
  end
end
