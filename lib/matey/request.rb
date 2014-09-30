require "tilt"

module Matey
  class Request
    include Virtus.model
    include ActiveModel::Validations

    attribute :client, Matey::Client

    def render(options = {})
      template = Tilt.new("#{self.class.root}/#{self.class.name.gsub('Matey','').underscore}.slim")
      template.render(self, options: options)
    end

    protected

    def self.root
      "#{File.dirname(__FILE__)}/views"
    end

    def partial(name, options = {})
      carrier = self.class.to_s.split('::')[1]
      template = Tilt.new("#{self.class.root}/#{carrier.underscore}/partials/_#{name}.slim")
      template.render(self, options)
    end
  end
end