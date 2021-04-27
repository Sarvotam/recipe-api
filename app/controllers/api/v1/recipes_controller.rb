class Api::V1::RecipesController < ApplicationController
	before_action :authorized, only: [ :create, :update, :destroy ]
	before_action :find_recipe, only: %i[ show update destroy ]

	def index
		@recipes = Recipe.all
		# @recipes = Recipe.where(user_id: @user.id)
		render json: @recipes
	end

	def show
		render json: @recipe
	end

	def create
		@recipe = Recipe.new(recipe_params)
		@recipe.category_id = params[:category_id]
		# @recipe.user_id = @user.id
		if @recipe.save
			render json: @recipe, status: :created
		else
			render json: {errors: @recipe.errors}, status: :unprocessable_entity
		end			
	end

	def update
		if @recipe.update(recipe_params)
			render json: { message: "successfully updated."}, status: 200
		else
			render json: { error: "unable to update." }, status: 400
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

	def user_recipe
		if current_user
			@user = @current_user
			@recipes = @user.recipes

			render json: { user: @user, recipe: @recipes}
		end
	end

	private

	def recipe_params
		params.permit(:name, :category_id, :user_id)
	end

	def find_recipe
		@recipe = Recipe.find(params[:id])
	end
end
