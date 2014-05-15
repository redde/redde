# coding: utf-8
module AdminHelper
  def act_menu(cond)
    cond ? 'active' : nil
  end

  def sortable(url)
    html = %Q{
      <script type="text/javascript">
        $(document).ready(function() {
          $("table.sortable").each(function(){
            var self = $(this);
            self.sortable({
              dropOnEmpty: false,
              cursor: 'crosshair',
              opacity: 0.75,
              handle: '.handle',
              axis: 'y',
              items: 'tr',
              scroll: true,
              update: function() {
                $.ajax({
                  type: 'post',
                  data: self.sortable('serialize') + '&authenticity_token=#{u(form_authenticity_token)}',
                  dataType: 'script',
                  url: '#{url}'
                })
              }
            });
          });
        });
      </script>
    }.gsub(/[\n ]+/, ' ').strip.html_safe
    content_for(:js, html)
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
