require 'yaml'
require 'fileutils'
require 'thor'

require 'pp'

class Dottor < Thor
  desc "symlink", "Symlink dotfiles"
  def symlink
    puts "Loading rules YAML file"
    yaml_rules = File.open('dottor_rules.yml')

    rules = YAML::load(yaml_rules)
    profile_name = "dev_mac_os"

    rules[profile_name].each_value do |app|
      app.each do |app_file|

        # If file exists rename it to .old
        # TODO check if .old file already exists
        if File.exists?(app_file["target"])
          old_file_name = "#{app_file["target"]}.old"
          FileUtils.mv app_file["target"], old_file_name
        end

        # If symlink exists, remove it
        if File.symlink?(app_file["target"])
          FileUtils.rm app_file["target"]
        end

        FileUtils.symlink app_file["source"], app_file["target"]
      end
    end
  end
end

# TODO
# 1. Use thor to organize command line tools
# 2. by default existing files will be saved as .old
# 3. add task to init a dotfiles project by creating yaml file
# 3. add task to init a dotfiles project by creating yaml file and populate it
#    with existing files
# 4. Add task to remove symlinks
