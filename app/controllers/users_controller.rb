class UsersController < ApplicationController

  # GET login
  get "/login" do
    erb :"/users/login.html"
  end

  # GET new user at /users/signup
  get "/signup" do
    erb :"/users/signup.html"
  end

    # POST new user 
  post "/users" do
    if params[:name] != "" && params[:username] != "" && params[:password] != ""
    @user = User.create(params)

    end 
    
    if @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect "/users/#{@user.id}"
      else
        redirect "/signup"
      end
  end

  # POST login
  post '/login' do 
  @user = User.find_by(username: params[:username])
    if @user.authenticate(params[:password])
    session[:user_id] = @user.id
    redirect "/users/#{@user.id}"
    else
      redirect "/login"
    end
   
  end

  # User SHOW Route
  get "/users/:id" do
    @user = User.find_by(id: params[:id])
    
    erb :"/users/show.html"
  end

  get '/logout' do
    session.clear
    redirect '/'
  end

  # GET: /users/5/edit
  get "/users/:id/edit" do
    erb :"/users/edit.html"
  end

  # PATCH: /users/5
  patch "/users/:id" do
    redirect "/users/:id"
  end

  # DELETE: /users/5/delete
  delete "/users/:id/delete" do
    redirect "/users"
  end
end
