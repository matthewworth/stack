class StoriesController < ApplicationController
	before_action :find_story, only: [:show, :edit, :update, :destroy]
	def index
		# @string = "My string of characters"
		# @time = Time.now
		
		if params[:sort] == "popular"
			@stories = Story.all.order('votes_count DESC')
		elsif params[:sort] == "featured"
			@stories = Story.where(is_featured: true)
		else
		@stories = Story.all.order('created_at DESC')
		end
	end

	def show
		# @story = Story.find(params[:id])
	end

	def new
		@story = Story.new
	end

	def create
		@story = Story.new(story_params)
		if @story.save
			flash[:success] = "Thank you for submitting a story!"
			redirect_to root_path
		else
			flash[:error] = "Oh dear - something went wrong. Please try again and check all the forms are filled in!"
			render :new
		end
	end


	def edit
		# "story = Story.find(params[:id])"
	end	

	def destroy
		# @story = Story.find(params[:id] )
		

		@story = Story.find(params[:id])
		
		if	@story.present?
		
			flash[:success] = "Story \"#{@story.title}\" successfully deleted"
			@story.destroy
		
		else
		
			flash[:error] = "Oops, no story found with id #{[params[:is]]}"
		
		end
		
		redirect_to root_path
	
	end 

	def update
		# @story = Story.find(params[:id])"
		if @story.update(story_params)
			
			flash[:success] = "Thank you for updating this story!"
			redirect_to story_path(@story)
		
		else
			
			flash[:error] = "Oops. Something went wrong - please try again!"
			
			render :edit
		end

	end

	def story_params
		params.require(:story).permit(:title, :url, :description)
	end

	def find_story
		@story = Story.find(params[:id])
	end
end
