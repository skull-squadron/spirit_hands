require 'shellwords'

module SpiritHands
  DEFAULT_LESS_COLORIZE = true
  LESS_R_LONG = '--RAW-CONTROL-CHARS'.freeze
  LESS_R = /\A(.*-[^-R]*)R(.*)\z/.freeze

  class << self

    # Allow less to display colorized output (default: true)
    # (If, set updates LESS env var)
    def less_colorize
      ENV['LESS'].to_s.shellsplit.any? { |arg| arg == LESS_R_LONG || arg =~ LESS_R }
    end

    #  true: add -R to LESS env var (default)
    # false: remove -R from LESS env var
    #   nil: set to default (true)
    def less_colorize=(n)
      n = DEFAULT_LESS_COLORIZE if n.nil?

      args = ENV['LESS'].to_s.shellsplit.map do |arg|
        next if arg == LESS_R_LONG
        if arg =~ LESS_R
          arg = $1 + $2
        end
        arg unless arg.empty?
      end
      args << '-R' if n
      new_less = args.collect.to_a.shelljoin
      ENV['LESS'] = new_less.empty? ? nil : new_less
      @less_colorize = !!n
    end

    private

    def setup_less_colorize
      self.less_colorize = nil unless @less_colorize
    end
  end
end
