class User::CardsController < User::UserApplicationController

  before_action :set_card, only: [:create]
  def new
    @card = Card.new
  end

  def create
    @card.update(params[:card_no])
    @card.id = current_user.id
    if @card.save!
      redirect_to root_path
    end
  end

  private
    def set_card
      if Card.ids.include? (params[:card [:card_no]]).to_i
        @card = Card.find(params[:card_no])
      else
        redirect_to new_user_card_path
      end

    end
end
