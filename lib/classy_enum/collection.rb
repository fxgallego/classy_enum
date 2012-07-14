module ClassyEnum
  module Collection
    def inherited(klass)
      if self == ClassyEnum::Base
        klass.class_attribute :enum_options
        klass.enum_options = []
      else
        enum_options << klass
        klass.instance_variable_set('@index', enum_options.size)
      end

      super
    end

    # Returns an array of all instantiated enums
    #
    # ==== Example
    #  # Create an Enum with some elements
    #  class Priority < ClassyEnum::Base
    #  end
    #
    # class PriorityLow < Priority; end
    # class PriorityMedium < Priority; end
    # class PriorityHigh < Priority; end
    #
    #  Priority.all # => [PriorityLow.new, PriorityMedium.new, PriorityHigh.new]
    def all
      enum_options.map(&:new)
    end

    # Returns a 2D array for Rails select helper options.
    # Also used internally for Formtastic support
    #
    # ==== Example
    #  # Create an Enum with some elements
    #  class Priority < ClassyEnum::Base
    #  end
    #
    # class PriorityLow < Priority; end
    # class PriorityReallyHigh < Priority; end
    #
    #  Priority.select_options # => [["Low", "low"], ["Really High", "really_high"]]
    def select_options
      all.map {|e| [e.to_s.titleize, e.to_s] }
    end

  end
end
