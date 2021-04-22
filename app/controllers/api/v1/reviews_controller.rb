class Api::V1::ReviewsController < ApplicationController
	before_action :authorized
	before_action :find_recipe
	before_action :find_review, only: [:show, :update, :destroy]


	def new
		@reviews = Review.where(user_id: @user.id)
		render json: @reviews
	end

	def create
		@review = Review.new(review_params)
		# associate review with current recipe and current user
		@review.recipe_id = @recipe.id
		@review.user_id = @user.id
			if @review.save
				redirect_to @recipe
			else
				render 'new'
			end
	end

	def edit
		if @review.user_id != @user.id
			redirect_to root_url
		end
	end

	def update
		if @review.update(review_params)
			redirect_to recipe_path(@recipe)
		else
			render 'edit'
		end
	end

	def destroy
    @review.destroy
    redirect_to @recipe
	end


	private

	def review_params
		parmas.require(:review).permit(:rating, :comment)
	end

	def find_recipe
		@recipe = Recipe.find(params[:recipe_id])
	end

	def find_review
		@review = Review.find(params[:id])
	end

end
