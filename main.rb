#!/usr/bin/env ruby

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

def show_options
  print_menu
  print '1-3 or press q to quit app? '
  selected = gets.chomp
  case selected
  when '1'
    puts 'selected 1'
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
