class BetafishaLogger

  def self.print_log ( word )
    ActiveRecord::Base.logger.auto_flushing = true
    if word == 'time_now'
      ActiveRecord::Base.logger.info "[ " + Time.now.to_s + " ] \n"
    else
      ActiveRecord::Base.logger.info  word.to_s + "\n"
    end
  end

end