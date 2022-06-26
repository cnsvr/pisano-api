# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::SurveysController, type: :controller do
  let!(:surveys) { create_list(:survey, 3) }

  describe 'GET #index' do
    it 'returns all surveys' do
      get :index
      expect(response).to have_http_status(:success)
      expect(parsed_json_body.size).to eq(3)
      expect(parsed_json_body.first['name']).to eq(surveys.first.name)
    end
  end

  describe 'GET #show' do
    it 'returns a survey' do
      get :show, params: { id: surveys.first.id }
      expect(response).to have_http_status(:success)
      expect(parsed_json_body['name']).to eq(surveys.first.name)
    end

    it 'returns an error if the survey does not exist' do
      get :show, params: { id: -1 }
      expect(response).to have_http_status(:not_found)
      expect(parsed_json_body['error'].present?).to eq(true)
    end
  end

  describe 'POST #create' do
    it 'creates a survey' do
      post :create, params: { survey: { name: 'Test Survey' } }
      expect(response).to have_http_status(:created)
      expect(parsed_json_body['name']).to eq('Test Survey')
    end

    it 'returns an error if the survey is invalid' do
      post :create, params: { survey: { name: '' } }
      expect(response).to have_http_status(:unprocessable_entity)
      expect(parsed_json_body['name']).to eq(["can't be blank"])
    end

    it 'returns an error if the survey params are missing' do
      post :create, params: { survey: {} }
      expect(response).to have_http_status(:bad_request)
      expect(parsed_json_body['error']).to eq('param is missing or the value is empty: survey')
    end
  end

  describe 'PUT #update' do
    it 'updates a survey' do
      put :update, params: { id: surveys.first.id, survey: { name: 'Test Survey' } }
      expect(response).to have_http_status(:success)
      expect(parsed_json_body['name']).to eq('Test Survey')
    end

    it 'returns an error if the survey is invalid' do
      put :update, params: { id: surveys.first.id, survey: { name: '' } }
      expect(response).to have_http_status(:unprocessable_entity)
      expect(parsed_json_body['name']).to eq(["can't be blank"])
    end
  end

  describe 'DELETE #destroy' do
    it 'deletes a survey' do
      delete :destroy, params: { id: surveys.first.id }
      expect(response).to have_http_status(:success)
      expect(Survey.find_by(id: surveys.first.id)).to be_nil
    end

    it 'raises an error if the survey does not exist' do
      delete :destroy, params: { id: -1 }
      expect(response).to have_http_status(:not_found)
      expect(parsed_json_body['error'].present?).to eq(true)
    end
  end
end
