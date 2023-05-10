require 'hirb'
require 'pathname'

class << Hirb::Util
  # Determines if a shell command exists by searching for it in ENV['PATH'].
  # (Fixed version)
  def command_exists?(command)
    if c = Pathname.new(command)
      return true if c.absolute? && c.exist?
    end
    executable_file_exts = ENV['PATHEXT'] ? ENV['PATHEXT'].split(';') : ['']
    ENV['PATH'].split(File::PATH_SEPARATOR).any? do |d|
      executable_file_exts.any? do |ext|
        f = File.expand_path(command + ext, d)
        File.executable?(f) && !File.directory?(f)
      end
    end
  end
end # Hirb::Util.self
