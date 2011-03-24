#!/usr/bin/env ruby
# -*- coding: utf-8 -*-
require 'rubygems'
require 'bundler/setup'
require 'twitter'
require 'sfc_ikiteru'
require 'yaml'
require 'rainbow'

begin
  conf = YAML::load open(File.dirname(__FILE__)+'/config.yaml').read
  p conf
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
if per == 1
  tweet = ['ばりばりです', '元気です', 'sfc_ikiteru'].choice
else
  tweet = ["駄目ぽい", "よくわからない" , "#{per*100}%稼働"].choice
end
puts tweet

Twitter.configure do |config|
  config.consumer_key = conf['consumer_key']
  config.consumer_secret = conf['consumer_secret']
  config.oauth_token = conf['access_token']
  config.oauth_token_secret = conf['access_secret']
end
Twitter.update(tweet)
