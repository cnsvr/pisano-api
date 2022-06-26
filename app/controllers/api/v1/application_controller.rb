# frozen_string_literal: true

module Api
  module V1
    # This is the controller for handling some of the API requests.
    class ApplicationController < ActionController::API
      rescue_from ActiveRecord::RecordNotFound do |exception|
        render json: { error: exception.message }, status: :not_found
      end

      rescue_from ActionController::ParameterMissing do |exception|
        render json: { error: exception.message.split("\n").first }, status: :bad_request
      end
    end
  end
end
