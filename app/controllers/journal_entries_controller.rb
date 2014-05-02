class JournalEntriesController < ApplicationController
  def index
    @journal_entries = current_user.journal_entries.order("created_at DESC").limit(10)
  end

  def new
    @journal_entry = JournalEntry.new
  end

  def create
    @journal_entry = JournalEntry.new(journal_entry_params)
    @journal_entry.tag_list.add(params[:journal_entry][:tags], parse: true)

    @journal_entry.set_keywords

    @journal_entry.set_sentiment_score
    @journal_entry.set_sentiment_type
    if @journal_entry.save
      current_user.journal_entries << @journal_entry
      redirect_to journal_entries_path
    else
      render 'new'
    end
  end

  def show
    @entry = JournalEntry.find(params[:id])
  end


  def show_tagged
    @tag_name = params[:name]
    @tagged_entries = JournalEntry.tagged_with(@tag_name)
  end

  private
  def journal_entry_params
    params.require(:journal_entry).permit(
      :content,
      :emotion_rating
      )
  end


end
