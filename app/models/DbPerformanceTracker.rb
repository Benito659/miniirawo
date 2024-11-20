class DbPerformanceTracker
    def self.setup
      @queries = []
  
      ActiveSupport::Notifications.subscribe('sql.active_record') do |_, started, finished, _, payload|
        duration = (finished - started) * 1000
        @queries << duration if payload[:name] != 'SCHEMA'
      end
    end
  
    def self.total_duration
      @queries.sum
    end
  
    def self.reset
      @queries = []
    end
  end
    