require 'cmm_api/client'

module CmmApi
  describe Client do
    subject { Client.new api_id: api_id, version: api_version }
    describe '#initialize' do
      let(:api_id) { '123' }
      let(:api_version) { '42' }

      it 'accepts a version' do
        expect( subject.instance_variable_get(:@base_json)[:v] ).to eq(api_version)
      end

      it 'accepts an api_id' do
        expect( subject.instance_variable_get(:@base_json)[:api_id] ).to eq(api_id)
      end
    end

    context 'real network requests' do
      let(:api_id) { '1vd9o4427lyi0ccb2uem' }
      let(:api_version) { '1' }

      describe '#drugs' do
        let(:query) { 'benz' }

        it 'retrieves drugs matching the query' do
          expect(subject.drugs(q: query)['drugs']).not_to be_nil
        end
      end

      describe '#requests' do
        let(:id) { 'PF6FK9' }
        let(:token_id) { 'gq9vmqai2mkwewv1y55x' }

        it 'retrieves a PA request' do
          options = { id: id, token_id: token_id }
          expect(subject.requests(options)['request']['workflow_status']).to eq('New')
        end
      end

      describe '#request_pages' do
        let(:id) { 'PF6FK9' }
        let(:token_id) { 'gq9vmqai2mkwewv1y55x' }

        it 'retrieves PA request forms' do
          options = { id: id, token_id: token_id }
          expect(subject.request_pages(options)['request_page']['forms']).not_to be_nil
        end
      end
    end

  end
end
