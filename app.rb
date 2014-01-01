require 'bundler/setup'
require 'sinatra/base'
require 'json'
require './textdifficulty'

class TextDifficultyApp < Sinatra::Base
  get '/' do
    str = params.key?('str') ? params['str'] : ''
    dfc = TextDifficulty.new.difficulty str
    { str: str, difficulty: dfc }.to_json
  end
end
