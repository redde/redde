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
    return content_for(:js,html)
  end

  def show_tree(c)
    html = ""
    html << "<li id=\"list_#{c.id}\"><div>#{link_to c.name, edit_admin_category_path(c)}<p>"
    html << " #{link_to "Удал",[:admin, c], data: { confirm: 'Точно удалить?' }, :method => :delete, class: "del"}</p></div>"
    unless c.children.empty?
      html << "<ol#{" class='sortable'" if c.id == 1}>"
      c.children.order('position').each do |ch|
        html << show_tree(ch)
      end
      html << "</ol>"
    end
    html << "</li>"
    return raw(html)
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
            tabSize: 25,
            tolerance: 'pointer',
            toleranceElement: '> div',
            update: function(){
              var serialized = $(this).nestedSortable('serialize');
              $.ajax({url: '#{url}', data: serialized});
            }
          });
        });
      </script>
    }.gsub(/[\n ]+/, ' ').strip.html_safe
  end

  def tsingular model
    model.model_name.human
  end

  def tgenetive model_name
    t("activerecord.models.#{model_name}.gen")
  end

  def tplural model
    model.model_name.human(:count => 'other')
  end

end
