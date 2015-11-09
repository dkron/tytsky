#require 'telegram/bot'
require './lib/telegram/bot'
require './lib/tytsky'

token = '146479675:AAHmWFBCFpMCAqymM6HjUbcBBP9aHMR0bc0'

at = Tytsky.instance

answers =
    Telegram::Bot::Types::ReplyKeyboardMarkup
        .new(keyboard: [%w(Заклинание Рандом), %w(Задача? Стэндап?), %w(Монолог)], one_time_keyboard: false)

Telegram::Bot::Client.run(token) do |bot|
  bot.listen do |message|
    message.to_json
    case message.text
      when 'Монолог'
        kb = Telegram::Bot::Types::ReplyKeyboardHide.new(hide_keyboard: true)
        rand(10).times do
          bot.api.send_message(chat_id: message.chat.id, text: "#{at.talk}", reply_markup: kb)
          sleep(2)
        end
        bot.api.send_message(
            chat_id: message.chat.id,
            text: "#{at.talk}",
            reply_markup: answers
        )
      when 'Рандом'
        bot.api.send_message(
            chat_id: message.chat.id,
            text: "#{at.talk}",
            reply_markup: answers
        )
      when 'Заклинание'
        bot.api.send_message(
            chat_id: message.chat.id,
            text: "#{at.cast}",
            reply_markup: answers
        )
      when 'Задача?'
        bot.api.send_message(
            chat_id: message.chat.id,
            text: "#{at.command}",
            reply_markup: answers
        )
      when 'Стэндап?'
        bot.api.send_message(
            chat_id: message.chat.id,
            text: "#{at.standup_time}",
            reply_markup: answers
        )
      when '/start'
        question = 'Что вы от меня хотите?'
        bot.api.send_message(chat_id: message.chat.id, text: question, reply_markup: answers)
    end
  end
end