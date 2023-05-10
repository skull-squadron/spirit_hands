module SpiritHands
  class << self
    # Is coolline enabled?
    def coolline
      @coolline = DEFAULT_COOLLINE if !instance_variable_defined?(:@coolline) || @coolline.nil?
      @coolline
    end

    # Set whether hirb is enabled (default: true)
    attr_writer :coolline

  protected

    def install_coolline!
      return if coolline_installed?
      Pry.plugins['coolline'].activate!
      self.input_config = @coolline_input
    end

    def uninstall_coolline!
      return unless coolline_installed?
      Pry.plugins['coolline'].disable!
      self.input_config = @orig_input
    end

    def coolline_installed?
      Pry.input == @coolline_input[0]
    end

    def setup_coolline!
      if coolline
        install_coolline!
      else
        uninstall_coolline!
      end
    end

    def input_config=(args)
      Pry.input, Pry.config.completer = args
    end

    def input_config
      [Pry.input, Pry.config.completer]
    end

    def setup_coolline
      @orig_input = input_config
      require 'pry-coolline'
      @coolline_input = input_config
      Pry.hooks.add_hook(:before_session, "setup_coolline_before") do |output, binding, pry|
        setup_coolline!
      end
      Pry.hooks.add_hook(:after_eval, "setup_coolline_after") do |code, pry|
        setup_coolline!
      end
    end
  end

  DEFAULT_COOLLINE = false # TODO: fix pry-coolline and/or integration
end
