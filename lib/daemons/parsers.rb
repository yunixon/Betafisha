begin
  #!/usr/bin/env ruby
  require File.dirname(__FILE__) + "/../../config/application"
  Rails.application.require_environment!

  include CalculatingName
  ENV["RAILS_ENV"] ||= "development"

  $running = true
  Signal.trap("TERM") do
    $running = false
  end

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
    @log.write "Clearing DB started\n"
    Sport.delete_all
   # Bookmaker.delete_all
    Event.delete_all
    League.delete_all
    Country.delete_all
    BetType.delete_all
    Bet.delete_all
    @log.write "Clearing DB finished\n"

    begin
      @log.write "Gamebookers parsing started #{Time.now}\n"
      GamebookersParser.parse!
      @log.write "Gamebookers parsing finished #{Time.now}\n"
    rescue Exception => e
      @log.write "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!\n"
      @log.write "Gamebookers error:\n"
      @log.write e
      @log.write "\n"
      @log.write "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!\n"
    end

    begin
      @log.write "Betredkings parsing started #{Time.now}\n"
      BetredkingsParser.parse!
      @log.write "Betredkings parsing finished #{Time.now}\n"
    rescue Exception => e
      @log.write "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!\n"
      @log.write "Betredkings error:\n"
      @log.write e
      @log.write "\n"
      @log.write "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!\n"
    end

    begin
      @log.write "Stan James parsing started #{Time.now}\n"
      StanjamesParser.parse!
      @log.write "Stan James parsing finished #{Time.now}\n"
    rescue Exception => e
      @log.write "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!\n"
      @log.write "Stan James error:\n"
      @log.write e
      @log.write "\n"
      @log.write "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!\n"
    end

    begin
      @log.write "Nordicbet parsing started #{Time.now}\n"
      NordicbetsParser.parse!
      @log.write "Nordicbet parsing finished #{Time.now}\n"
    rescue Exception => e
      @log.write "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!\n"
      @log.write "Nordicbet error:\n"
      @log.write e
      @log.write "\n"
      @log.write "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!\n"
    end

    @log.write "========================================================================\n"

    #One time per day
     sleep 86400
  end

end

