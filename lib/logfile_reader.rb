class FileReader
    ARG_TYPE_ERROR = "Please provide a '.log' file."
    VALID_EXT = '.log'
    attr_reader :websites, :logfile

    def initialize(logfile)
        raise ArgumentError, 'A log file does not exist' unless File.exist?(logfile)
        @logfile=logfile
        @websites = Hash.new { |h, k| h[k] = [] }
    end

    def call
        read_file if file_valid?
    end

    private

    def read_file
        return @websites if @websites.any?
    
        File.open(@logfile).each do |line|
          page, ip = *line.split(/\s+/)
          @websites[page] << ip
        end
    
        @websites
    end
       
    def file_valid?
        format_valid?
    end
    
    def format_valid?
        is_valid = File.extname(@logfile) == VALID_EXT
        is_valid || raise(ArgumentError, ARG_TYPE_ERROR)
    end
    
end