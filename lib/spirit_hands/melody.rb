require 'pry'

class << SpiritHands
  # This modifies pry to play our tune
  def melody!(app = nil)
    return false if @installed
    @installed = true

    Pry.config.should_load_plugins = false
    SpiritHands.app = app unless app.nil?
    setup_less_colorize
    setup_less_show_raw_unicode
    setup_hirb
    setup_coolline # setup Pry.config.input
    optional_require 'pry-nav'
    optional_require 'pry-byebug'
    require 'pry-doc'

    # Use awesome_print for output, but keep pry's pager. If Hirb is
    # enabled, try printing with it first.
    ::SpiritHands::Print.install!

    # Friendlier prompt - line number, app name, nesting levels look like
    # directory paths.
    #
    # Configuration (like Pry.color) can be changed later or even during console usage.
    ::SpiritHands::Prompt.install!
  end

private
  def optional_require(arg)
    require arg
  rescue LoadError
  end
end # SpiritHands.self
