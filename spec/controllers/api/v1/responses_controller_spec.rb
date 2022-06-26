# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::ResponsesController, type: :controller do
  let!(:responses) { create_list(:response, 3) }

  describe 'GET #index' do
    it 'returns all responses' do
      get :index
      expect(response).to have_http_status(:success)
      expect(parsed_json_body.size).to eq(3)
      expect(parsed_json_body.first['feedback']['id']).to eq(responses.first.feedback_id)
    end
  end

  describe 'GET #show' do
    it 'returns a response' do
      get :show, params: { id: responses.first.id }
      expect(response).to have_http_status(:success)
      expect(parsed_json_body['feedback']['id']).to eq(responses.first.feedback_id)
    end

    it 'returns an error if the response does not exist' do
      get :show, params: { id: -1 }
      expect(response).to have_http_status(:not_found)
      expect(parsed_json_body['error'].present?).to eq(true)
    end
  end

  describe 'POST #create' do
    it 'creates a response' do
      post :create,
           params: { response: { feedback_id: responses.first.feedback_id, question_id: responses.first.question_id,
                                 body: 'Answer' } }
      expect(response).to have_http_status(:created)
      expect(parsed_json_body['question']['id']).to eq(responses.first.question_id)
    end

    it 'create a response with choice question' do
      question = create(:question, :with_options)
      post :create,
           params: { response: { feedback_id: responses.first.feedback_id, question_id: question.id,
                                 option_id: question.options.first.id } }
      expect(response).to have_http_status(:created)
      expect(parsed_json_body['question']['id']).to eq(question.id)
    end

    it 'returns an error if the response params is invalid' do
      post :create,
           params: { response: { feedback_id: responses.first.feedback_id, question_id: responses.first.question_id } }
      expect(response).to have_http_status(:unprocessable_entity)
      expect(parsed_json_body['body']).to eq(["can't be blank"])
    end
  end

  describe 'PUT #update' do
    it 'updates a response' do
      put :update, params: { id: responses.first.id, response: { body: 'Answer' } }
      expect(response).to have_http_status(:success)
      expect(parsed_json_body['body']).to eq('Answer')
    end

    it 'returns an error if the response params is invalid' do
      put :update, params: { id: responses.first.id, response: { body: '' } }
      expect(response).to have_http_status(:unprocessable_entity)
      expect(parsed_json_body['body']).to eq(["can't be blank"])
    end
  end

  describe 'DELETE #destroy' do
    it 'deletes a response' do
      delete :destroy, params: { id: responses.first.id }
      expect(response).to have_http_status(:success)
    end
  end
end
