class RequestsController < ApplicationController
  def create
    Rails.logger.info "zayavka: #{params.inspect}"

    TelegramSender.send_message "Поступила заявка:\n#{params.inspect}"

    redirect_to '/zayavka_poluchena'
  end
end
