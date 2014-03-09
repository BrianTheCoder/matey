module Matey
  class Response
    attr_accessor :response

    def initalize(response)
      @response = response
    end

    def doc
      @_doc ||= Nokogiri::XML(response.body)
    end
  end
end