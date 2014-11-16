require 'json'
require_relative 'details_checker'

class WebService < Sinatra::Base
  get '/' do
    "Please use GET /coords2details and provide locations to check in following form: ?locations=30.598578,31.059259:30.195844,31.001581:30.921524,31.261027\nOr POST /coords2details and provide locations in json. Example [[30.594324, 31.052343], [31.0012532,30.92132]]"
  end

  get '/coords2details' do
    redirect to '/' if params[:locations].nil?
    response = DetailsChecker.new(params[:locations]).call!
    response.to_json
  end

  post '/coords2details' do
    redirect to '/' if params[:locations].nil?
    response = DetailsChecker.new(params[:locations]).call!
    response.to_json
  end
end
