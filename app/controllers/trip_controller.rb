class TripController < ApplicationController

    #create 
    get '/trips/new' do 
        if logged_in?
            erb :'/trips/new'
        else 
            redirect to '/users/login'
        end
    end

    post '/trips' do 
        if logged_in?
            if params[:location] == "" || params[:description] == "" || params[:adventures] == ""
                redirect '/trips/new'
            else     
                @trip = current_user.trips.build(
                    location: params[:location], 
                    description: params[:description], 
                    adventures: params[:adventures]
                    )
            if @trip.save        
                redirect "/trips/#{@trip.id}"
            else 
                redirect '/trips/new'
            end    
            end
        end
    end
    
    #read
    get '/trips/:id' do  
        if logged_in?
            @trip = Trip.find_by_id(params[:id])
            erb :'/trips/show'
        else
            redirect '/users/login'
        end
    end

    get '/trips' do 
        @trips = Trip.all #remember, this will return return an array!!!
        erb :'/trips/index'
    end

    #update
    get '/trips/:id/edit' do 
        if logged_in?
            @trip = Trip.find_by_id(params[:id])
        if @trip && @trip.user == current_user
            erb :'/trips/edit'
        else
            redirect to '/users/trip'
        end
    else
        redirect to '/users/login'
    end
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
