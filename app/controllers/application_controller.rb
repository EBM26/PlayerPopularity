class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  def index
  	@player = Player.all
  end
  def runit
  	TwitterJob.new.async.perform
  end
end
