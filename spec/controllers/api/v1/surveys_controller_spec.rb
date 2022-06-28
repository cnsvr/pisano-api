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

  describe 'POST #create_feedback' do
    it 'creates a feedback' do
      question = create(:question)
      post :create_feedback, params: { id: surveys.first.id, feedback: [{ question_id: question.id, body: 'Test' }] }
      expect(response).to have_http_status(:success)
      expect(parsed_json_body['feedbacks'].size).to eq(1)
      expect(parsed_json_body['feedbacks'].first['responses'].size).to eq(1)
      expect(parsed_json_body['feedbacks'].first['responses'].first['body']).to eq('Test')
    end

    it 'creates more than a feedback' do
      question1 = create(:question)
      question2 = create(:question)
      question3 = create(:question, :with_options)
      post :create_feedback,
           params: { id: surveys.first.id,
                     feedback: [{ question_id: question1.id, body: 'Test_1' }, { question_id: question2.id, body: 'Test_2' },
                                { question_id: question3.id, option_id: question3.options.last }] }
      expect(response).to have_http_status(:success)
      expect(parsed_json_body['feedbacks'].size).to eq(1)
      expect(parsed_json_body['feedbacks'].first['responses'].size).to eq(3)
      expect(parsed_json_body['feedbacks'].first['responses'].first['body']).to eq('Test_1')
      expect(parsed_json_body['feedbacks'].first['responses'].second['body']).to eq('Test_2')
      expect(parsed_json_body['feedbacks'].first['responses'].third['option']['id']).to eq(question3.options.last.id)
    end

    it 'returns no content if no valid feedback exists' do
      question = create(:question)
      post :create_feedback, params: { id: surveys.first.id, feedback: [{ question_id: question.id, body: '' }] }
      expect(response).to have_http_status(:no_content)
    end

    it 'returns an error if the feedback params are missing' do
      post :create_feedback, params: { id: surveys.first.id, attr: {} }
      expect(response).to have_http_status(:unprocessable_entity)
      expect(parsed_json_body['error']).to eq('feedback param is missing')
    end
  end
end
