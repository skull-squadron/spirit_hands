require 'spirit_hands/prompt/base/render'

module SpiritHands
  module Prompt

    class << self
      private


      def render(state, prompt, color = true)
        r = Render.new(state, prompt, color)
        res = r.to_s
        STDERR.puts "\n" + (r.errors * "\n") + "\n" if r.errors?
        res
      end
    end # self

    # :object     Object
    # :level      Fixnum
    # :pry        Pry
    # :app        String or Rails::Application
    # :multiline  false: normal prompt,  true: multiline prompt
    State = Struct.new(:object, :level, :pry, :app, :multiline)
  end # Prompt
end # SpiritHands
