require "rails_helper"

RSpec.describe Software, type: :model do
  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:type) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:image) }
  end

end