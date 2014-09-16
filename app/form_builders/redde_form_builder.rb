class ReddeFormBuilder < ActionView::Helpers::FormBuilder
  delegate :content_tag, :tag, :raw, :link_to, :t, :render, :params, to: :@template

  def error_messages
    render 'validate', { f: self }
  end

  def inline_check_box(name, *args)
    content_tag :tr do
      content_tag :th, colspan: 2 do
        check_box(name, *args) + ' ' + label(name) + '?'
      end
    end
  end

  def inline_text_field(name, *args)
    inline_field name, text_field(name, *args)
  end

  def inline_email_field(name, *args)
    inline_field name, email_field(name, *args)
  end

  def inline_text_area(name, *args)
    content_tag :tr do
      content_tag :td, smart_label(name) + text_area(name, *args), colspan: 2
    end
  end

  def select_or_create(name, valuesarray)
    inline_field name, hidden_field(name, class: 'select_or_create', data: {valuesarray: valuesarray, placeholder: 'выберите или введите новое значение'})
  end

  def redde_select(name, opts, *args)
    inline_field name, select(name, opts, *args)
  end

  def inline_submit
    content_tag :div, class: 'actions' do
      submit('Сохранить') + submit('Применить')
    end
  end

  private

  def inline_field(name, some_field)
    content_tag :tr do
      inline_label(name) + content_tag(:td, some_field)
    end
  end

  def inline_label(name)
    content_tag :th, smart_label(name)
  end

  def smart_label(name)
    label(name, nil, class: ['',  ('_required' if required_field?(name))])
  end

  def required_field?(name)
    object.class.validators_on(name).any? { |v| v.kind_of? ActiveModel::Validations::PresenceValidator }
  end
end