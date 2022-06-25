# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Question, type: :model do
  context 'relations' do
    it { should belong_to(:survey) }
    it { should have_many(:options) }
    it { should have_many(:responses) }
  end

  context 'validations' do
    subject { build(:question) }

    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:type) }
    it { should validate_inclusion_of(:type).in_array([0, 1]).with_message('Type has to be 0 or 1') }

    context 'if type is choice' do
      before { allow(subject).to receive(:choice?).and_return(true) }
      it { should validate_presence_of(:options) }
    end
  end
end
