# :nocov:
module AbstractApi
  class Client

    class AbstractApiError < StandardError; end

    attr_accessor :host, :connection, :api_key, :email

    def initialize(host: ENV.fetch('ABSTRACT_API_URL', 'https://emailvalidation.abstractapi.com/v1/'),
                   api_key: ENV.fetch('ABSTRACT_API_KEY', '1234'), email: '')
      self.host = host
      self.connection = Faraday.new self.host, ssl: { verify: false } do |f|
        f.request :json # encode req bodies as JSON
        f.response :json
        f.adapter :net_http
      end
      self.api_key = api_key
      self.email = email
    end

    def quality_score
      return 0.0 unless self.email.present?

      status, _, body = api_response(quality_score_endpoint)

      raise AbstractApiError.new if status != 200

      body.fetch('quality_score').to_f
    end

    private

    def api_response(url)
      response = self.connection.get(url)
      [response.status, response.headers, response.body]
    end

    def quality_score_endpoint
      "#{self.host}?#{query_params}"
    end

    def query_params
      "api_key=#{self.api_key}&email=#{self.email}"
    end

  end
end
# :nocov: