require 'yaml'
require 'fileutils'
require 'thor'

require 'dottor/dotfile'

module Dottor
  class App < Thor
    desc "symlink <profile_name>", "Symlink dotfiles defined in specified profile name"
    method_option :file, :aliases => "-f", :desc => "Use specified rules yaml file instead of the default dottor_rules.yml"
    method_option :delete, :aliases => "-d", :desc => "Delete existing symlinks added by dottor"
    def symlink(profile_name)
      yaml_rules = options[:file] ? File.open(options[:file]) : File.open('dottor_rules.yml')

      puts "Loading rules YAML file"
      rules = YAML::load(yaml_rules)

      rules[profile_name].each_value do |app|
        app.each do |app_file|
          Dotfile.new(app_file)

          if options[:delete]
            Dotfile.delete_symlink
          else
            Dotfile.create_symlink
          end
        end
      end
    end

    desc "init", "Create dottor_rule.yml file"
    def init
      if File.exists?('dottor_rules.yml')
        say("Abort: dottor_rules.yml already exist.")
        exit(1)
      end

      default_hash = {"profile_name" => {"app" => [{"source" => ".dotfile", "target" => "target/.dotfile"}]}}

      File.open('dottor_rules.yml', 'w') do |file|
        file.write(YAML.dump(default_hash))
      end

      say("dottor_rules.yml file created. Modify it and run 'dottor symlink <profile_name>'")
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
