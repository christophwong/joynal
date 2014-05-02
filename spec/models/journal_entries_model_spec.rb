require 'spec_helper'

describe JournalEntry do
  it 'has a valid factory' do
    FactoryGirl.create(:journal_entry).should be_valid
  end

  it { should belong_to(:user) }
  it { should have_many(:tags), :as => :taggable }
  it { should validate_presence_of(:content) }
  it { should validate_presence_of(:emotion_rating) }

  it "is invalid without a lastname" do
    FactoryGirl.build(:journal_entry, content: nil).should_not be_valid
  end
end
