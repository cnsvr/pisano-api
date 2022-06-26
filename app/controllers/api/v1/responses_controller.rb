# frozen_string_literal: true

module Api
  module V1
    # This is the controller for the responses API.
    class ResponsesController < ApplicationController
      before_action :set_response, only: %i[show update destroy]

      # GET /responses
      def index
        @responses = Response.all

        render json: @responses
      end

      # GET /responses/1
      def show
        render json: @response
      end

      # POST /responses
      def create
        @response = Response.new(response_params)

        if @response.save
          render json: @response, status: :created
        else
          render json: @response.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /responses/1
      def update
        if @response.update(response_params)
          render json: @response
        else
          render json: @response.errors, status: :unprocessable_entity
        end
      end

      # DELETE /responses/1
      def destroy
        @response.destroy
      end

      private

      # Use callbacks to share common setup or constraints between actions.
      def set_response
        @response = Response.find(params[:id])
      end

      # Only allow a list of trusted parameters through.
      def response_params
        params.require(:response).permit(:feedback_id, :question_id, :option_id, :body)
      end
    end
  end
end
