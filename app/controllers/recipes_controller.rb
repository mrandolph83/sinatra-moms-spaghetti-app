class RecipesController < ApplicationController

  # GET: /recipes
  get "/recipes" do
    erb :"/recipes/index.html"
  end

  # GET: /recipes/new
  get "/recipes/new" do
    erb :"/recipes/new.html"
  end

  # POST: /recipes
  post "/recipes" do
    # I only want to create if it has content
    # I only want to save if it has content
    # I also only want to create a recipe if a user is logged in
    if !logged_in?
      redirect '/'
    end

    if params[:content] != ""
      # create a new recipe. also create a new category class, maybe
      # gorup it with rating in a classify class
      @recipe = Recipe.create(title: params[:title], content: params[:content], category: params[:category], simple_review: params[:simple_review], user_id: current_user.id)
    
      redirect "/recipes/#{@recipe.id}"

    else
    end
  end

  # GET: Recipe Show Page
  get "/recipes/:id" do
    @recipe = Recipe.find_by(id: params[:id])
    erb :"/recipes/show.html"
  end

  # GET: /recipes/5/edit
  get "/recipes/:id/edit" do
    erb :"/recipes/edit.html"
  end

  # PATCH: /recipes/5
  patch "/recipes/:id" do
    redirect "/recipes/:id"
  end

  # DELETE: /recipes/5/delete
  delete "/recipes/:id/delete" do
    redirect "/recipes"
  end
end
