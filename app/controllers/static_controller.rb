class StaticController < ApplicationController
  def index
    if user_signed_in?
      redirect_to journal_entries_path
    end
    @journal_entry = JournalEntry.new
  end
end
