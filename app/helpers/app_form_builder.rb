module AppFormBuilder
  class AppFormBuilder < ActionView::Helpers::FormBuilder
    def submit(value = nil, options = {})
      if value.is_a?(Hash)
        options = value
        value = nil
      end

      super(value, { class: @template.primary_button_class }.merge(options))
    end

    def text_field(method, options = {})
      classes = if errors_for(method).present?
                  'bg-red-50 border border-red-500 text-red-900 placeholder-red-700 text-sm rounded-lg focus:ring-red-500 focus:border-red-500 block w-full p-2.5'
                else
                  'bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5'
                end

      super(method, { class: classes }.merge(options))
    end

    def label(method, text = nil, options = {}, &block)
      classes = if errors_for(method).present?
                  'block text-sm font-medium text-red-700'
                else
                  'block text-sm font-medium text-gray-900'
                end

      super(method, text, { class: classes }.merge(options), &block)
    end

    def input_group(&block)
      @template.content_tag('div', class: 'grid gap-1', &block)
    end

    def error_texts(method)
      errors_for(method).map do |text|
        @template.simple_format(text, class: 'text-sm text-red-600')
      end.reduce(&:+)
    end

    private

    def errors_for(method)
      return unless @object.present? && method.present?

      @object.errors[method]
    end
  end

  def app_form_for(name, *args, &block)
    options = args.extract_options!
    args << options.merge(builder: AppFormBuilder)
    form_for(name, *args, &block)
  end

  def app_form_with(model: nil, scope: nil, url: nil, format: nil, **options, &block)
    options = options.reverse_merge(builder: AppFormBuilder)
    form_with(model:, scope:, url:, format:, **options, &block)
  end
end
