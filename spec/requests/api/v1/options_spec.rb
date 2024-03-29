require 'swagger_helper'

RSpec.describe 'api/v1/options', type: :request do

  path '/api/v1/options' do

    get('list options') do
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

    post('create option') do
      response(200, 'successful') do
        consumes 'application/json'
        parameter name: :option, in: :body, schema: {
          type: :object,
          properties: {
            title: { type: :string },
            question_id: { type: :string }
          },
          required: %w[title question_id]
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

  path '/api/v1/options/{id}' do
    # You'll want to customize the parameter types...
    parameter name: 'id', in: :path, type: :string, description: 'id'

    get('show option') do
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

    patch('update option') do
      response(200, 'successful') do
        let(:id) { '123' }
        consumes 'application/json'
        parameter name: :option, in: :body, schema: {
          type: :object,
          properties: {
            title: { type: :string },
            question_id: { type: :string }
          },
          required: %w[title question_id]
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

    put('update option') do
      response(200, 'successful') do
        let(:id) { '123' }
        consumes 'application/json'
        parameter name: :option, in: :body, schema: {
          type: :object,
          properties: {
            title: { type: :string },
            question_id: { type: :string }
          },
          required: %w[title question_id]
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

    delete('delete option') do
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
