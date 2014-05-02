class StaticController < ApplicationController
  def index
    if user_signed_in?
      redirect_to journal_entries_path
    else
      redirect_to new_journal_entry_path
    end
  end
end
