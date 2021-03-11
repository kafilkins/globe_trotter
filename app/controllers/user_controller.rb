class UserController < ApplicationController 

    get '/users/signup' do #user can create an account
        erb :'/users/signup'
    end

    post '/users/signup' do #processes the new signup
        if params[:username] == "" && params[:password] == ""
                redirect "/users/signup"   
        else
            @user = User.new(
            username: params[:username], 
            password: params[:password]
            )
            @user.save
            session[:user_id] = @user.id 
            redirect "/users/#{@user.id}"
        end
    end

    get '/users/login' do 
        if !logged_in?
        erb :'/users/login'  
        else
            @user = User.find(session[:user_id])
            redirect "/users/#{@user.id}"
        end
    end

    post '/users/login' do
        @user = User.find_by(username: params[:username])

        if @user && @user.authenticate(params[:password])
            session[:user_id] = @user.id 
            redirect "/users/#{@user.id}"
        else  
          redirect '/users/login'
        end  
    end


    get '/users/:id' do  
        if logged_in?
            @user = User.find(params[:id])
            erb :'/users/show'
        end
    end

    get '/sessions/logout' do 
        if !logged_in?
            redirect '/'
        else
            session.clear
            redirect '/users/login' 
        end
    end

end