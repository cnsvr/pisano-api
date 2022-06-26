require 'swagger_helper'

RSpec.describe 'api/v1/responses', type: :request do

  path '/api/v1/responses' do

    get('list responses') do
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

    post('create response') do
      response(200, 'successful') do
        consumes 'application/json'
        parameter name: :response, in: :body, schema: {
          type: :object,
          message: 'body or option_id is required',
          properties: {
            feedback_id: { type: :string },
            question_id: { type: :string },
            body: { type: :string },
            option_id: { type: :string }
          },
          required: %w[feedback_id question_id]
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

  path '/api/v1/responses/{id}' do
    # You'll want to customize the parameter types...
    parameter name: 'id', in: :path, type: :string, description: 'id'

    get('show response') do
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

    patch('update response') do
      response(200, 'successful') do
        let(:id) { '123' }
        parameter name: :response, in: :body, schema: {
          type: :object,
          message: 'body or option_id is required',
          properties: {
            feedback_id: { type: :string },
            question_id: { type: :string },
            body: { type: :string },
            option_id: { type: :string }
          },
          required: %w[feedback_id question_id]
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

    put('update response') do
      response(200, 'successful') do
        let(:id) { '123' }
        parameter name: :response, in: :body, schema: {
          type: :object,
          message: 'body or option_id is required',
          properties: {
            feedback_id: { type: :string },
            question_id: { type: :string },
            body: { type: :string },
            option_id: { type: :string }
          },
          required: %w[feedback_id question_id]
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

    delete('delete response') do
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
