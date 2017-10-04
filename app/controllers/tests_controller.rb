class TestsController < ApplicationController

	skip_authorization_check

	def new
		@question = Poll::Question.new
	end

	def create
		#@question = Poll::Question.new(poll_question_params.merge(author: current_user).merge(poll_question_defaults))
		@question = Poll::Question.find(68)
		@question.attributes = poll_question_params.merge(author: current_user).merge(poll_question_defaults)

    if @question.save
      redirect_to test_path(@question), notice: I18n.t('flash.actions.create.proposal')
    else
      render :new
    end
	end

	def index

	end

	def show
		@question = Poll::Question.find(params[:id])
	end

	def edit
		@question = Poll::Question.new
	end

	def update
		@question = Poll::Question.find(68)
		@question.poll_question_params.merge(author: current_user).merge(poll_question_defaults)

		if @question.save
      redirect_to test_path(@question), notice: I18n.t('flash.actions.create.proposal')
    else
      render :edit
    end
	end

	private

	def poll_question_params
		params.require(:poll_question).permit(images_attributes: [:id, :title, :attachment, :cached_attachment, :user_id, :_destroy])
	end

	def poll_question_defaults
		{ poll: Poll.first,
			title: "Title #{rand(999999)}",
   		description: "Description #{rand(99999)}",
    	valid_answers: "Yes, No, Maybe" }
	end

end