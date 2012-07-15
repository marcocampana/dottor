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

      say("Loading rules YAML file")
      rules = YAML::load(yaml_rules)

      rules[profile_name].each do |mapping|
        dotfile = Dotfile.new(mapping)
        if options[:delete]
          dotfile.delete_symlink
        else
          dotfile.create_symlink
        end
      end
    end

    desc "init", "Create dottor_rule.yml file"
    method_option :force, :desc => "Overwrite existing dottor_rules.yml file"
    def init
      if File.exists?('dottor_rules.yml')
        if options[:force]
          FileUtils.rm 'dottor_rules.yml'
        else
          say("Abort: dottor_rules.yml already exist. Use the --force to overwrite.")
          exit(1)
        end
      end

      rules_hash = {"profile_name" => []}

      exclude_files = ['.gitignore', 'README', 'README.md']
      if git_repo?
        files_in_current_dir = `git ls-files`.split("\n") - exclude_files
      else
        files_in_current_dir = Dir["*"] - exclude_files
      end

      if files_in_current_dir.empty?
        rules_hash["profile_name"] = [{"source" => ".dotfile", "target" => "target_path/.dotfile"}]
      else
        files_in_current_dir.each do |file_name|
          rules_hash["profile_name"] << {"source" => file_name, "target" => "target_path/#{file_name}"}
        end
      end

      File.open('dottor_rules.yml', 'w') do |file|
        file.write(YAML.dump(rules_hash))
      end

      say("dottor_rules.yml file created. Modify it and run 'dottor symlink <profile_name>'")
    end

    private

    # TODO move into an helper module
    def git_repo?
      File.exists? '.git'
    end
  end
end
