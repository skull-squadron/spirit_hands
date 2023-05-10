require 'spirit_hands/prompt/base'

module SpiritHands
  module Prompt
    class << self
      private

      # Normal, main pry prompt
      def main
        ->(object, level, pry) do
          s = State.new(object, level, pry, ::SpiritHands.app, false)
          color = ::SpiritHands.color && ::SpiritHands.colored_prompt
          render(s, ::SpiritHands.prompt, color)
        end
      end
    end
  end
end
