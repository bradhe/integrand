class ActionView::Helpers::FormBuilder
  include ActionView::Helpers::TagHelper

  def errors(method, options={})
    return unless @object.errors.has_key? method.to_sym
    # Create a span called errors otherwise
    return content_tag 'span', @object.errors[method.to_sym].join(','), options
  end
end
