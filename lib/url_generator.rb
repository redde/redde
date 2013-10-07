# coding: utf-8
class UrlGenerator

  def initialize id, name = nil
    @id = id
    @name = name
  end

  def url
    "#{@id}#{formatted_name}".downcase
  end

  def translitted_name
    Russian.translit(@name).gsub(' ','-').gsub(/[^\x00-\x7F]+/, '').gsub(/[^\w_ \-]+/i, '').gsub(/[ \-]+/i, '-').gsub(/^\-|\-$/i, '')
  end

  def formatted_name
    @name.nil? ? '' : '-' + translitted_name
  end
end