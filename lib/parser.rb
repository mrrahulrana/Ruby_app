require_relative './logfile_reader'
require_relative './data_reader'
require_relative './display_record'

if ARGV.any?

    begin
        pages_data = FileReader.new(ARGV.first).call
      
    rescue ArgumentError => e
          puts e
  
          return
    end
  
      page_visits = DataReader.new(pages_data, unique: false).call
  
      if page_visits.nil?
          puts 'No data found!'
  
          return
      end
  
      uniq_page_visits = DataReader.new(pages_data, unique: true).call
  
      DisplayRecord.new(page_visits, 'visits').call
       
      DisplayRecord.new(uniq_page_visits, 'unique views').call
else
      puts 'Please provide a valid log file.'
end