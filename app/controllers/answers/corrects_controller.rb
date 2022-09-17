module Answers
  class CorrectsController < ApplicationController
    def show
      @question = Question.find(params[:question_id])
      @answer = @question.answers.find(params[:answer_id])
      unmark_current_correct
      @answer.toggle!(:correct_answer)
      head :ok
    end

    private

    def unmark_current_correct
      return unless current_correct
      # return if current_correct == @answer

      current_correct.update(correct_answer: false)
    end

    def current_correct
      @current_correct ||= @question.answers.find_by(correct_answer: true)
    end
  end
end