module Dottor
  class Dotfile
    attr_accessor :source, :target

    def initialize(hash)
      @source = hash["source"]
      @target = hash["target"]
    end

    def create_symlink
      # If file exists rename it to .old
      # TODO check if .old file already exists
      if File.exists?(target)
        old_file_name = "#{target}.old"
        FileUtils.mv target, old_file_name
      end

      # If symlink exists, remove it
      if File.symlink?(target)
        FileUtils.rm target
      end

      $stdout.puts("Create symlink #{File.join(current_path, source)} -> #{target}")
      FileUtils.symlink File.join(current_path, source), target
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
