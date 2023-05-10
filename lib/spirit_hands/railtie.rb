class Railtie < Rails::Railtie
  initializer 'spirit_hands.initialize' do |app|
    @@app = app
  end

  config.after_initialize do
    silence_warnings do
      ::SpiritHands.melody!(@@app)
    end
  end
end # Railtie
