class LogsController < ApplicationController

  def new

  end

  def create
    if params[:key] == '500'
      @card = Card.find(params[:card_id])
      @user = @card.user
      if @user.is_active == true and @user.card.status == true
        if @user.logs.last == nil
          @log = @user.logs.new
          @log.enter_time = DateTime.now
          @log.save
        elsif @user.logs.last.enter_time != nil and @user.logs.last.exit_time == nil
          @user.logs.last.update(exit_time: DateTime.now)
        end
      #else
      end

    end
    redirect_to root_path

  end

  def update

  end

end
