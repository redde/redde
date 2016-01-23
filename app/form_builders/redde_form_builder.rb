class ReddeFormBuilder < ActionView::Helpers::FormBuilder
  delegate :render, :content_tag, :tag, :link_to, :concat, :capture, to: :@template

  def redde_field(name, *args)
    label(name)
    case object.class.columns.detect { |column| column.name == name.to_s }.type
    when :text then redde_text_area(name, *args)
    when :boolean then redde_check_box(name, *args)
    when :time then redde_date_time(name, *args)
    else
      redde_text_field(name, *args)
    end
  end

  # TODO: разобоаться с options
  def redde_select(name, *args)
    # options = args.extract_options!
    content_tag :tr, class: options[:wrapper_class] do
      content_tag(:td, smart_label(name), class: 'redde-form__cell _lbl') + content_tag(:td, select(name, *args))
    end
  end

  def redde_date_time(name, *args)
    options = args.extract_options!
    content_tag :tr, class: options[:wrapper_class] do
      content_tag(:td, smart_label(name), class: 'redde-form__cell _lbl') + content_tag(:td, datetime_select(name, options))
    end
  end

  def redde_check_box(name, *args)
    options = args.extract_options!
    content_tag :tr, class: options[:wrapper_class] do
      concat tag :td
      concat content_tag :td, check_box(name, options) + " " + smart_label(name),  class: 'redde-form__cell'
    end
  end

  def redde_text_field(name, *args)
    options = args.extract_options!
    options[:class] = 'inp redde-form__inp'
    # content_tag :tr, class: options[:wrapper_class] do
    #   content_tag(:td, smart_label(name), class: 'redde-form__cell _lbl') + content_tag(:td, text_field(name, options))
    # end
    wrap(name, text_field(name, options), options)
  end

  def redde_text_area(name, *args)
    options = args.extract_options!
    content_tag :tr, class: options[:wrapper_class] do
      content_tag :td, colspan: 2 do
        smart_label(name) + tag(:br) + text_area(name, options)
      end
    end
  end

  def redde_submit(text, opts)
    css_class = ['sbm']
    css_class << opts[:class] if opts[:class].present?
    css_class << '_save' if text == 'Сохранить'
    button(text, class: css_class, value: text, name: :commit)
  end

  def redde_submits *args, &block
    content_tag :div, class: 'redde-form__actions' do
      concat redde_submit('Сохранить', class: 'redde-form__sbm')
      concat redde_submit('Применить', class: 'redde-form__sbm')
      concat capture(&block) if block_given?
    end
  end

  def error_messages(attrs = {})
    if object.errors.full_messages.any?
      render 'admin/redde/validate', { f: self, attrs: attrs }
    end
  end

  def wrap(name = nil, *args, &block)
    options = args.extract_options!
    content = block_given? ? capture(&block) : args[0]
    content_tag( :tr, content_tag( :td, smart_label(name), class: ['redde-form__cell', '_label', options[:cell]].flatten.compact ) + content_tag( :td, content, class: ['redde-form__cell', options[:cell]] ), class: ['redde-form__row', ('_error' if object.errors[name].any?), options[:wrap]].flatten.compact )
  end

  def fieldset(name, *args, &block)
    options = args.extract_options!
    content_tag(:tbody, class: options[:class]) do
      concat content_tag(:tr, content_tag(:th, name, colspan: 2, class: 'redde-form__thead'))
      concat capture(&block)
    end
  end

  private

  def smart_label(name)
    required = object.class.validators_on(name).any? { |v| v.is_a? ActiveModel::Validations::PresenceValidator }
    label(name, nil, class: ["redde-form__label",  ("_required" if required)])
  end

  def objectify_options(options)
    super.except(:wrap, :cell)
  end
end
