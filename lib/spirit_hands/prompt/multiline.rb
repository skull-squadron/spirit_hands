require 'spirit_hands/prompt/base'

module SpiritHands
  module Prompt
    class << self
      private

      # Wait pry prompt in multiline input
      def multiline
        ->(object, level, pry) {
          s = State.new(object, level, pry, ::SpiritHands.app, true)
          render(s, ::SpiritHands.prompt, ::SpiritHands.color && ::SpiritHands.colored_prompt)
        }
      end
    end
  end
end
