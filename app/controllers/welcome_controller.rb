class WelcomeController < ApplicationController
  skip_before_action :authenticate_user!
  after_action :intercom_shutdown, only: [:index]

  def index
    redirect_to user_path(current_user) if current_user
  end

  protected
  def intercom_shutdown
    IntercomRails::ShutdownHelper.intercom_shutdown(session, cookies)
  end
end
