class Railtie < Rails::Railtie
  config.before_initialize do |app|
    @@app = app
  end

  config.after_initialize do
    silence_warnings do
      ::SpiritHands.melody!(@@app)
    end
  end
end # Railtie
