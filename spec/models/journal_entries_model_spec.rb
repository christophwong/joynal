require 'spec_helper'

describe JournalEntry do
  it 'has a valid factory' do
    FactoryGirl.create(:journal_entry).should be_valid
  end

  it { should belong_to(:user) }
  it { should have_many(:tags) }
  it { should have_many(:keywords) }
  it { should have_many(:location_records) }
  it { should validate_presence_of(:content) }
  it { should validate_presence_of(:emotion_rating) }

  it "is invalid without a lastname" do
    FactoryGirl.build(:journal_entry, content: nil).should_not be_valid
  end

  let(:journal){ FactoryGirl.create(:journal_entry) }
  let(:client){ AlchemyAPI.new }
  describe "#get_sentiment" do
    it "sends the journal content to Alchemy" do
      expect_any_instance_of(AlchemyAPI).to receive(:sentiment).with('text', journal.content)
      journal.get_sentiment
    end
  end

  describe '#get_keywords_response' do
     it "sends the journal content to Alchemy" do
      expect_any_instance_of(AlchemyAPI).to receive(:keywords).with('text', journal.content, { "sentiment"=>1 })
      journal.get_keywords_response
    end
  end

  describe '#set_keywords' do
    pending

  end

  describe '#set_sentiment_score' do
    pending

  end

  describe '#set_sentiment_type' do
    pending

  end

  describe '#add_date' do
    pending

  end

  describe '#jsonify_journal_keywords' do
    pending

  end


end
