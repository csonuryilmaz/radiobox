#!/usr/bin/env ruby

require 'json'

$version = '0.4'

puts "radiobox-#{$version}"

def mpv_should_be_installed
  puts ''
  puts 'Checking is mpv installed ...'
  result = system('mpv --version')
  if result.nil?
    puts ''
    puts 'Error: You must install mpv player!'
    puts '  * Official website: http://mpv.io'
    puts '  * Windows builds: http://mpv.srsfckn.biz/'
    puts ''
    abort('✖️ Mpv not found')
  end
end

mpv_should_be_installed
puts '✔️ Success'
puts ''
puts 'Press ENTER to continue main menu ...'
gets

def option_not_implemented_yet(message)
  puts ''
  puts "Sorry! #{message}"
  puts 'Press ENTER to continue ...'
  gets
  show_options
end

def print_menu
  system('clear')
  puts "radiobox-#{$version} \t Command line radio player for coder geeks :)"
  puts ''
  puts 'Choose a menu item to continue:'
  puts '1) Select Radio Station'
  puts '2) Play Random Station'
  puts '3) Search Radio Station'
  puts ''
end

def play_selected_radio(radios, keymap)
  puts ''
  puts '(b) Back to main menu ...'
  puts ''
  print "Select number to play radio (1-#{keymap.length})? "
  selected = gets.chomp.downcase
  return if selected[0] == 'b'

  selected = '1' if selected.length.zero?
  radio = keymap[selected.to_i - 1]
  puts ''
  puts "#{radio} ..."
  mpv = "mpv --no-ytdl #{radios[radio]}"
  puts mpv
  system(mpv)
  puts 'Press ENTER to continue ...'
  gets
end

def select_radio_station
  system('clear')
  puts 'List of Radio Stations'
  puts '----------------------'
  radios = JSON.parse(File.read('radios.json'))
  keymap = []
  radios.each do |key, value|
    if !key.strip.empty? && !value.strip.empty?
      keymap.append(key.strip)
      puts "(#{keymap.length}) #{key}"
    end
  end
  # @todo print in columns
  # https://github.com/tj/terminal-table
  play_selected_radio(radios, keymap)
end

def show_options
  print_menu
  print '1-3 or press q to quit app? '
  selected = gets.chomp.downcase
  case selected
  when '1'
    select_radio_station
    show_options
  when '2'
    option_not_implemented_yet('Play random station feature is not implemented yet.')
  when '3'
    option_not_implemented_yet('Search radio station feature is not implemented yet.')
  when 'q'
    puts 'bye bye'
    exit 0
  else
    show_options
  end
end

show_options
