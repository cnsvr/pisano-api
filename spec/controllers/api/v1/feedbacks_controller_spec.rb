# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::FeedbacksController, type: :controller do
  let!(:feedbacks) { create_list(:feedback, 3) }

  describe 'GET #index' do
    it 'returns all feedbacks' do
      get :index
      expect(response).to have_http_status(:success)
      expect(parsed_json_body.size).to eq(3)
      expect(parsed_json_body.first['survey']['id']).to eq(feedbacks.first.survey_id)
    end
  end

  describe 'GET #show' do
    it 'returns a feedback' do
      get :show, params: { id: feedbacks.first.id }
      expect(response).to have_http_status(:success)
      expect(parsed_json_body['survey']['name']).to eq(feedbacks.first.survey.name)
    end

    it 'returns an error if the feedback does not exist' do
      get :show, params: { id: -1 }
      expect(response).to have_http_status(:not_found)
      expect(parsed_json_body['error'].present?).to eq(true)
    end
  end

  describe 'POST #create' do
    it 'creates a feedback' do
      post :create, params: { feedback: { survey_id: feedbacks.first.survey.id } }
      expect(response).to have_http_status(:created)
      expect(parsed_json_body['survey']['id']).to eq(feedbacks.first.survey.id)
    end

    it 'returns an error if the feedback is invalid' do
      post :create, params: { feedback: {survey_id: '123456' } }
      expect(response).to have_http_status(:unprocessable_entity)
      expect(parsed_json_body['survey']).to eq(["must exist"])
    end

    it 'returns an error if the feedback params are missing' do
      post :create, params: { feedback: { } }
      expect(response).to have_http_status(:bad_request)
      expect(parsed_json_body['error']).to eq("param is missing or the value is empty: feedback")
    end
  end

  describe 'PUT #update' do
    it 'updates a feedback' do
      put :update, params: { id: feedbacks.first.id, feedback: { survey_id: feedbacks.second.survey.id  } }
      expect(response).to have_http_status(:success)
      expect(parsed_json_body['survey']['name']).to eq(feedbacks.second.survey.name)
    end

    it 'returns an error if the feedback is invalid' do
      put :update, params: { id: feedbacks.first.id, feedback: { survey_id: '123456' } }
      expect(response).to have_http_status(:unprocessable_entity)
      expect(parsed_json_body['survey']).to eq(["must exist"])
    end
  end

  describe 'DELETE #destroy' do
    it 'deletes a feedback' do
      delete :destroy, params: { id: feedbacks.first.id }
      expect(response).to have_http_status(:success)
      expect(Feedback.find_by(id: feedbacks.first.id)).to be_nil
    end

    it 'raises an error if the feedback does not exist' do
      delete :destroy, params: { id: -1 } 
      expect(response).to have_http_status(:not_found)
      expect(parsed_json_body['error'].present?).to eq(true)
    end
  end
end