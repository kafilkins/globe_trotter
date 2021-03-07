class UserController < ApplicationController 

    get '/users/signup' do #user can create an account
        erb :'/users/signup'
    end

    post '/users/signup' do #processes the new signup
        @user = User.create(username: params[:username], password: params[:password])
        redirect "/users/#{@user.id}"
    end

    get '/users/:id' do 
        @user = User.find(params[:id])

        erb :'/users/show'
    end

end