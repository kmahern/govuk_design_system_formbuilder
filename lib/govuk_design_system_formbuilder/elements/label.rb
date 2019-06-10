module GOVUKDesignSystemFormBuilder
  module Elements
    class Label < GOVUKDesignSystemFormBuilder::Base
      DEFAULTS = { weight: 'regular', size: 'regular' }.freeze

      def initialize(builder, object_name, attribute_name, **options)
        super(builder, object_name, attribute_name)

        DEFAULTS.merge(options).tap do |o|
          @text   = label_text(o&.dig(:text))
          @value  = o&.dig(:value) # used by attribute_descriptor
          @size   = label_size(o&.dig(:size))
          @weight = label_weight(o&.dig(:weight))
        end
      end

      def html
        return nil unless @text.present?

        @builder.tag.label(
          @text,
          class: %w(govuk-label).push(@size, @weight).compact,
          for: attribute_descriptor
        )
      end

    private

      def label_text(option_text)
        [option_text, @value, @attribute_name.capitalize].compact.first
      end

      def label_size(size)
        case size
        when 'large'   then "govuk-!-font-size-48"
        when 'medium'  then "govuk-!-font-size-36"
        when 'small'   then "govuk-!-font-size-27"
        when 'regular' then nil
        else
          fail 'size must be either large, medium, small or regular'
        end
      end

      def label_weight(weight)
        case weight
        when 'bold'    then "govuk-!-font-weight-bold"
        when 'regular' then nil
        else
          fail 'weight must be bold or regular'
        end
      end
    end
  end
end
