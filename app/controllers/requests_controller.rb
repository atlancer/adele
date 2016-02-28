class RequestsController < ApplicationController
  def create
    Rails.logger.fatal params.inspect

    redirect_to '/zayavka_poluchena'
  end
end
