
require 'rubygems'
require 'sinatra'
require 'image'




get("/") do
  sleep(30)
  @images = (Dir[Dir.pwd + "/public/*.XML"].collect { |file| Image.cache_or_new(file) })
  haml :index
end

get "/file" do
  @image = Image.cache_or_new(params[:file])
  haml :show
end