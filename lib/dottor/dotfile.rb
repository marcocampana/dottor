require 'fileutils'

module Dottor
  class Dotfile
    attr_accessor :source, :target

    def initialize(hash)
      @source = hash["source"]
      @target = hash["target"]
    end

    # Public: Translate a relative target path to an absolute one
    #
    # Examples
    #
    #   dotfile = Dottor::Dotfile.new "source" => "blah", "target" => ".gitconfig"
    #   dotfile.target
    #   # => '/Users/stevejobs/.gitconfig'
    #
    # Returns the absolute path for the given relative string. If the
    # string is already absolute, return unmodified.
    def target
      @expanded_target ||= File.expand_path(@target, ENV['HOME'])
    end

    def create_symlink
      # If file exists rename it to .old
      # if File.exists?(target)
      #   old_file_name = "#{target}.old"
      #   FileUtils.mv(target, old_file_name) unless File.exists?(old_file_name)
      # end

      # If symlink exists, remove it
      if File.exists?(target) || File.symlink?(target)
        FileUtils.rm target
      end

      if !File.exists?(File.dirname(target))
        FileUtils.mkdir_p(File.dirname(target))
      end

      $stdout.puts("Create symlink #{File.join(current_path, source)} -> #{target}")
      File.symlink(File.join(current_path, source), target)
    end

    def delete_symlink
      if File.symlink?(target)
        FileUtils.rm target
      end
    end

    private

    def current_path
      Dir.pwd
    end
  end
end
