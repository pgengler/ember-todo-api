class TagsController < ApplicationController
	def index
		render json: Tag.includes(:item_tags).all
	end

	def create
		@tag = Tag.create!(tag_params)
		render json: @tag, status: :created, location: @tag
	end

	def update
		@tag = Tag.find(params[:id])
		@tag.update tag_params

		render json: @tag, location: @tag
	end

	private

	def tag_params
		params.required(:tag).permit(:name)
	end
end