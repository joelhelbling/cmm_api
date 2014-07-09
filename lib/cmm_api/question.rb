require 'json'
require 'ostruct'

module CmmApi
  class Question
    attr_reader :choices

    def initialize(question)
      @question = question
      @choices = @question['choices'] && @question['choices'].map do |choice|
        OpenStruct.new choice
      end
    end

    def required?
      self.flag == 'REQUIRED'
    end

    def label
      self.question_id.to_sym
    end

    def select_multiple?
      self.question_type == 'CHOICE' and @question['select_multiple']
    end

    def to_json
      @question.to_json
    end

    def method_missing(method_name, *args, &block)
      @question[method_name.to_s] or super
    end

  end
end
