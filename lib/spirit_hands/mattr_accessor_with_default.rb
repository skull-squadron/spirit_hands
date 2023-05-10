class Module
  def mattr_accessor_with_default(property, default = nil, &block)
    if block_given?
      if default
        raise ArgumentError, 'Must specify only one of +default+ or &block'
      end
      default = block
    end

    getter = property.to_sym
    setter = "#{property}=".to_sym
    class_var = "@@#{property}".to_sym

    # self.property=
    define_singleton_method(setter) do |value|
      if value.nil?
        remove_class_variable(class_var)
      else
        class_variable_set(class_var, value)
      end
    end

    # self.property
    if default.respond_to?(:call) # default is callable
      define_singleton_method(getter) do
        if class_variable_defined?(class_var)
          class_variable_get(class_var)
        else
          default.()
        end
      end
    else # default is literal object
      default_value_name = "DEFAULT_#{property}".upcase.to_sym
      const_set(default_value_name, default)
      define_singleton_method(getter) do
        if class_variable_defined?(class_var)
          class_variable_get(class_var)
        else
          const_get(default_value_name)
        end
      end
    end
  end
end # Module
