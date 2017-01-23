class RequestsController < ApplicationController
  def create
    Rails.logger.info "zayavka: #{params.inspect}"

    TelegramSender.send_message "Поступила заявка на обучение.\nИмя: #{params['name']}\nEmail: #{params['email']}\nТелефон: #{params['phone']}"

    redirect_to '/zayavka_poluchena'
  end
end
