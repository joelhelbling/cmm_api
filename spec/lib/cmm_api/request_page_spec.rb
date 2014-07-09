require 'cmm_api/request_page'

module CmmApi
  describe RequestPage do
    subject { described_class.new pa_json }

    it 'has question sets' do
      expect(subject.question_sets.count).to eq(1)
    end

    it 'renders json' do
      expect(subject.to_json).to eq(pa_json.to_json)
    end

    def pa_json
      {
        'request_page' => {
          'data' => {
            'pa_request' => {}
          },
          'forms' => {
            'pa_request' => {
              'question_sets' => [
                {
                  'title' => 'Patient details',
                  'questions' => []
                }
              ]
            }
          }
        }
      }
    end

  end
end
