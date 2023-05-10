# Adds Hirb.enabled?
require 'hirb'
require 'pry'

class << Hirb
  @enabled = false
  def enabled?
    !!@enabled
  end

  protected

  def set_enabled
    @enabled = true
  end

  def set_disabled
    @enabled = false
  end
end # Hirb.self

class << Hirb::View
  alias_method :enable_output_method_existing, :enable_output_method
  alias_method :disable_output_method_existing, :disable_output_method

  def enable_output_method
    @output_method = true
    ::Hirb.send :set_enabled
    enable_output_method_existing
  end

  def disable_output_method
    ::Hirb.send :set_disabled
    disable_output_method_existing
  end
end # Hirb::View.self
