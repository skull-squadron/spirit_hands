require 'spirit_hands/prompt/main'
require 'spirit_hands/prompt/multiline'

module SpiritHands
  module Prompt
    class << self
      def install!
        ::Pry.config.prompt = [ main, multiline ].freeze
      end
    end # self
  end # Prompt
end # SpiritHands
