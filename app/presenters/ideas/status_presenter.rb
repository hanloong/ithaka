module Ideas
  class StatusPresenter
    def initialize
      @status = Idea::STATUS
    end

    def collection
      @status.map do |s|
        [titalise(s), s]
      end
    end

    def find_by_index(index)
      titalise(@status[index])
    end

    def titalise(status)
      status.gsub(/_/, ' ').split.map(&:capitalize).join(' ')
    end

    def search_group
      @status.select { |s| s != 'archived' }
    end

    def group_status(groups)
      Hash[groups.map { |k, v| [find_by_index(k), v] }]
    end
  end
end
