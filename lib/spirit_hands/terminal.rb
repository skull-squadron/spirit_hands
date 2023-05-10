module SpiritHands
  module Terminal
    class << self
      LOCALE_ENV_VARS = %w[LANG LC_ALL LC_TYPE LC_CTYPE].freeze.tap { |x| x.each(&:freeze) }
      ENV_UNICODE_REGEX = /.*utf.*8/i.freeze
      NON_UNICODE_TERMINALS = %w[linux xterm xterm-color GLterm].freeze

      def unicode?
        return false if defined? RbReadline
        return false if NON_UNICODE_TERMINALS.include? ENV['TERM']
        return true if ::Gem.win_platform?
        LOCALE_ENV_VARS.any? { |v| ENV[v] =~ ENV_UNICODE_REGEX }
      end
    end
  end
end
