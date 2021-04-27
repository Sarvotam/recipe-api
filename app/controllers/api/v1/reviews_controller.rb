class Api::V1::ReviewsController < ApplicationController
	# before_action :authorized
	before_action :find_recipe
	before_action :find_review, only: [:show, :update, :destroy]

	def index
		@reviews = Review.all
		render json: @reviews
	end

	def new
		@reviews = Review.new
		# @reviews = Review.where(user_id: @user.id)
		render json: @reviews
	end

	def create
		@review = @recipe.reviews.new(anonymous_review)
		@reviews = @recipe.reviews
		if @review.save
			render json: {review: @review, status: :created, recipe: @recipe, reviews: @reviews}
		else
			render json: { errors: @review.errors }, status: :unprocessable_entity
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

	def anonymous_review
		anonymous_review_params = review_params
		if logged_in?
			anonymous_review_params[:user_id] = logged_in_user.id
		else
			anonymous_review_params[:user_id] = nil
		end
		return anonymous_review_params
	end

	private

	def review_params
		params.permit(:rating, :comment, :recipe_id, :user_id)
	end

	def find_recipe
		@recipe = Recipe.find(params[:recipe_id])
	end

	def find_review
		@review = Review.find(params[:id])
	end

end
