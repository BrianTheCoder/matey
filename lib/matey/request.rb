require "active_model"
require "tilt"

module Matey
  class Request
    include ActiveModel::Validations

    DEFAULTS = {}

    attr_accessor :client

    def render(options = {})
      options.reverse_merge!(DEFAULTS)
      template = Tilt.new("views#{self.class.name.gsub('Matey','').underscore}.slim")
      template.render(self, options: options)
    end

    protected

    def partial(name, options = {})
      carrier = self.class.to_s.split('::')[1]
      template = Tilt.new("views/#{carrier.underscore}/partials/_#{name}.slim")
      template.render(self, options)
    end
  end
end