require 'httparty'
require 'pry'

module CmmApi
  class Client
    include HTTParty
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

    def request_pages(id: nil)
      get "/request-pages/#{id}", query
    end

    private

    def query(options = {})
      { query: @base_json.merge(options) }
    end

    def get(*args)
      response = self.class.get *args
      response.is_a?(String) ? JSON.parse(response) : response
    end

  end
end
