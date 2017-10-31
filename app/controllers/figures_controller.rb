class FiguresController < ApplicationController

  get '/figures' do
    @figures = Figure.all
    erb :'/figures/index'
  end

  post '/figures' do
     @figure = Figure.create(params[:figure])

     if !params[:new_title].empty?
       @figure.titles.find_or_create_by(name: params[:new_title])
     else !params[:new_landmark].empty?
       @figure.landmarks.find_or_create_by(name: params[:new_landmark])
     end
  end

  get '/figures/new' do
    erb :'/figures/new'
  end

  get '/figures/:id' do
    @figure = Figure.find_by(id: params[:id])
    erb :"/figures/show"
  end

  get "/figures/:id/edit" do
    @figure = Figure.find_by(id: params[:id])
    erb :'/figures/edit'
  end

  patch '/figures/:id' do
    @figure = Figure.find_by(id: params[:id])
    @figure.name = params[:figure][:name]
    @figure.landmarks.find_or_create_by(name: params[:new_landmark])
    @figure.save
    redirect to "/figures/#{@figure.id}"
  end
end
