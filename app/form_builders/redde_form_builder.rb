class ReddeFormBuilder < ActionView::Helpers::FormBuilder
  delegate :raw, :render, :content_tag, :tag, :link_to, :image_tag, :concat, :capture, to: :@template
  # delegate :debug, :render, :content_tag, :tag, :link_to, :concat, :capture, to: :@template

  def redde_field(name, *args)
    label(name)
    case object.class.columns.detect { |column| column.name == name.to_s }.try(:type)
    when :text then redde_text_area(name, *args)
    when :boolean then redde_check_box(name, *args)
    when :time then redde_date_time(name, *args)
    when :datetime then redde_date_time(name, *args)
    else
      if object.send(name).class.superclass.name == 'CarrierWave::Uploader::Base'
        redde_image_field(name, *args)
      else
        redde_text_field(name, *args)
      end
    end
  end

  def redde_select(name, choices, opts = {}, *args)
    options = args.extract_options!
    options[:class] = assign_class(['sel', 'redde-form__sel'], options[:class])
    wrap(name, select(name, choices, opts, options.except(:wrap, :cell)), options)
  end

  def redde_date_time(name, *args)
    options = args.extract_options!
    wrap(name, datetime_select(name, options), options)
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
    options[:class] = assign_class(['inp', 'redde-form__inp'], options[:class])
    wrap(name, text_field(name, options), options)
  end

  def redde_image_field(name, *args)
    html = redde_file_field(name, *args)
    if object.send(name).present?
      html = empty_wrap(image_tag(object.send(name), class: 'redde-form__img-preview') + check_box("remove_#{name}") + label("remove_#{name}")).concat(html)
    end
    html
  end

  def redde_file_field(name, *args)
    options = args.extract_options!
    wrap(name, options) do
      content_tag(:span, class: ['redde-form__file rfile jsr-file', options[:class]]) do
        concat content_tag :span, raw('Загрузить') + content_tag(:span, file_field(name, options.merge(class: 'rfile__inp')), class: 'rfile__wrap jsr-file--wrap'), class: 'rfile__btn btn icon-upload'
        concat content_tag(:span, '', class: 'rfile__name jsr-file--name')
        concat content_tag(:span, 'удал.', class: 'rfile__del jsr-file--del', hidden: "")
      end
    end
  end

  def redde_text_area(name, *args)
    options = args.extract_options!
    options[:class] = assign_class(['txtr', 'redde-form__txtr'], options[:class])
    wrap(name, text_area(name, options), options)
  end

  def redde_submit(text, opts)
    css_class = ['sbm']
    css_class << opts[:class] if opts[:class].present?
    css_class << '_save' if text == 'Сохранить'
    button(text, class: css_class, value: text, name: :commit)
  end

  def redde_submits *args, &block
    content_tag :tfoot do
      content_tag :tr do
        content_tag :td, colspan: 2, class: 'redde-form__actions' do
          concat redde_submit('Сохранить', class: 'redde-form__sbm')
          concat redde_submit('Применить', class: 'redde-form__sbm')
          concat capture(&block) if block_given?
        end
      end
    end
  end

  def error_messages(attrs = {})
    if object.errors.full_messages.any?
      render 'admin/redde/validate', { f: self, attrs: attrs }
    end
  end

  def empty_wrap(*args, &block)
    options = args.extract_options!
    content = block_given? ? capture(&block) : args[0]
    content_tag( :tr, tag( :td, class: ['redde-form__cell', options[:cell]].flatten.compact ) + content_tag( :td, content, class: ['redde-form__cell', options[:cell]] ), class: ['redde-form__row', options[:wrap]].flatten.compact )
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

  def assign_class(base, added)
    base = [base] if base.is_a? String
    if added.present?
      base << added if added.is_a? String
      base += added if added.is_a? Array
    end
    base
  end

  def smart_label(name)
    required = object.class.validators_on(name).any? { |v| v.is_a? ActiveModel::Validations::PresenceValidator }
    label(name, nil, class: ["redde-form__label",  ("_required" if required)])
  end

  def objectify_options(options)
    super.except(:wrap, :cell)
  end
end
