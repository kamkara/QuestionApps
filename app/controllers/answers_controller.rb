class AnswersController < ApplicationController
    before_action :authenticate_user!, except: [:index]
    before_action :set_question
    
    def index
         @answers = @question.answers
      .includes(:user, :rich_text_content)
      .all
      .order(correct_answer: :desc, created_at: :desc)
    end

    def new
        @answer = @question.answers.new
    end

    def create
        @answer = @question.answers.new(user: current_user)
        @answer.attributes = answer_params
        @answer.save!
        render :new, assigns: { question: @question, answer: @question.answers.new }
    end

    def edit
        @answer = @question.answers.find_by(id: params[:id], user: current_user)
        render turbo_stream: turbo_stream.replace(
        "answer_#{@answer.id}",
        partial: "answers/form",
        locals: { question: @question, answer: @answer }
        )
    end

    def update
        @answer = @question.answers.find_by(id: params[:id], user: current_user)
        @answer.update(answer_params)
    end

    def destroy
        @answer = @question.answers.find_by(id: params[:id], user: current_user)
        @answer.destroy
    end

    private

        def set_question
            @question = Question.find(params[:question_id])
        end

        def answer_params
            params.require(:answer).permit(:content)
        end

end
