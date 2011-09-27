begin
  #!/usr/bin/env ruby
  require File.dirname(__FILE__) + "/../../config/application"
  Rails.application.require_environment!

  include CalculatingName
  include Spawn

  ENV["RAILS_ENV"] ||= "development"
  COMMON_BETTYPES = ['Outright', '1x2', '1or2']
  GAMEBOOKERS = ['Outright', 'Versus (with Draw)', ['To Win the Match', 'Versus', 'Draw No Bet']]
  BETREDKINGS = ['Winner', 'Home Draw Away', 'Home Away With Impossible Draw']
  NORDICBET = ['Result Winner', 'Result (OutcomeSet has 3 children nodes)', 'Result (OutcomeSet has 2 children nodes)']
  STANJAMES = [["NBA Outright", "Eastern Conference", "Western Conference",
                "Tournament Outright Prices", "Outright Prices", "Australian Open 2012",
                "Wimbledon 2012", "French Open 2012", "Australian Open 2012",
                "Davis Cup Outright 2011", "Men's Wimbledon 2012", "US Open 2012"],
                'Match Betting',
                ["Draw No Bet", "Match Winner", "Match Prices"]]

  COMMON_BETTYPES.each_with_index do |c,i|
    common = Common.create(:element_name => c, :table_name => 'bet_type')
    GAMEBOOKERS[i].each do |g|
      Gamebooker.create(:element_name => g, :table_name => 'bet_type', :common_id => common.id)
    end
    BETREDKINGS[i].each do |b|
      Betredking.create(:element_name => b, :table_name => 'bet_type', :common_id => common.id)
    end
    NORDICBET[i].each do |n|
      Nordicbet.create(:element_name => n, :table_name => 'bet_type', :common_id => common.id)
    end
    STANJAMES[i].each do |s|
      StanJame.create(:element_name => s, :table_name => 'bet_type', :common_id => common.id)
    end
  end

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

    #array for pids
    threads = []

    threads[0] = spawn do
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
    end

    threads[1] = spawn do
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
    end

    threads[2] = spawn do
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
    end

    threads[3] = spawn do
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
    end

    #waiting all parsers to finish
    wait(threads)

    @log.write "Clearing DB (old elements) started\n"
    Sport.old.delete_all
    Event.old.delete_all
    League.old.delete_all
    Country.old.delete_all
    BetType.old.delete_all
    Bet.old.delete_all
    @log.write "Clearing DB finished\n"

    @log.write "========================================================================\n"

    #One time per day
     sleep 86400
  end

end

