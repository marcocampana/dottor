describe Dottor::Dotfile do
  before(:each) do
    ENV['HOME'] = "/home/stevejobs"
  end

  describe "#target" do
    it "should leave an absolute filepath as is" do
      dotfile = Dottor::Dotfile.new("source" => "/woot/gitconfig", "target" => "/home/woot/gitconfig")
      dotfile.target.should eq("/home/woot/gitconfig")
    end

    it "should return a path relative to the user's home directory" do
      dotfile = Dottor::Dotfile.new("source" => "/woot/gitconig", "target" => ".gitconfig")
      dotfile.target.should eq("/home/stevejobs/.gitconfig")
    end

    it "should substitute the user's home directory for the tilde character, '~'" do
      dotfile = Dottor::Dotfile.new("source" => "/woot/gitconig", "target" => "~/.gitconfig")
      dotfile.target.should eq("/home/stevejobs/.gitconfig")
    end
  end
end
