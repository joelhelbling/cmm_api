require 'json'
require 'cmm_api/question_set'

module CmmApi
  class RequestPage

    def initialize(request_page)
      @request_page = request_page
    end

    def question_sets
      @request_page['request_page']['forms']['pa_request']['question_sets'].map do |qs|
        QuestionSet.new qs
      end
    end

    def to_json
      @request_page.to_json
    end

  end
end
