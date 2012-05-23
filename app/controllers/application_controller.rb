class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authenticate_admin!
  before_filter :authenticate_user!
  before_filter :content_totals

  private

  def authenticate_admin!
    return true if Rails.env.development?
    authenticate_or_request_with_http_basic do |username, password|
      username == "couchbase" && password == ENV['HTTP_AUTH_PASSWORD']
    end
  end

  def content_totals
    @content_totals = Article.totals
  end
end
