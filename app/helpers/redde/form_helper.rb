module Redde::FormHelper
  # Override the default ActiveRecordHelper behaviour of wrapping the input.
  # This gets taken care of semantically by adding an error class to the wrapper tag
  # containing the input.
  #
  FIELD_ERROR_PROC = proc do |html_tag, instance_tag|
    html_tag
  end

  def redde_form_for(object, options = {}, &block)
    options = make_options(options)
    options[:builder] ||= ReddeFormBuilder
    options[:html] = { 'data-redde' => { objectName: (object.kind_of?(Array) ? object.last : object).class.model_name.param_key }.to_json }

    options[:redde] = {} unless options.key?(:redde)
    options[:redde][:submits] = true unless options[:redde].key?(:submits)

    with_clean_form_field_error_proc do
      form_for(object, options) do |f|
        concat f.error_messages
        concat content_tag(:table, capture(f, &block).concat(if options[:redde][:submits] then f.redde_submits end), class: 'redde-form__tbl')
      end
    end
  end

  def redde_fields_for(record_name, record_object = nil, options = {}, &block)
    options, record_object = record_object, nil if record_object.is_a?(Hash) && record_object.extractable_options?
    options[:builder] ||= ReddeFormBuilder

    with_clean_form_field_error_proc do
      fields_for(record_name, record_object, options, &block)
    end
  end

  private

  def make_options(options)
    return options.merge(html: { class: 'redde-form' }) unless options.key?(:html)
    unless options[:html].key?(:class)
      options[:html][:class] = 'redde-form'
      return options
    end
    if options[:html][:class].is_a? String
      options[:html][:class] += ' redde-form'
    elsif options[:html][:class].is_a? Array
      options[:html][:class] << 'redde-form'
    end
    options
  end

  def with_clean_form_field_error_proc
    default_field_error_proc = ::ActionView::Base.field_error_proc
    begin
      ::ActionView::Base.field_error_proc = FIELD_ERROR_PROC
      yield
    ensure
      ::ActionView::Base.field_error_proc = default_field_error_proc
    end
  end
end
