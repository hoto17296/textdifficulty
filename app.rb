require 'bundler/setup'
require 'sinatra/base'
require 'sinatra/jsonp'
require './textdifficulty'

class TextDifficultyApp < Sinatra::Base
  helpers Sinatra::Jsonp

  get '/' do
    str = params.key?('str') ? params['str'] : ''
    td = TextDifficulty.new
    dfc = td.difficulty str
    level = td.level dfc
    data = { str: str, difficulty: dfc, level: level }
    jsonp data
  end
end
