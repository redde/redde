class Redde::UrlGenerator
  attr_reader :id, :name
  def initialize(id, name = nil)
    @id = id
    @name = name
  end

  def url
    return "#{id}-#{formatted_name}".downcase if formatted_name.present?
    id.to_s
  end

  def translitted_name
    Russian.translit(name).gsub(' ', '-')
      .gsub(/[^\x00-\x7F]+/, '').gsub(/[^\w_ \-]+/i, '')
      .gsub(/[ \-]+/i, '-').gsub(/^\-|\-$/i, '')
  end

  def formatted_name
    name.nil? ? '' : translitted_name
  end
end
