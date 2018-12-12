class UsersController < ApplicationController

 
  get "/signup" do
    erb :"/users/signup"
  end

  
  post "/signup" do
    @user = User.new(params)
      if @user.save
        session[:id] = @user.id 
        redirect '/items'
      else
        flash[:message] = "Missing Fields or not a nuique Username! Try again."
        redirect '/signup'
      end
  end

  get "/login" do
    erb :"users/login"
  end

  post "/login" do
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
        session[:id] = @user.id
        redirect '/items'
    elsif params[:username].empty? || params[:password].empty?
        flash[:message] = "Incomplete fields!"
        redirect '/login'
    else 
        flash[:message] = "You are not currently a user, please sign up first!"
        redirect '/signup'
    end
  end

  get '/logout' do
    session.clear 
    flash[:message] = "You have logged out."
    redirect '/'     
  end


  
  
end
