require 'rails_helper'

RSpec.describe School, type: :model do
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
