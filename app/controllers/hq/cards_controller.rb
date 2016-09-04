class Hq::CardsController < Hq::ApplicationController

  def index
    @cards = Card.all
  end

  def new
    @card = Card.new
  end

  def create
    @card = Card.create(card_id: card_params[:card_id])
    if @card.save
      flash[:success] = 'Card başarı ile eklendi.'
      redirect_to hq_dashboard_index_path
    end
  end
  private
    def card_params
      params.require(:card).permit(:card_id)
    end
end
