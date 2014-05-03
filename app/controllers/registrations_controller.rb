class RegistrationsController < Devise::RegistrationsController
  def new
    super
  end

  def create
    super
    @journal_entry = JournalEntry.new
    if session[:content]
      @journal_entry.content = session[:content]
      @journal_entry.emotion_rating = session[:emotion_rating]
      session.delete(:content)
      session.delete(:emotion_rating)
      @journal_entry.user = current_user
      @journal_entry.save
    end

  end

  def update
    super
  end
end