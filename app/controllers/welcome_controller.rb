class WelcomeController < ApplicationController
  def index
    @users = User.all
    @count = 0
    @top_users = User.where('logs_count is not null').order(logs_count: :desc).limit(10)
    @c = 0
  end
end