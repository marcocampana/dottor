module Utils
  def stub_dottor_rules_file(file_name)
    dottor_rules_file = File.open(File.expand_path(File.dirname(__FILE__) + '/../fixtures/dottor_rules.yml'))
    File.should_receive(:open).with(file_name).and_return(dottor_rules_file)
  end

  def stub_dotfile(method=nil)
    dotfile_mock = mock(:delete_symlink => nil, :create_symlink => nil)
    Dottor::Dotfile.should_receive(:new).and_return(dotfile_mock)

    dotfile_mock.should_receive(method) if method
  end
end
