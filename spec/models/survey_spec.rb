# frozen_string_literal: true

# spec/models/user_spec.rb
require 'rails_helper'

RSpec.describe Survey, type: :model do
  context 'relations' do
    it { should have_many(:questions) }
    it { should have_many(:feedbacks) }
  end

  context 'validations' do
    it { should validate_presence_of(:name) }
  end
end
