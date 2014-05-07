describe AlchemyWorker do
  it { should be_retryable 2 }

  describe '#perform' do
    it 'should add job to queue' do
      Sidekiq::Testing.fake!
      journal = FactoryGirl.create(:journal_entry)
      AlchemyWorker.perform_async(journal.id)
      expect(AlchemyWorker).to have_queued_job(journal.id)
    end

    it "should save journal_entry" do
      Sidekiq::Testing.inline!
      expect_any_instance_of(JournalEntry).to receive(:set_keywords)
      expect_any_instance_of(JournalEntry).to receive(:set_sentiment_score)
      expect_any_instance_of(JournalEntry).to receive(:set_sentiment_type)
      expect_any_instance_of(JournalEntry).to receive(:save)
      JournalEntry.stub(:find).and_return(JournalEntry.new)

      AlchemyWorker.new.perform(7)

    end
  end
end
