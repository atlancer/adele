require 'telegram/bot'

class TelegramSender
  SECRETS = YAML.load_file Rails.root.join('config', 'telegram_secrets.yml')
  TELEGRAM_LOGGER = Logger.new Rails.root.join('log', 'telegram.log')

  def self.send_message(message)
    chats = YAML.load_file(Rails.root.join('config', 'telegram_chats.yml')) rescue []

    Telegram::Bot::Client.run(SECRETS['token']) do |bot|
      chats.each do |chat_id|
        bot.api.sendMessage(chat_id: chat_id, text: message)
      end
    end

    TELEGRAM_LOGGER.info "Send: #{chats.inspect}, Message: #{message}"
  end
end
