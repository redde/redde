module Redde::TreeSortable
  def sort(list)
    Sorter.new(list, self).sort
  end

  class Sorter
    attr_accessor :list, :klass
    def initialize(list, klass)
      @list = list
      @klass = klass
    end

    def sort
      tree.each do |parent, cats|
        i = 1
        if parent == 'root'
          pid = nil
        else
          pid = klass.find(parent).id
        end
        cats.each do |cat|
          klass.find(cat).update(parent_id: pid, position: i)
          i += 1
        end
      end
    end

    def tree
      temp = {}
      list.each do |key, value|
        if temp[value]
          temp[value] << key
        else
          temp[value] = [key]
        end
      end
      temp
    end
  end
end
