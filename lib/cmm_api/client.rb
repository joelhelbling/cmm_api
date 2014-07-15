require 'httparty'
require 'pry'

module CmmApi
  class Client
    include HTTParty
    format :json
    headers 'Accept' => 'application/json'
    base_uri 'api.covermymeds.com'

    def initialize(api_id: nil, version: nil)
      @base_json = { api_id: api_id, v: version }
    end

    def drugs(q: nil)
      get '/drugs', query(q: q)
    end

    def requests(id: nil, token_id: nil)
      get "/requests/#{id}", query(token_id: token_id)
    end

    def request_pages(id: nil, token_id: nil)
      get "/request-pages/#{id}", query(token_id: token_id)
    end

    private

    def query(options = {})
      { query: @base_json.merge(options) }
    end

    def get(*args)
      (self.class.get *args).tap do |response|
        if response['errors']
          error_msg = "Error Response from API:\n"
          response['errors'].each do |error|
            error_msg << "  #{error['message']} (code #{error['code']})\n"
          end
          raise error_msg
        end
      end
    end

  end
end
