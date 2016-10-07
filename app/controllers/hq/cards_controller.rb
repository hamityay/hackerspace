class Hq::CardsController < Hq::ApplicationController
  before_action :set_card, only: [:destroy]

  def index
    @search = Card.order(card_id: :desc).search(params[:q])
    @cards = @search.result(distinct: true).paginate(page: params[:page])
    respond_with(@cards)
  end

  def new
    @card = Card.new
  end

  def create
    @card = Card.create(card_id: card_params[:card_id])
    if @card.save
      flash[:success] = 'Card başarı ile eklendi.'
      respond_with(:hq, @card, location: request.referer)
    end
  end

  def destroy
    @card.destroy
    respond_with(:hq, @card, location: request.referer)
  end
  private
    def card_params
      params.require(:card).permit(:card_id)
    end

    def set_card
      @card = Card.find(params[:id])
    end
  end
