# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Response, type: :model do
  context 'relations' do
    it { should belong_to(:feedback) }
    it { should belong_to(:question) }
  end

  context 'validations' do
    subject { build(:response) }

    context 'if question is choice' do
      before { allow(subject.question).to receive(:choice?).and_return(true) }
      it { should validate_presence_of(:option) }
    end

    context 'if question is text' do
      before { allow(subject.question).to receive(:text?).and_return(true) }
      it { should validate_presence_of(:body) }
    end
  end
end
