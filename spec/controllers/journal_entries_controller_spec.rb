require 'spec_helper'

describe JournalEntriesController do
	describe "GET #index" do
		it "populates an array of journal entries" do 
      journal_entry = FactoryGirl.create(:journal_entry)
      get :index
      assigns(:journal_entries).should eq([journal_entry])
		end
		it "renders the :index view" do
		  get :index
		  response.should render_template :index
		end
	end


	describe  "GET #show" do
		it "assigns the requested JournalEntry to @entry" do
			 journal_entry = FactoryGirl.create(:journal_entry)
			 get :show, id: journal_entry
			 assigns(:entry).should eq(journal_entry)
		end
		it "renders the :show template" do
      get :show, id: FactoryGirl.create(:journal_entry)
      response.should render_template :show
		end
	end

	describe "GET #new" do
		# it "assigns a new JournalEntry to @journal_entry" do
		#   journal_entry = JournalEntry.new
		#   get :new
		#    assigns(:journal_entry).should eq(journal_entry)
		# end
		# it "renders the :new template" do
		# end
	end




	# describe "POST #create" do
	# 	it "saves the new JournalEntry to the database" do
	# 	end
	# 	it "redirects to Journal_entries_path" do
	# 	end
	# 	context "with invalid attributes" do
	# 		it "does not save the new JournalEntry in the database" do
 #      end
 #      it "re-renders the :new template" do
 #      end
	# 	end
	# end

	# describe "GET #edit"
	#   it ""
 #  end
end


    