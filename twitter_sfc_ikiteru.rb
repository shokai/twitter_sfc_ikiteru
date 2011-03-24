#!/usr/bin/env ruby
# -*- coding: utf-8 -*-
require 'rubygems'
require 'bundler/setup'
require 'twitter'
require 'json'
require 'sfc_ikiteru'
require 'yaml'
require 'rainbow'


begin
  conf = YAML::load open(File.dirname(__FILE__)+'/config.yaml').read
rescue => e
  STDERR.puts 'config.yaml load error!'
  STDERR.puts e
end

per, details = SfcIkiteru.ikiteru

color = :red
color = :green if per == 1
puts "生存率#{per*100}".color(color)
p details

tweet = nil
if per >= 1
  tweet = ['ばりばりです', "バリバリです", '元気です', 'ikiteru', '平穏無事', 'ok',
           'めでたい', 'ド'*rand(10), 'いい感じ', '完璧', 'ばっちりです', 'かず助いきたい'].choice
elsif per <= 0
  tweet = ["ダメ", "駄目", "ikitenai", "完全に沈黙", "オワコン", "http://このまま眠り続けて.死ぬ.jp", 
           "寝てます", "もう寝よう！", "(´・ω・｀)", "＼(^o^)／ｵﾜﾀ", '無理', 'もう寝ろ', 'ぐぬぬ',
          'こんなのって・・・ないよ・・・'].choice
else
  tweet = ["微妙", "動いている、ような" , "ちょっと動いてる", "ところどころ動いてる", 
           "ねえ、今動いたわ！", 'うーん', '要注意です', 'まあいいんじゃないの', 
           'だいたい動いてる', '合格', 'そこそこ', '動いてないサーバーもあるし、動いてるのもあるし'].choice
end
tweet += " (稼働率#{(per*100).to_i}%)"
puts tweet

Twitter.configure do |config|
  config.consumer_key = conf['consumer_key']
  config.consumer_secret = conf['consumer_secret']
  config.oauth_token = conf['access_token']
  config.oauth_token_secret = conf['access_secret']
end
begin
  Twitter.update(tweet)
rescue => e
  STDERR.puts e
end
