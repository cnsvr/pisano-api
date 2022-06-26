# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::QuestionsController, type: :controller do
  let!(:questions) { create_list(:question, 3) }
  let!(:option) { create(:option, question: questions.first) }
  let!(:survey) { create(:survey) }

  describe 'GET #index' do
    it 'returns all questions' do
      get :index
      expect(response).to have_http_status(:success)
      expect(parsed_json_body.size).to eq(3)
      expect(parsed_json_body.first['title']).to eq(questions.first.title)
    end
  end

  describe 'GET #show' do
    it 'returns a question' do
      get :show, params: { id: questions.first.id }
      expect(response).to have_http_status(:success)
      expect(parsed_json_body['title']).to eq(questions.first.title)
    end

    it 'returns an error if the question does not exist' do
      get :show, params: { id: -1 }
      expect(response).to have_http_status(:not_found)
      expect(parsed_json_body['error'].present?).to eq(true)
    end
  end

  describe 'POST #create' do
    it 'creates a question' do
      post :create, params: { title: 'Test Question', survey_id: survey.id }
      expect(response).to have_http_status(:created)
      expect(parsed_json_body['title']).to eq('Test Question')
    end

    it 'creates a question with options' do
      post :create,
           params: { title: 'Test Question', type: 1, survey_id: survey.id, options: [{ title: 'Test Option' }] }, as: :json
      expect(response).to have_http_status(:created)
      expect(parsed_json_body['title']).to eq('Test Question')
      expect(parsed_json_body['options'].first['title']).to eq('Test Option')
    end

    it 'returns an error if the question params is invalid' do
      post :create, params: { title: 'Question-1', survey_id: '1234' }
      expect(response).to have_http_status(:unprocessable_entity)
      expect(parsed_json_body['survey']).to eq(['must exist'])
    end
  end

  describe 'PUT #update' do
    it 'updates a question' do
      put :update, params: { id: questions.first.id, title: 'Test Question' }
      expect(response).to have_http_status(:success)
      expect(parsed_json_body['title']).to eq('Test Question')
    end

    it 'updates a question with options' do
      put :update,
          params: { id: questions.first.id, title: 'Test Question', type: 1, options: [{ title: 'Test Option' }] }, as: :json
      expect(response).to have_http_status(:success)
      expect(parsed_json_body['title']).to eq('Test Question')
      expect(parsed_json_body['options'].first['title']).to eq('Test Option')
    end

    it 'updates a question as a text question and destroy options' do
      put :update, params: { id: questions.first.id, title: 'Test Question', type: 0 }, as: :json
      expect(response).to have_http_status(:success)
      expect(parsed_json_body['title']).to eq('Test Question')
      expect(parsed_json_body['options']).to eq(nil)
    end

    it 'returns an error if the question params is invalid' do
      put :update, params: { id: questions.first.id, title: 'Question-1', survey_id: '1234' }
      expect(response).to have_http_status(:unprocessable_entity)
      expect(parsed_json_body['survey']).to eq(['must exist'])
    end
  end

  describe 'DELETE #destroy' do
    it 'deletes a question' do
      delete :destroy, params: { id: questions.first.id }
      expect(response).to have_http_status(:success)
    end
  end
end
