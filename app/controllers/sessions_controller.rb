class SessionsController < Devise::SessionsController
  def create
    super
    @journal_entry = JournalEntry.new
    if session[:content]
      @journal_entry.content = session[:content]
      session.delete(:content)
      @journal_entry.user = current_user
      @journal_entry.save
    end
  end


end
