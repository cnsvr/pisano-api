# frozen_string_literal: true

module Api
  module V1
    # This is the controller for the surveys API.
    class SurveysController < ApplicationController
      before_action :set_survey, only: %i[show update destroy create_feedback]

      # GET /surveys
      def index
        @surveys = Survey.all

        render json: @surveys, include: ['feedbacks.responses.question', 'feedbacks.responses.option', 'feedbacks.responses.body']
      end

      # GET /surveys/1
      def show
        render json: @survey, include: ['feedbacks.responses.question', 'feedbacks.responses.option', 'feedbacks.responses.body']
      end

      # POST /surveys
      def create
        @survey = Survey.new(survey_params)

        if @survey.save
          render json: @survey, status: :created
        else
          render json: @survey.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /surveys/1
      def update
        if @survey.update(survey_params)
          render json: @survey
        else
          render json: @survey.errors, status: :unprocessable_entity
        end
      end

      # DELETE /surveys/1
      def destroy
        @survey.destroy
      end

      def create_feedback
        if feedback_params[:feedback].nil?
          render json: { error: 'feedback param is missing' }, status: :unprocessable_entity
        else
          # TODO:  Write here more clearly !!!!
          feedback = Feedback.new(survey: @survey)
          feedback.save

          build_responses(feedback)

          if feedback.responses.empty? || feedback.invalid?
            feedback.destroy
            head :no_content # returns no content if no responses were created.
          else
            render json: @survey, include: ['feedbacks.responses.question', 'feedbacks.responses.option', 'feedbacks.responses.body']
          end
        end
      end

      private

      # Use callbacks to share common setup or constraints between actions.
      def set_survey
        @survey = Survey.find(params[:id])
      end

      # Only allow a list of trusted parameters through.
      def survey_params
        params.require(:survey).permit(:name)
      end

      def feedback_params
        params.permit(feedback: %i[question_id body option_id]).to_h
      end

      # rubocop:disable Metrics/AbcSize
      def build_responses(feedback)
        params = feedback_params[:feedback]

        params.each do |param|
          question = Question.find_by(id: param[:question_id])
          next unless question.present?

          response = feedback.responses.build(question:)
          if question.text?
            body = param[:body]
            next unless body.present?

            response.body = body
          elsif question.choice?
            option = Option.find_by(id: param[:option_id])
            next unless option.present?

            response.option = option
          end

          response.save
        end
      end
      # rubocop:enable Metrics/AbcSize
    end
  end
end
