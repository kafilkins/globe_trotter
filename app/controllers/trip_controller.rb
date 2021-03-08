class TripController < ApplicationController

    #create 
    get '/trips/new' do 
        erb :'/trips/new'
    end

    post '/trips' do 
        @trip = Trip.create(
            location: params[:location], 
            description: params[:description], 
            adventures: params[:adventures]
            )
        redirect "/trips/#{trip.id}"
    end

    #read
    get '/trips' do 
        @trips = Trip.all #remember, this will return return an array!!!
        erb :'/trips/index'
    end

    get '/trips/:id' do 
        @trip = Trip.find(params[:id])

        erb :'/trips/show'
    end

    #update
    get '/trips/:id/edit' do 
        @trip = Trip.find(params[:id])

        erb :'/trips/edit'
    end

    post '/trips/:id' do
        @trip = Trip.find(params[:id])
        @trip.update(
            location: params[:location], 
            description: params[:description], 
            adventures: params[:adventures]
            )
        redirect "/trips/#{@trip.id}"
    end

    #delete
    delete '/trips/:id' do 
        @trip = Trip.find(params[:id])
        @trip.destroy

        redirect :'/trips'
    end

end
