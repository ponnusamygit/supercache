class UsersController < ApplicationController

  def index
    @users = User.all
    @names = []
    @users.each { |user| @names << user.name }
  end
end