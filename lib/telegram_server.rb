require File.expand_path(__dir__) + '/../config/application.rb'
require 'telegram/bot'

class TelegramServer
  TELEGRAM_LOGGER = Logger.new Rails.root.join('log', 'telegram.log')

  SECRETS = YAML.load_file Rails.root.join('config', 'telegram_secrets.yml')
  CHATS_FILE = Rails.root.join('config', 'telegram_chats.yml')
  HELP = "Use '/start' or '/connect <password>'".freeze

  def self.run
    Telegram::Bot::Client.run(SECRETS['token']) do |bot|
      bot.listen do |message|
        TELEGRAM_LOGGER.info "Receive: #{message.inspect}"

        message_text =
          case message.text
            when '/start'
              "Hello, #{message.from.first_name} !\n#{HELP}"
            when '/help'
              HELP
            when /\/connect .*/
              chat_id = message.chat.id
              chats = YAML.load_file(CHATS_FILE) rescue []

              if chats.include?(chat_id)
                'You are already conected'
              else
                if message.text == "/connect #{SECRETS['connect_password']}"
                  chats << chat_id
                  File.open(CHATS_FILE, 'w') {|f| f.write chats.sort.to_yaml }
                  'Password accepted !'
                else
                  'Bad password'
                end
              end
            when '/chats list'
              chats = YAML.load_file(CHATS_FILE) rescue []
              chats.inspect
            else
              'unknown command'
          end

        bot.api.sendMessage(chat_id: message.chat.id, text: message_text)
      end
    end
  end
end

TelegramServer.run

sleep

