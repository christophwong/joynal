class JournalEntriesController < ApplicationController
  def index
    @journal_entries = JournalEntry.order("created_at DESC").limit(10)
  end

  def new
    @journal_entry = JournalEntry.new
  end

  def create
    @journal_entry = JournalEntry.new(journal_entry_params)
    @journal_entry.tag_list.add(params[:journal_entry][:tags], parse: true)
    if @journal_entry.save
      redirect_to journal_entries_path
    else
      render 'new'
    end
  end

  def show
    @entry = JournalEntry.find(params[:id])
  end

  def edit
    #@entry =  @entry = JournalEntry.find(params[:id])
  end

  def update
    # @entry = JournalEntry.find(params[:id])
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
