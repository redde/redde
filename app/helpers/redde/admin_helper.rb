# coding: utf-8
module Redde::AdminHelper
  def sidebar_link(title, path, additional_names = [])
    additional_names = [additional_names] unless additional_names.is_a?(Array)
    active_names = additional_names + [path.last]
    active_names.map!(&:to_s)
    classes = ['sidebar__link']
    classes << '_active' if active_names.include?(controller_name)
    link_to title, path, class: classes
  end

  def photoable parent
    render('admin/photos/photos', parent: parent)
  end

  def redde_form_for(object, options = {}, &block)
    if options.key?(:html)
      if options[:html].key?(:class)
        if options[:html][:class].is_a? String
          options[:html][:class] += ' redde-form'
        elsif options[:html][:class].is_a? Array
          options[:html][:class] << 'redde-form'
        end
      else
        options[:html][:class] = 'redde-form'
      end
    else
      options[:html] = { class: 'redde-form' }
    end
    options[:builder] = ReddeFormBuilder
    form_for(object, options, &block)
  end

  def show_tree(c)
    link = link_to c.name, [:edit, :admin, c]
    edit = link_to 'Удал', [:admin, c], data: { confirm: 'Точно удалить?' },
                                        method: :delete, class: 'del'
    html = content_tag(:div, link + content_tag(:p, edit))
    if c.children.any?
      html << content_tag(:ol) do
        raw c.children.map { |ch| show_tree(ch) }.join('')
      end
    end
    content_tag :li, raw(html), id: "list_#{c.id}"
  end

  def sort_tree(url, maxLevels = 2)
    %Q{
      <script type="text/javascript">
        $(document).ready(function(){

          $('ol.sortable').nestedSortable({
            disableNesting: 'no-nest',
            forcePlaceholderSize: true,
            handle: 'div',
            helper: 'clone',
            items: 'li',
            maxLevels: #{maxLevels},
            opacity: .6,
            placeholder: 'placeholder',
            revert: 250,
            rootID: 'root',
            tabSize: 25,
            tolerance: 'pointer',
            toleranceElement: '> div',
            update: function(){
              var serialized = $(this).nestedSortable('serialize');
              $.ajax({
                method: 'POST',
                url: '#{url}',
                data: serialized
              });
            }
          });
        });
      </script>
    }.gsub(/[\n ]+/, ' ').strip.html_safe
  end

  def tsingular(model)
    model.model_name.human
  end

  def taccusative(model_name)
    t("activerecord.models.#{model_name}.acc")
  end

  def tplural(model)
    model.model_name.human(count: 'other')
  end
end
