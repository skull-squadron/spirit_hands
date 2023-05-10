require 'shellwords'

module SpiritHands
  DEFAULT_LESS_SHOW_RAW_UNICODE = true
  LESS_SHOW_RAW_BINFMT = '*n%c'.freeze

  class << self
    # Allow less to display colorized output (default: true)
    # (If, set updates LESS env var)
    def less_show_raw_unicode
      ENV['LESSUTFBINFMT'] == LESS_SHOW_RAW_BINFMT
    end

    # true: set LESSUTFBINFMT to %*c
    # false: unset LESSUTFBINFMT
    # String: set custom LESSUTFBINFMT
    # nil: set default(true)
    def less_show_raw_unicode=(n)
      n = DEFAULT_LESS_SHOW_RAW_UNICODE if n.nil?
      ENV['LESSUTFBINFMT'] = if n.is_a?(String)
        n
      elsif n
        LESS_SHOW_RAW_BINFMT
      else
        nil
      end
      @less_show_raw_unicode = !!n
    end

    private

    def setup_less_show_raw_unicode
      self.less_show_raw_unicode = nil unless @less_show_raw_unicode
    end
  end
end
