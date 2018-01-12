require 'pry'

class RecipeController < ApplicationController

  get "/recipes" do
    if logged_in?
      @user = current_user
      @recipes = Recipe.all
      erb :'recipes/recipes'
    else
      redirect to '/users/login'
    end
  end

  get "/recipes/new" do
    if logged_in?
      erb :'recipes/create_recipe'
    else
      redirect to '/login'
    end
  end

   post "/recipes" do
    if params[:name].empty?
      redirect '/recipes/new'
    else
      @recipe = Recipe.create(:name => params[:name], :ingredients => params[:ingredients], :instructions => params[:instructions])
      @recipe.user_id = current_user.id
      @recipe.save
      redirect "/recipes/#{@recipe.slug}"
    end
  end

  get "/recipes/:slug/edit" do
    if logged_in?
      @recipe = Recipe.find_by_slug(params[:slug])
        erb :'/recipes/edit_recipe'
      else
      redirect "/users/login"
    end
  end

  get "/recipes/:slug" do
    if logged_in?
      @recipe = Recipe.find_by_slug(params[:slug])
      erb :'recipes/show_recipes'
    else
      redirect '/users/login'
    end
  end

  patch "/recipes/:slug" do
    @recipe = Recipe.find_by_slug(params[:slug])
    binding.pry
    if !Recipe.find_by(name: params[:name])
       redirect "/recipes/new"
     else

      @recipe.update(name: params[:name], ingredients: params[:ingredients], instructions: params[:instructions])
      @recipe.save
      redirect "/recipes/#{@recipe.slug}"
    end
  end

  delete "/recipes/:slug/delete" do
    @recipe = Recipe.find_by_slug(params[:slug])
    if logged_in? && @recipe.user_id == current_user.id
      @recipe.delete
      redirect '/recipes'
    else
      redirect '/login'
    end
  end
end