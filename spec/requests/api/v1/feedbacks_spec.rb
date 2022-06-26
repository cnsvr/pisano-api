require 'swagger_helper'

RSpec.describe 'api/v1/feedbacks', type: :request do

  path '/api/v1/feedbacks' do

    get('list feedbacks') do
      response(200, 'successful') do

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end

    post('create feedback') do
      response(200, 'successful') do
        consumes 'application/json'
        parameter name: :feedback, in: :body, schema: {
          type: :object,
          properties: {
            survey_id: { type: :string }
          },
          required: %w[survey_id]
        }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end
  end

  path '/api/v1/feedbacks/{id}' do
    # You'll want to customize the parameter types...
    parameter name: 'id', in: :path, type: :string, description: 'id'

    get('show feedback') do
      response(200, 'successful') do
        let(:id) { '123' }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end

    patch('update feedback') do
      response(200, 'successful') do
        let(:id) { '123' }
        consumes 'application/json'
        parameter name: :feedback, in: :body, schema: {
          type: :object,
          properties: {
            survey_id: { type: :string }
          },
          required: %w[survey_id]
        }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end

    put('update feedback') do
      response(200, 'successful') do
        let(:id) { '123' }
        consumes 'application/json'
        parameter name: :feedback, in: :body, schema: {
          type: :object,
          properties: {
            survey_id: { type: :string }
          },
          required: %w[survey_id]
        }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end

    delete('delete feedback') do
      response(200, 'successful') do
        let(:id) { '123' }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end
  end
end
