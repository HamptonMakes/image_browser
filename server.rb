
require 'rubygems'
require 'sinatra'
require 'image'


get("/") do
  @images = (Dir[Dir.pwd + "/public/*.XML"].collect { |file| Image.new(file) })
  haml :index
end

get "/file" do
  @image = Image.new(params[:file])
  haml :show
end