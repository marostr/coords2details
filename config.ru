require 'rubygems'
require 'bundler'

Bundler.require
use Rack::PostBodyContentTypeParser

require './webservice'
run WebService
