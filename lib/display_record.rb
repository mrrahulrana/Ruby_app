class DisplayRecord
    NO_INPUT_ERROR = 'Please provide valid input.'.freeze
    attr_reader :page_visits , :information

    def initialize(page_visits, information)
      @page_visits = page_visits
      @information = information
    end
  
    def call
      print input_invalid? ? NO_INPUT_ERROR : generate_output
    end
  
    private
  
    def generate_output
      output = ''
      puts '-----------visits-----------' if @information == 'visits'
      puts '-----------unique views-----------' if @information == 'unique views'
      @page_visits&.each do |page, visits|
        output << "#{page} - #{visits} #{@information}\n"
      end
  
      output
    end
  
    def input_invalid?
      @page_visits.nil? || @information.strip.empty?
    end
end