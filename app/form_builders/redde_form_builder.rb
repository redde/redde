class ReddeFormBuilder < ActionView::Helpers::FormBuilder
  delegate :render, :content_tag, :tag, :link_to, to: :@template

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
      content_tag(:th, smart_label(name)) + content_tag(:td, select(name, *args))
    end
  end

  def redde_date_time(name, *args)
    options = args.extract_options!
    content_tag :tr, class: options[:wrapper_class] do
      content_tag(:th, smart_label(name)) + content_tag(:td, datetime_select(name, options))
    end
  end

  def redde_check_box(name, *args)
    options = args.extract_options!
    content_tag :tr, class: options[:wrapper_class] do
      content_tag :th, colspan: 2 do
         check_box(name, options) + " " + smart_label(name)
      end
    end
  end

  def redde_text_field(name, *args)
    options = args.extract_options!
    content_tag :tr, class: options[:wrapper_class] do
      content_tag(:th, smart_label(name)) + content_tag(:td, text_field(name, options))
    end
  end

  def redde_text_area(name, *args)
    options = args.extract_options!
    content_tag :tr, class: options[:wrapper_class] do
      content_tag :td, colspan: 2 do
        smart_label(name) + tag(:br) + text_area(name, options)
      end
    end
  end

  def redde_submit(text)
    additional_class = case text
    when 'Сохранить' then ' _save'
    when 'Применить' then ' _apply'
    else '' end
    button(text, class: ['sbm', additional_class], value: text, name: :commit)
  end

  def redde_submits
    content_tag :div, redde_submit('Сохранить') + " " + redde_submit('Применить'), class: 'actions'
  end

  def error_messages(attrs = {})
    if object.errors.full_messages.any?
      render 'validate', { f: self, attrs: attrs }
    end
  end

  private

  def smart_label(name)
    required = object.class.validators_on(name).any? { |v| v.is_a? ActiveModel::Validations::PresenceValidator }
    label(name, nil, class: ["redde-form__label",  ("_required" if required)])
  end

  def objectify_options(options)
    super.except(:wrapper_class)
  end
end
