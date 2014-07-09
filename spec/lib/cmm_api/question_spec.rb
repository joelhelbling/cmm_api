require 'spec_helper'
require 'cmm_api/question'

module CmmApi
  describe Question do
    let(:question_base) do
        { 'question_id'              => 'question_id',
          'question_text'            => 'Question Text',
          'default_next_question_id' => 'next_question',
          'flag'                     => 'REQUIRED',
          'help_text'                => 'helpful explanation' }
    end
    subject { described_class.new question }

    shared_examples_for "a question" do
      its(:question_id) { should == 'question_id' }
      its(:question_text) { should == 'Question Text' }
      its(:default_next_question_id) { should == 'next_question' }
      its(:label) { should == :question_id }
      it { should be_required }
      its(:help_text) { should == 'helpful explanation' }
      its(:to_json) { should == question.to_json }
    end

    context 'free_text' do
      let(:question) { question_base.merge 'question_type' => 'FREE_TEXT' }

      it_behaves_like "a question"

      its(:question_type) { should == 'FREE_TEXT' }
    end

    context 'choice' do
      let(:question) do
        question_base.merge(
          { 'question_type' => 'CHOICE',
            'choices' => [
              { 'choice_text' => 'Yes', 'choice_id' => 'qid_y', 'next_question_id' => 'next_question' },
              { 'choice_text' => 'No', 'choice_id' => 'qid_n' }
            ],
            'select_multiple' => false
          }
        )
      end

      it_behaves_like "a question"

      its(:question_type) { should == 'CHOICE' }

      it 'has choices' do
        subject.choices.count == 2
      end

      describe 'choice' do
        let(:choice) { subject.choices.first }
        it('has text') { choice.choice_text == 'Yes' }
        it('has an id') { choice.choice_id == 'qid_y' }
        it('has a next question id') { choice.next_question_id == 'next_question' }
      end

      describe 'allow multiple choice' do
        let(:question) { question_base.merge 'question_type' => 'CHOICE', 'select_multiple' => true }
        it { should be_select_multiple }
      end

      describe 'do not allow multiple choice' do
        let(:question) { question_base.merge 'question_type' => 'CHOICE', 'select_multiple' => false }
        it { should_not be_select_multiple }
      end
    end

  end
end
