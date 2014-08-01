require 'httparty'
require 'pry'

module CmmApi
  class Client
    include HTTParty
    format :json
    headers 'Accept' => 'application/json'

    def initialize(api_id: nil, version: nil, target_uri: 'api.covermymeds.com')
      self.class.base_uri target_uri
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

    def send_request_pages(action={}, form_data={})
      if action['method'] == 'GET'
        # does this reference the form?  Send form_data?
        get action['href'], query
      else
        put action['href'], {
          query: { api_id: @base_json['api_id']},
          body: @base_json.merge(form_data)
        }
      end
    end

    private

    def query(options = {}, base_query = '')
      base_options = {}
      base_query.split(/\&/).each do |pair|
        k,v = pair.split(/=/)
        base_options[k] = v
      end
      { query: @base_json.merge(base_options).merge(options) }
    end

    def get(*args)
      puts "GET ARGS: #{args.inspect}"
      (self.class.get *args).tap do |response|
        guard_errors response
      end
    end

    def put(*args)
      puts "PUT ARGS: #{args.inspect}"
      (self.class.put *args).tap do |response|
        guard_errors response
      end
    end

    def guard_errors(response)
      if response['errors']
        error_msg = "Error Response from API:\n"
        response['errors'].each do |error|
          error_msg << "  #{error['message']} (code #{error['code']})\n"
          error_msg << "  #{error['debug']}\n"
        end
        raise error_msg
      end
    end

  end
end
