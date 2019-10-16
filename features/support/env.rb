require 'fileutils'

def install_fixture_gems
  gem_dir = File.expand_path('../../../', __FILE__)
  Dir.chdir(gem_dir) do
    `rm bugsnag-*.gem` unless Dir.glob('bugsnag-*.gem').empty?
    `gem build bugsnag.gemspec`
    Dir.entries('features/fixtures').reject { |entry| ['.', '..'].include?(entry) }.each do |entry|
      target_dir = "features/fixtures/#{entry}"
      if File.directory?(target_dir)
        `cp bugsnag-*.gem #{target_dir}`
        `gem unpack #{target_dir}/bugsnag-*.gem --target #{target_dir}/temp-bugsnag-lib`
      end
    end
    `rm bugsnag-*.gem`
  end
end

# Added to ensure that multiple versions of Gems do not exist within the fixture folders,
# which can be difficult to track down and clear up
def remove_installed_gems
  removal_targets = ['temp-bugsnag-lib', 'bugsnag-*.gem']
  Dir.entries('features/fixtures').reject { |entry| ['.', '..'].include?(entry) }.each do |entry|
    target_dir = "features/fixtures/#{entry}"
    target_entries = []
    removal_targets.each do |r_target|
      target_entries += Dir.glob("#{target_dir}/#{r_target}")
    end
    target_entries.each do |d_target|
      FileUtils.rm_rf(d_target)
    end
  end
end

at_exit do
  remove_installed_gems
end

AfterConfiguration do |config|
  install_fixture_gems
  Runner.environment["BUGSNAG_API_KEY"] = $api
  Runner.environment["BUGSNAG_ENDPOINT"] = "http://maze-runner:#{MOCK_API_PORT}"
end

