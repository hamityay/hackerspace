class WelcomeController < ApplicationController
  def index
    @users = User.all
    @users.each do |user|
       if user.logs.last != nil and user.logs.last.enter_time != nil and user.logs.last.exit_time == nil and user.logs.last.enter_time + 3.hours <= DateTime.now
         user.logs.last.update( exit_time: user.logs.last.enter_time + 3.hours)
      end
    end
    @count = 0
    @top_users = User.where('logs_count is not null').order(logs_count: :desc).limit(10)
    @c = 0
  end
end