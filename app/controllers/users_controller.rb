class UsersController < ApplicationController

  # GET login
  get "/login" do
    erb :"/users/login.html"
  end

  # GET new user at /users/signup
  get "/users/signup" do
    erb :"/users/signup.html"
  end

    # GET new user at /users/signup
  post "/users/signed_in" do
    binding.pry
  end

  # POST login
  post '/login' do 
  @user = User.find_by(username: params[:username])
    if @user.authenticate(params[:password])
    session[:user_id] = @user.id
    puts session
    redirect "/users/#{@user.id}"
    else
    end
    redirect "/users"
  end

  # User SHOW Route
  get "/users/:id" do
    erb :"/users/show.html"
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
