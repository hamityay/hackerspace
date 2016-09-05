class Hq::UsersController < Hq::ApplicationController
  before_action :detect_user, only: [:index]
  before_action :set_user, only: [:show, :edit, :update, :destroy, :toggle_is_active]
  add_breadcrumb I18n.t('activerecord.models.users'), :hq_users_path

  def index
    @search = User.order(id: :desc).search(params[:q])
    @users = @search.result(distinct: true).paginate(page: params[:page])
    respond_with(@users)
  end

  def show
    add_breadcrumb @user.name, hq_user_path(@user)
    respond_with(@user)
  end

  def new
    add_breadcrumb t('tooltips.new'), new_hq_user_path
    @user = User.new
    respond_with(@user)
  end

  def edit
    add_breadcrumb @user.name, hq_user_path(@user)
    add_breadcrumb t('tooltips.new'), edit_hq_user_path
  end

  def create
    @user = User.new(user_params)
    @user.save
    respond_with(:hq, @user)
  end

  def update
    @user.update(user_params)
    if @card.card_id != params[:user][:card][:card_no]
      @card.card_no = nil
      @card.user_id = nil
      @card.status = false
      @card.save
      @a_card = Card.find(params[:user][:card][:card_no])
      @a_card.update(status: params[:user][:card][:status], card_no: params[:user][:card][:card_no])
      @a_card.user_id = @user.id
      @a_card.save
    else
      @card.update(status: params[:user][:card][:status], card_no: params[:user][:card][:card_no])
    end
    respond_with(:hq, @user)
  end

  def destroy
    @user.destroy
    respond_with(:hq, @user, location: request.referer)
  end

  def toggle_is_active
    if @user.update( is_active: !@user.is_active )
      @user.is_active ?
          flash[:info] = t('flash.actions.toggle_is_active.active', resource_name: User.model_name.human) :
          flash[:info] = t('flash.actions.toggle_is_active.passive', resource_name: User.model_name.human)
    else
      flash[:danger] = t('flash.messages.error_occurred')
    end
    respond_with(:hq, @user, location: request.referer)
  end

  private

  def set_user
    @user = User.find(params[:id])
    @card = @user.card
  end

  def user_params
    params.require(:user).permit(:email, :name, :surname, :time_zone,
                                 card_attributes: [:status, :card_no])
  end

  def detect_user
    User.all.each { |u| u.destroy if u.card == nil }
  end
end
