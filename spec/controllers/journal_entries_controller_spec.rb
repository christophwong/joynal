require 'spec_helper'

describe JournalEntriesController do
	# describe "GET #index" do
	# 	it "populates an array of journal entries" do
 #      journal_entry = FactoryGirl.create(:journal_entry)
 #      get :index
 #      assigns(:journal_entries).should eq([journal_entry])
	# 	end
	# 	it "renders the :index view" do
	# 	  get :index
	# 	  response.should render_template :index
	# 	end
	# end


	# describe  "GET #show" do
	# 	it "assigns the requested JournalEntry to @entry" do
	# 		 journal_entry = FactoryGirl.create(:journal_entry)
	# 		 get :show, id: journal_entry
	# 		 assigns(:entry).should eq(journal_entry)
	# 	end
	# 	it "renders the :show template" do
 #      get :show, id: FactoryGirl.create(:journal_entry)
 #      response.should render_template :show
	# 	end
	# end

	describe "GET #new" do
		# it "assigns a new JournalEntry to @journal_entry" do
		#   journal_entry = JournalEntry.new
		#   get :new
		#    assigns(:journal_entry).should eq(journal_entry)
		# end
		# it "renders the :new template" do
		# 	get :new
		# 	response.should render_template :new
		# end
	end




	describe "POST #create" do
		context "with valid attributes" do
			# it "saves the new JournalEntry to the database" do
			#   expect{
	  #       post :create, journal_entry: FactoryGirl.attributes_for(:journal_entry)
	  #     }.to change(JournalEntry,:count).by(1)
   #    end
      it "adds tags to the journal entry" do
        journal_entry = FactoryGirl.create(:journal_entry)
        journal_entry.tag_list.add("coding")
        journal_entry.save
        expect(journal_entry.tags[0].name).to eq("coding")
      end
  		# it "redirects to Journal_entries_path" do
  		# 	post :create, journal_entry: FactoryGirl.attributes_for(:journal_entry)
    #     response.should redirect_to :journal_entries
  		# end
    # end
		# context "with invalid attributes" do
		#  	it "does not save the new JournalEntry in the database" do
  #       expect{
  #         post :create, journal_entry: FactoryGirl.attributes_for(:invalid_journal_entry)
  #       }.to_not change(JournalEntry,:count)
  #     end
      # it "re-renders the :new template" do
      #   post :create, journal_entry: FactoryGirl.attributes_for(:invalid_journal_entry)
      #   response.should render_template :new
      # end
		end
	end

  @tagged_entries = JournalEntry.tagged_with(@tag_name)


  describe "GET #show_tagged" do
    it "show all the journal entries associated with a particular tag" do
      journal_entry = FactoryGirl.create(:journal_entry)
      journal_entry.tag_list.add("computer")
      journal_entry.save
      tagged_entry = JournalEntry.tagged_with(journal_entry.tag_list[0])[0]
      expect(tagged_entry).to eq(journal_entry)
    end
  end
end



