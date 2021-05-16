class ReviewsController < ApplicationController

  # GET: /reviews
  get "/reviews" do
    # @reviews = Review.all
    erb :"/reviews/index.html"
  end

  # GET: /reviews/new
  get "/reviews/new" do
    erb :"/reviews/new.html"
  end

  # POST: /reviews
  post "/reviews" do
    # I only want to create if it has content
    # I only want to save if it has content
    # I also only want to create a recipe if a user is logged in
    if !logged_in?
      flash[:errors] = "You must login or sign up to perform this action."
      redirect '/'
    end

    if params[:content] != ""
      # create a new recipe. also create a new category class, maybe
      # gorup it with rating in a classify class
      @recipe = Recipe.create(title: params[:title], content: params[:content], category: params[:category], user_id: current_user.id)
      flash[:message] = "Thanks for adding to our recipe community!"
      redirect "/reviews/#{@recipe.id}"
      # Recirects destroy 
    else
      flash[:message] = "Please enter your recipe information below."
      redirect '/reviews/new'
    end
  end

  # GET: Recipe Show Page
  get "/reviews/:id" do
   set_recipe
    # binding.pry
    erb :"/reviews/show.html"
  end

  # GET: Edit Recipe to edit.erb, so you can render an edit form with patch
  get "/reviews/:id/edit" do 
    set_recipe
    if logged_in?
    if @recipe.user == current_user
    erb :"/reviews/edit.html"
    else
      redirect "users/#{current_user.id}"
    end
  else
    flash[:errors] = "You must login or sign up to perform this action."
    redirect "/"
    end
  end

  # PATCH: /reviews/5
  patch "/reviews/:id" do
    set_recipe
    if logged_in?
      if @recipe.user == current_user && params[:content] != ""
  # Find the recipe
  # Update the recipe
  # REdirect to show page
    @recipe.update(title: params[:title], content: params[:content], category: params[:category], simple_review: params[:simple_review])
    redirect "/reviews/#{@recipe.id}"
      else 
        redirect "users/#{current_user.id}"
  end
  else
    flash[:errors] = "You must login or sign up to perform this action."
  redirect "/"
  end
end

  # DELETE: /reviews/5/delete
  delete "/reviews/:id/delete" do
    set_recipe
    if @recipe.user == current_user
      @recipe.destroy
      redirect "/reviews"
    else
      redirect "/reviews"
    end
    
  end

  private

  def set_recipe
    @recipe = Recipe.find(params[:id])
  end
end
