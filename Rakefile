#!/usr/bin/env rake

require 'bundler/gem_tasks'

require 'shellwords'

def gemspec_file
  @gemspec_file ||= Dir['*.gemspec'].first
end

def gemspec
  @gemspec ||= Gem::Specification::load(gemspec_file)
end

def version
  gemspec.version
end

def name
  gemspec.name
end

def platform
  gemspec.platform
end

# output .gem filename, per platform
def gem_file(platform)
  r = "#{name}-#{version}"
  plat_suffix = "-#{platform}" unless platform == 'ruby'
  r + '.gem'
end

def git_dirty?
  r = `git diff --shortstat`.chop != ''
  fail unless $?.success?
  r
end

def assert_git_clean
  raise 'Git working directory must be clean before continuing' if git_dirty?
end

def assert_gem_is_signed(gem)
  files = `tar tf #{gem}`.split("\n")
  fail "#{gem} bad" unless $?.success?
  signed_files = %w[metadata data checksums.yaml].map { |x| "#{x}.gz.sig" }
  missing_files = files - signed_files
  fail "#{gem} is unsigned, check gem-public_cert.pem" if !missing_files.empty?
end

### release ruby gem

desc 'make the current git commit into a tag equal the current version.rb'
task :tag do
  assert_git_clean
  return if `git tag --points-at HEAD`.split("\n").map(&:strip).include?(version)
  sh "git tag -s #{version} -m #{version}"
  sh "git push --tags origin master"
end

desc 'before any release(s)'
task :prerelease => [:tag]

def gem_build(chruby_engine)
  rubies_dir = ENV['RUBIES_ROOT'] || '/opt/rubies'
  rubies = Dir[File.join(rubies_dir, '*')]
  rubies_escaped = rubies.map { |rb| Shellwords.escape rb }.join(' ')
  sh "chruby-exec RUBIES=(#{rubies_escaped}) #{chruby_engine} -- gem build #{gemspec_file}"
end

desc 'release JRuby gem'
task 'release-jruby' do #=> :prerelease do
  gem_build('jruby')
  gem = gem_file('java')
  assert_gem_is_signed(gem)
  sh "gem push #{gem}"
end

desc 'release Ruby gem'
task 'release-ruby' => :prerelease do
  gem_build('ruby-2')
  gem = gem_file('ruby')
  assert_gem_is_signed(gem)
  sh "gem push #{gem}"
end

desc 'release all gems'
task :release => ['release-ruby', 'release-jruby']


## version bumping

def bump(idx)
  assert_git_clean

  old_version = version.to_s
  v = old_version.split('.').map(&:to_i)
  v[idx] += 1
  (v.size-idx-1).times { |i| v[idx+1+i] = 0 }
  new_version = v.map(&:to_s).join('.')

  version_file = 'lib/spirit_hands/version.rb'
  sh "sed -i'' -e 's/#{old_version}/#{new_version}/' #{version_file}"
  sh "git add #{version_file}"
  sh "git commit -sS -m 'bump to #{new_version}'"
  sh "git push --tags origin master"
end

desc 'bump release version'
task :bump do
  bump 2
end

desc 'bump minor version'
task 'bump:minor' do
  bump 1
end

desc 'bump major version'
task 'bump:major' do
  bump 0
end

desc 'show version'
task :version do
  puts version
end
