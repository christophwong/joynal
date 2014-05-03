class JournalEntriesController < ApplicationController
  def index
    if user_signed_in?
    @user = current_user
    @journal_entry = JournalEntry.new

      if session[:content] || session[:emotion_rating]
        @journal_entry.content = session[:content]
        @journal_entry.emotion_rating = session[:emotion_rating]
        session.delete(:content)
        session.delete(:emotion_rating)
      end

      @journal_entries = @user.journal_entries.order("created_at DESC").limit(10)
    else
      redirect_to root_path
    end  
  end

  def new
    if user_signed_in?
      @journal_entry = JournalEntry.new
    else
      redirect_to root_path
    end
  end

  def create

    @journal_entry = JournalEntry.new(journal_entry_params)
    @journal_entry.tag_list.add(params[:journal_entry][:tags], parse: true)
    if user_signed_in?

      @user = current_user
      @journal_entries = @user.journal_entries.order("created_at DESC").limit(10)
      if @journal_entry.save
        @journal_entry.update_attributes(user: current_user)
        redirect_to journal_entries_path
      else
        render 'index'
      end

    else
      session[:content] = @journal_entry.content
      session[:emotion_rating] = @journal_entry.emotion_rating
      redirect_to new_user_registration_path
    end

  end

  def show
      entry = JournalEntry.find(params[:id])
    if current_user.id == entry.user.id
      @entry = JournalEntry.find(params[:id])
    else
      redirect_to root_path
    end
  end

  def show_graph
    if user_signed_in?
      @journal_entry = JournalEntry.find(params[:id])
      respond_to do |format|
        format.json { render json: @journal_entry.keywords }
      end
    else  
      redirect_to root_path    
    end
  end


  def show_tagged
    if user_signed_in?
      @tag_name = params[:name]
      @tagged_entries = current_user.journal_entries.tagged_with(@tag_name)
    else 
      redirect_to root_path
    end  
  end

  private
  def journal_entry_params
    params.require(:journal_entry).permit(:content,
                                          :emotion_rating
                                          )
  end
end
