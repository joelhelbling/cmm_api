require 'spec_helper'
require 'cmm_api/question_set'

module CmmApi
  describe QuestionSet do
    subject { described_class.new question_set }

    it 'has a title' do
      expect(subject.title).to eq('Patient details')
    end

    it 'has questions' do
      expect(subject.questions.count).to eq(1)
    end

    it 'renders json' do
      expect(subject.to_json).to eq(question_set.to_json)
    end

    def question_set
      {
        'title' => 'Patient details',
        'questions' => [
          'question_type' => 'FREE_TEXT',
          'question_id' => 'patient_fullname',
          'question_text' => 'Patient Name',
          'default_next_question_id' => 'patient_dob',
          'flag' => 'REQUIRED',
          'help_text' => 'Full name (first last)'
        ]
      }
    end
  end
end
