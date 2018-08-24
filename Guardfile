# vim: ft=ruby:

guard 'minitest', all_on_start: true, all_after_pass: true,
                  notification: true do
  watch('Gemfile.lock')
  watch(%r{^lib/mocapi.rb\.rb$})
  watch(%r{^lib/(.+)\.rb$}) { |m| "test/#{m[1]}_test.rb" }
  watch(%r{^test/.+_test\.rb$})
  watch(%r{^test/helper\.rb$}) { 'test' }
end
