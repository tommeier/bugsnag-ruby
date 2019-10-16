Then(/^the "(.+)" of the top non-bugsnag stackframe equals (\d+|".+")(?: for request (\d+))?$/) do |element, value, request_index|
  stacktrace = read_key_path(find_request(request_index)[:body], 'events.0.exceptions.0.stacktrace')
  frame_index = stacktrace.find_index { |frame| ! /.*lib\/bugsnag.*\.rb/.match(frame["file"]) }
  steps %Q{
    the "#{element}" of stack frame #{frame_index} equals #{value}
  }
end

Then(/^the total sessionStarted count equals (\d+)(?: for request (\d+))?$/) do |value, request_index|
  session_counts = read_key_path(find_request(request_index)[:body], "sessionCounts")
  total_count = session_counts.inject(0) { |count, session| count += session["sessionsStarted"] }
  assert_equal(value, total_count)
end