class Account::BaseController < ApplicationController
  before_action :current_user
  before_action :check_current_user

  def show
    @user = current_user
    @playlists = @user.playlists
  end

private

  def check_current_user
    if @current_user == nil
      redirect_to root_path
    end
  end
end
