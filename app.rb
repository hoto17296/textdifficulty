require 'bundler/setup'
require 'sinatra/base'
require 'json'
require './font'

class StringDepthApp < Sinatra::Base
  get '/' do
    str = params.key?('str') ? params['str'] : ''
    depth = StringDepth.new.depth str
    { str: str, depth: depth }.to_json
  end
end
