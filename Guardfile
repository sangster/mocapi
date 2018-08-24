# vim: ft=ruby:
group :red_green, halt_on_fail: true, all_on_start: true, all_after_pass: true,
                  notification: true do

  guard 'minitest' do
    watch('Gemfile.lock')
    watch(%r{^lib/mocapi.rb\.rb$})
    watch(%r{^lib/(.+)\.rb$}) { |m| "test/#{m[1]}_test.rb" }
    watch(%r{^test/.+_test\.rb$})
    watch(%r{^test/helper\.rb$}) { 'test' }
  end

  guard :rubocop do
    watch(%r{^lib/.+\.rb$})
    watch(%r{(?:.+/)?\.rubocop(?:_todo)?\.yml$}) { |m| File.dirname(m[0]) }
  end
end
