require 'spirit_hands/prompt/main'
require 'spirit_hands/prompt/multiline'

module SpiritHands
  module Prompt
    module_function

    def install!
      Pry.config.prompt = Pry::Prompt.new :spirit_hands, 'Jazz for your pry', [ main, multiline ].freeze
    end
  end
end
