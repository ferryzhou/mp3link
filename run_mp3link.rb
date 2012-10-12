# encoding: utf-8
require './mp3link'

query_string = ARGV.join(' ')
puts query_string
puts query_mp3(utf8_to_gb2312(query_string))
