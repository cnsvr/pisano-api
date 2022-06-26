# frozen_string_literal: true

module Api
  module V1
    # This is the controller for the questions API.
    class QuestionsController < ApplicationController
      before_action :set_question, only: %i[show update destroy]

      # GET /questions
      def index
        @questions = Question.all

        render json: @questions
      end

      # GET /questions/1
      def show
        render json: @question
      end

      # POST /questions
      def create
        @question = Question.new(question_params.except(:options))

        create_options
        if @question.save
          render json: @question, status: :created
        else
          render json: @question.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /questions/1
      def update
        @question.assign_attributes(question_params.except(:options))

        update_options
        if @question.save
          render json: @question
        else
          render json: @question.errors, status: :unprocessable_entity
        end
      end

      # DELETE /questions/1
      def destroy
        @question.destroy
      end

      private

      # Use callbacks to share common setup or constraints between actions.
      def set_question
        @question = Question.find(params[:id])
      end

      # Only allow a list of trusted parameters through.
      def question_params
        params.permit(:title, :type, :survey_id, options: [:title]).to_h
      end

      def create_options
        return unless question_params[:type] == 1 # 0 is text, 1 is choice

        options_params = question_params[:options]
        options = []
        options_params.each do |option|
          next if option[:title].blank?

          options << Option.new(title: option[:title])
        end
        @question.options = options
      end

      def update_options
        if question_params[:type] == 1 # 0 is text, 1 is choice
          options_params = question_params[:options]
          options = []
          options_params.each do |option|
            next if option[:title].blank?

            option = Option.find_or_initialize_by(title: option[:title], question_id: @question.id)
            options << option
          end
          @question.options = options
        else
          @question.options.destroy_all
        end
      end
    end
  end
end
