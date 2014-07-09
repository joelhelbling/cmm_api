require 'json'

module CmmApi
  class QuestionSet

    def initialize(question_set)
      @question_set = question_set
    end

    def title
      @question_set['title']
    end

    def to_json
      @question_set.to_json
    end

    def questions
      @question_set['questions'].map do |q|
        Question.new q
      end
    end

  end
end
