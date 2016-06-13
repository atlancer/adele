class RequestsController < ApplicationController
  def create
    Rails.logger.info params.inspect

    redirect_to '/zayavka_poluchena'
  end
end
