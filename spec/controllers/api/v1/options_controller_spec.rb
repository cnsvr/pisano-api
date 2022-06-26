# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::OptionsController, type: :controller do
  let!(:options) { create_list(:option, 3) }
  
  describe 'GET #index' do
    it 'returns all options' do
        get :index
        expect(response).to have_http_status(:success)
        expect(parsed_json_body.size).to eq(3)
        expect(parsed_json_body.first['title']).to eq(options.first.title)
    end
  end
  
  describe 'GET #show' do
    it 'returns an option' do
        get :show, params: { id: options.first.id } 
        expect(response).to have_http_status(:success)
        expect(parsed_json_body['title']).to eq(options.first.title)
    end
  
    it 'returns an error if the option does not exist' do
        get :show, params: { id: -1 } 
        expect(response).to have_http_status(:not_found)
        expect(parsed_json_body['error'].present?).to eq(true)
    end
  end
  
  describe 'POST #create' do
    it 'creates an option' do
      post :create, params: { option: { title: 'Test Option', question_id: options.first.question.id } }
      expect(response).to have_http_status(:created)
      expect(parsed_json_body['title']).to eq('Test Option')
    end
  
    it 'returns an error if the option params is invalid' do
        post :create, params: { option: { title: 'Option-1', question_id: "1234" } }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(parsed_json_body['question']).to eq(["must exist"])
    end
  end
  
  describe 'PUT #update' do
    it 'updates an option' do
      put :update, params: { id: options.first.id, option: { title: 'Test Option' } }
      expect(response).to have_http_status(:success)
      expect(parsed_json_body['title']).to eq('Test Option')
    end

    it 'returns an error if the option params is invalid' do
      put :update, params: { id: options.first.id, option: { title: '' } }
      expect(response).to have_http_status(:unprocessable_entity)
      expect(parsed_json_body['title']).to eq(["can't be blank"])
    end
  end

  describe 'DELETE #destroy' do
    it 'deletes an option' do
      delete :destroy, params: { id: options.first.id }
      expect(response).to have_http_status(:no_content)
    end
  end
end
