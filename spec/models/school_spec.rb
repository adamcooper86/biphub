require 'rails_helper'

RSpec.describe School, type: :model do
  context 'validations' do
    it 'requires a school name' do
      expect(FactoryGirl.build(:school, name: "")).not_to be_valid
    end
    it 'requires a school address' do
      expect(FactoryGirl.build(:school, address: "")).not_to be_valid
    end
    it 'requires a school city' do
      expect(FactoryGirl.build(:school, city: "")).not_to be_valid
    end
    it 'requires a school state' do
      expect(FactoryGirl.build(:school, state: "")).not_to be_valid
    end
    it 'requires a school zip' do
      expect(FactoryGirl.build(:school, zip: "")).not_to be_valid
    end
  end
  context '#users' do
    it 'returns an array of coordinators, teachers, and speducators' do
      school = FactoryGirl.create(:school)
      teacher = FactoryGirl.create(:teacher)
      school.teachers << teacher
      speducator = FactoryGirl.create(:speducator)
      school.speducators << speducator
      coordinator = FactoryGirl.create(:coordinator)
      school.coordinators << coordinator
      expect(school.users).to eq [coordinator, teacher, speducator]
    end
  end
end
