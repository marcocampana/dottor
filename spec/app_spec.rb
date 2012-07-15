require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Dottor::App" do
  describe "symlink" do
    it "should use the dottor_rules.yml in current directory by default" do
      stub_dottor_rules_file('dottor_rules.yml')
      stub_dotfile

      Dottor::App.start(['symlink', 'development'])
    end

    it "should use the specified dottor_rules file with -f option" do
      stub_dottor_rules_file('../my_custom_dottor_rules.yml')
      stub_dotfile

      Dottor::App.start(['symlink', 'development', '-f', '../my_custom_dottor_rules.yml'])
    end

    it "should call the create_symlink method" do
      stub_dottor_rules_file('dottor_rules.yml')
      stub_dotfile(:create_symlink)

      Dottor::App.start(['symlink', 'development'])
    end
  end
end
