require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'rest-client'


def crypto_money
  page = Nokogiri::HTML(URI.open("https://coinmarketcap.com/all/views/all/"))   
  puts page.class   # => Nokogiri::HTML::Document

  crypto_name = []
  crypto_value = []

  page.xpath("/html/body/div[1]/div/div[2]/div[1]/div[2]/div/div[2]/div[3]/div/table/tbody/tr/td[3]/div").each do |element|
    crypto_name << element.text
  end

  page.xpath("/html/body/div[1]/div/div[2]/div[1]/div[2]/div/div[2]/div[3]/div/table/tbody/tr/td[5]/a").each do |element|
    crypto_value << element.text
  end

  return crypto = Hash[crypto_name.zip(crypto_value)]
end

def get_townhall_email(townhall_url)
  my_hash = {}
  townhall_url.each do |url|
    page = Nokogiri::HTML(URI.open(url)) 

    ville = page.xpath("/html/body/div[1]/main/section[1]/div/div/div/h1").text
    email = page.xpath("/html/body/div[1]/main/section[2]/div/table/tbody/tr[4]/td[2]").text
    my_hash[ville] = email
  end

  return my_hash 
end

def get_townhall_urls
  page = Nokogiri::HTML(URI.open("http://www.annuaire-des-mairies.com/val-d-oise.html"))

  ville = []
  page.xpath('//a[contains(@href, "95")]').each do |element|
    ville << "https://www.annuaire-des-mairies.com" + element.attributes["href"].value.gsub('./', '/')
  end
  
  return ville
end

puts get_townhall_email(get_townhall_urls)