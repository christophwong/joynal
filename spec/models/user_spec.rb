require 'spec_helper'

describe User do
  it "has a valid factory" do
    FactoryGirl.create(:user).should be_valid
  end

  it { should have_many :journal_entries }
  it { should validate_presence_of(:first_name) }
  it { should validate_presence_of(:last_name) }

end

