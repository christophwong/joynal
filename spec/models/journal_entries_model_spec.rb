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
    it 'should call #get_keywords_response' do
      expect_any_instance_of(AlchemyAPI).to receive(:keywords).with('text', journal.content, { "sentiment"=>1 }).and_return(response:{keywords:{}})
      journal.set_keywords
    end

    it 'should create Keyword if response["keyword"] exists' do
      allow_any_instance_of(AlchemyAPI).to receive(:keywords).with('text', journal.content, { "sentiment"=>1 }).
        and_return({'keywords' => [{'text'=>'test', 'relevance'=> 1, 'sentiment'=>{'score'=> 1, 'type'=> 'positive'}}]})
      journal.set_keywords
      expect(journal.keywords.length).to eq(1)
    end

  end

  describe '#set_sentiment_score' do
    it 'should set a non-zero score if api returns a score' do
      allow_any_instance_of(AlchemyAPI).to receive(:sentiment).with('text', journal.content).
      and_return({'docSentiment'=>{'score'=> 1, 'type'=> 'positive'}})
      journal.set_sentiment_score
      expect(journal.sentiment_score).to eq(1)
    end

    it 'should set score to zero if api returns nil' do
      allow_any_instance_of(AlchemyAPI).to receive(:sentiment).with('text', journal.content).
      and_return({'docSentiment'=>{'type'=> 'neutral'}})
      journal.set_sentiment_score
      expect(journal.sentiment_score).to eq(0)
    end
  end

  describe '#set_sentiment_type' do
    it 'should set the journal sentiment type to the return value of AlchemyAPI' do
      allow_any_instance_of(AlchemyAPI).to receive(:sentiment).with('text', journal.content).
      and_return({'docSentiment'=>{'score'=> 1, 'type'=> 'test'}})
      journal.set_sentiment_type
      expect(journal.sentiment_type).to eq('test')
    end
  end

  describe '#add_date' do
    it 'sets the journal date column to today' do
      journal.add_date
      expect(journal.date).to eq (Time.now.strftime("%Y-%m-%d"))
    end
  end

  describe '#jsonify_journal_keywords' do
    it 'should return an array' do
      expect(journal.jsonify_journal_keywords).to be_a Array
    end

    describe 'should return an array of hash with keys' do
      before(:each) do
        journal.keywords << Keyword.create(name: "test keyword", relevance: 1, sentiment_score: -1, sentiment_type: 'negative')
      end

      it 'should have sentiment_type key' do
        expect(journal.jsonify_journal_keywords[0][:sentiment_type]).to eq('negative')
      end

      it 'should have keywords' do
        expect(journal.jsonify_journal_keywords[0][:keywords][0]).to be_a Keyword
      end
    end
  end

  describe '.get_all_journal_coords' do
    describe 'only return an array if latitude and longitude exists' do
      journal = FactoryGirl.create(:journal_entry)
      lat_lon = "POINT (#{41.8613538 + rand(-10..10)/1000.0} #{-87.6929968+rand(-10..10)/1000.0})"
      LocationRecord.create(journal_entry_id: journal.id, location: lat_lon)

      it 'should return an array' do
        expect(JournalEntry.get_all_journal_coords).to be_a Array
      end

      it 'should have latitude' do
        expect(JournalEntry.get_all_journal_coords[0][:latitude]).to be_a Float
      end

      it 'should have longitude' do
        expect(JournalEntry.get_all_journal_coords[0][:longitude]).to be_a Float
      end
    end
  end
end
