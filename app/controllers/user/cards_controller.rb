class User::CardsController < User::UserApplicationController

  def new
    @card = Card.new
  end

  def create
    if Card.ids.include? (params[:card][:card_no]) and Card.find(params[:card][:card_no]).user_id == nil
      @card = Card.find(params[:card][:card_no])
      @card.user_id = current_user.id
      @card.card_no = params[:card][:card_no]
      if @card.save!
        redirect_to root_path
      end
    else
      flash[:alert] = 'Girmiş olduğunuz Kard No geçerli değil. Lütfen tekrar giriniz.'
      redirect_to new_user_card_path
    end
  end

  private

end
