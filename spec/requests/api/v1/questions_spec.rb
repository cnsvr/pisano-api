require 'swagger_helper'

RSpec.describe 'api/v1/questions', type: :request do

  path '/api/v1/questions' do

    get('list questions') do
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

    post('create question') do
      response(200, 'successful') do
        consumes 'application/json'
        parameter name: :question, in: :body, schema: {
          type: :object,
          properties: {
            title: { type: :string },
            type: { type: :number },
            survey_id: { type: :string },
            options: {
              type: :array,
              message: 'it is required when question type is choice (1)',
              items: {
                type: :object,
                properties: {
                  title: { type: :string }
                }
              }
            }
          },
          required: %w[title survey_id]
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

  path '/api/v1/questions/{id}' do
    # You'll want to customize the parameter types...
    parameter name: 'id', in: :path, type: :string, description: 'id'

    get('show question') do
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

    patch('update question') do
      response(200, 'successful') do
        let(:id) { '123' }
        consumes 'application/json'
        parameter name: :question, in: :body, schema: {
          type: :object,
          properties: {
            title: { type: :string },
            type: { type: :number },
            survey_id: { type: :string },
            options: {
              type: :array,
              message: 'it is required when question type is choice (1)',
              items: {
                type: :object,
                properties: {
                  title: { type: :string }
                }
              }
            }
          },
          required: %w[title survey_id]
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

    put('update question') do
      response(200, 'successful') do
        let(:id) { '123' }
        consumes 'application/json'
        parameter name: :question, in: :body, schema: {
          type: :object,
          properties: {
            title: { type: :string },
            type: { type: :number },
            survey_id: { type: :string },
            options: {
              type: :array,
              message: 'it is required when question type is choice (1)',
              items: {
                type: :object,
                properties: {
                  title: { type: :string }
                }
              }
            }
          },
          required: %w[title survey_id]
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

    delete('delete question') do
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
