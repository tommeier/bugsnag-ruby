require 'delayed_job'

class UnhandledJob
  def perform
    raise 'Testing error handling in delayed jobs'
  end
end

Delayed::Job.enqueue(UnhandledJob.new)