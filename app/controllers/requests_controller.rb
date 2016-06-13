class RequestsController < ApplicationController
  def create
    Rails.logger.info "zayavka: #{params.inspect}"

    redirect_to '/zayavka_poluchena'
  end
end
