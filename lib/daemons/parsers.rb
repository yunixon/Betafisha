begin
  #!/usr/bin/env ruby
  require File.dirname(__FILE__) + "/../../config/application"
  Rails.application.require_environment!

  include CalculatingName
  include Spawn

  ENV["RAILS_ENV"] ||= "development"

  $running = true
  Signal.trap("TERM") do
    $running = false
  end

  timestamp_file = File.dirname(__FILE__) + '/../../log/parsers.timestamp'
  last_parsed_time = File.mtime timestamp_file
  FileUtils.touch timestamp_file

  log = File.dirname(__FILE__) + '/../../log/parsers.rb.log'
  if File.exist?(log)
    @log = open(log, (File::WRONLY | File::APPEND))
    @log.sync = true
  else
    @log = open(log, (File::WRONLY | File::APPEND | File::CREAT))
    @log.sync = true
  end

  Rails.logger.auto_flushing = true

  while $running do

    @log.write "========================================================================\n"
   
    @log.write "#Clearing Bets & Participants started\n"
      Bet.delete_all
      Participant.delete_all
    @log.write "Clearing DB finished\n"

    #array for pids
    threads = []

    threads[0] = spawn do
      begin
        @log.write "+Gamebookers parsing started #{Time.now}\n"
        GamebookersParser.parse!
        @log.write "-Gamebookers parsing finished #{Time.now}\n"
      rescue Exception => e
        @log.write "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!\n"
        @log.write "Gamebookers error:\n"
        @log.write e
        @log.write "\n"
        @log.write "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!\n"
      end
    end

    threads[1] = spawn do
      begin
        @log.write "+Betredkings parsing started #{Time.now}\n"
   #     BetredkingsParser.parse!
        @log.write "-Betredkings parsing finished #{Time.now}\n"
      rescue Exception => e
        @log.write "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!\n"
        @log.write "Betredkings error:\n"
        @log.write e
        @log.write "\n"
        @log.write "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!\n"
      end
    end

    threads[2] = spawn do
      begin
        @log.write "+Stan James parsing started #{Time.now}\n"
   #     StanjamesParser.parse!
        @log.write "-Stan James parsing finished #{Time.now}\n"
      rescue Exception => e
        @log.write "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!\n"
        @log.write "Stan James error:\n"
        @log.write e
        @log.write "\n"
        @log.write "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!\n"
      end
    end

    threads[3] = spawn do
      begin
        @log.write "+Nordicbet parsing started #{Time.now}\n"
       # NordicbetsParser.parse!
        @log.write "-Nordicbet parsing finished #{Time.now}\n"
      rescue Exception => e
        @log.write "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!\n"
        @log.write "Nordicbet error:\n"
        @log.write e
        @log.write "\n"
        @log.write "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!\n"
      end
    end

    #waiting all parsers to finish
    wait(threads)

   @log.write "#Clearing DB (old elements) started\n"
 #   Bet.older_than(last_parsed_time).delete_all
 #   BetType.older_than(last_parsed_time).delete_all
    Bookmaker.older_than(last_parsed_time).delete_all
    Country.older_than(last_parsed_time).delete_all
    Event.older_than(last_parsed_time).delete_all
    League.older_than(last_parsed_time).delete_all
 #   Participant.older_than(last_parsed_time).delete_all
    Sport.older_than(last_parsed_time).delete_all
 
   @log.write "Clearing DB finished\n"

    @log.write "Changing element titles\n"
    check_and_set_titles
    @log.write "Changing element titles finished\n"
    
    @log.write "Deleting events without bets\n"
    Event.all.each do |e|
      e.destroy if e.bets.empty?
    end
    @log.write "Deleting events without bets finished\n"
    @log.write "========================================================================\n"

    #period in seconds
     sleep 86400
  end

end

