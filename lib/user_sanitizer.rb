class User::ParameterSanitizer < Devise::ParameterSanitizer
  private
  def sign_up
    default_params.permit(:name, :surname, :email, :password, :password_confirmation, :twitter, :bio, :time_zone, :avatar, card_attributes: [:card_no]) # TODO add other params here
  end
end
