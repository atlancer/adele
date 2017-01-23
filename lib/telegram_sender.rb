require 'telegram/bot'

class TelegramSender
  CHATS = YAML.load_file(Rails.root.join('config', 'telegram_chats.yml')) rescue []
  SECRETS = YAML.load_file Rails.root.join('config', 'telegram_secrets.yml')
  TELEGRAM_LOGGER = Logger.new Rails.root.join('log', 'telegram.log')

  def self.send_message(message)
    Telegram::Bot::Client.run(SECRETS['token']) do |bot|
      CHATS.each do |chat_id|
        bot.api.sendMessage(chat_id: chat_id, text: message)
      end
    end

    TELEGRAM_LOGGER.info "Send: #{CHATS.inspect}, Message: #{message}"
  end
end
