# Author:: Youssef Benlemlih
# Author:: Jonas Krukenberg
require_relative 'mastermind'
require 'json'

# the game configuration
config = {}
File.open('game_config.json') do |file|
  config = JSON.parse(file.read.chomp)
end
begin
  puts 'Willkommen zu Mastermind'
  begin
    puts 'Spielmodi :'
    puts "\tCodemaker\tCodebreaker"
    puts "1:\tMensch\t\tMensch"
    puts "2:\tMensch\t\tComputer"
    puts "3:\tComputer\tMensch"
    puts "4:\tComputer\tComputer"
    puts 'Bitte Spielmodus wählen:'
    mode = gets.chomp
  end until %w[1 2 3 4].include?(mode)
  config['codemaker_is_human'] = %w[1 2].include?(mode)
  config['codebreaker_is_human'] = %w[1 3].include?(mode)
  game = Mastermind.new(config)
  game.start
  puts 'Nochmal spielen?'
end while %w[j ja].include?(gets.chomp.downcase)