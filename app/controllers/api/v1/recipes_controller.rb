class Api::V1::RecipesController < ApplicationController
	before_action :authorized
	before_action :find_recipe, only: [:show, :update, :destroy]

	def index
		@recipes = Recipe.where(user_id: @user.id)
		render json: @recipes
	end

	def show
		render json: @recipe
	end

	def create
		@recipe = Recipe.new(recipe_params)
		@recipe.user_id = @user.id
		if @recipe.save
			render json: @recipe, status: :created, location: @recipe
		else
			render error: { error: "unable to create."}, status: 400
		end			
	end

	def update
		if @recipe.update(recipe_params)
			render json: { message: "successfully updated."}, status: 200
		else
			render json: { error: "ubale to update." }, status: 400
		end
	end

	def destroy
		if @recipe
			@recipe.destroy
			render json: { message: "deleted success."}, status: 200
		else
			render json: { message: "unable to delete." }, status: 400
		end
	end

	private

	def recipe_params
		params.require(:recipe).permit(:name, :category_id, :user_id)
	end

	def find_recipe
		@recipe = Recipe.find(params[:id])
	end
end
