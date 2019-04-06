require_relative 'helper'

require 'minitest/autorun'

# SUPPORT

class MethodRecorder
  def method_missing(method_name, *)
    methods << method_name
  end

  def methods
    @methods ||= []
  end
end
