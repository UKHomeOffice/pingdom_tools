#!/usr/bin/env ruby
require 'open-uri'
require 'nokogiri'

PINGDOM_XPATH = '//item[country/@code="%s"]/ip/text()'
EUROPE_CODES = 'AT,CH,CZ,DK,GB,DE,FR,IE,IT,NL,SE'
pingdom_doc = Nokogiri::HTML(open('https://www.pingdom.com/rss/probe_servers.xml'))

country_codes_ary = ARGV[0].split(',')
format = ARGV[1]
country_codes_ary.each do |code|
  if code == 'europe'
    country_codes_ary = country_codes_ary | EUROPE_CODES.split(',')
  end
end

country_codes_ary.each do |code|
  pingdom_doc.xpath(PINGDOM_XPATH % code).each do |item|
    if format
      puts format % item.to_s
    else
      puts item.to_s
    end
  end
end