class DataReader
    attr_reader :page_visits , :unique
    def initialize(page_visits, unique: false)
        @page_visits = page_visits
        @unique = unique
    end
    
    def call
        return nil if @page_visits.empty?
    
        get_views(@unique).sort_by { |_, v| v }.reverse.to_h
    end
    
    private
    
    def get_views(unique)
        @page_visits.each_with_object({}) do |(key, value), list|
          list[key] = unique ? value.uniq.size : value.size
        end
    end
end