require 'bundler/setup'
require 'sinatra/base'
require 'sinatra/jsonp'
require './textdifficulty'

class TextDifficultyApp < Sinatra::Base
  helpers Sinatra::Jsonp

  get '/' do
    str = params.key?('str') ? params['str'] : ''
    dfc = TextDifficulty.new.difficulty str
    data = { str: str, difficulty: dfc }
    jsonp data
  end
end
