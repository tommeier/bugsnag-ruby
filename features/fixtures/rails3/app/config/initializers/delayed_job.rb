if defined?(DelayedJob)
  Delayed::Worker.backend = :active_record
  Delayed::Worker.max_attempts = 1
end