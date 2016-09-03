class User::CardsController < User::UserApplicationController

  def new
    @card = Card.new
  end

  def create
    if Card.ids.include? (params[:card][:card_no])
      @card = Card.find(params[:card][:card_no])
      @card.user_id = current_user.id
      @card.card_no = params[:card][:card_no]
      if @card.save!
        redirect_to root_path
      end
    else
      redirect_to new_user_card_path
    end
  end

  private

end
