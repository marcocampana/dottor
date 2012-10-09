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

  describe "#create_symlink", fakefs: true do
    it "should create directories that don't exist in the target location" do
      source = "/tmp/woot/immaconfig"
      target = "/tmp/nodir/immaconfig"
      dotfile = Dottor::Dotfile.new("source" => source, "target" => target)
      FileUtils.mkdir("/tmp")
      FileUtils.mkdir("/tmp/woot")
      File.open(source, "w") do |f|
        f.puts "CONFIG YEAH"
      end

      File.exists?("/tmp/nodir").should be_false
      dotfile.create_symlink
      File.symlink?(target).should be_true
    end
  end
end
