# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Feedback, type: :model do
  context 'relations' do
    it { should belong_to(:survey) }
    it { should have_many(:responses) }
  end
end
