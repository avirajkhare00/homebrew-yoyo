class Yoyo < Formula
  desc "Code intelligence MCP server — 28 tools for AI agents to read and edit any codebase"
  homepage "https://github.com/avirajkhare00/yoyo"
  version "1.1.3"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/avirajkhare00/yoyo/releases/download/v#{version}/yoyo-aarch64-apple-darwin.tar.gz"
      sha256 "3dca800775c772c3fa3f06a10d07ef082de3ac05bbd192e9f4013ffacde305e6"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/avirajkhare00/yoyo/releases/download/v#{version}/yoyo-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "a397e46b529a7150ced635cf07b613ef29bd72f2ec777f63acbc680f5c5f2971"
    end
  end

  def install
    bin.install Dir["yoyo-*"].first => "yoyo"
  end

  def caveats
    <<~EOS
      After installing, index your project:
        yoyo bake --path /path/to/your/project

      Then add yoyo to your Claude Code MCP config (~/.claude/settings.json):
        {
          "mcpServers": {
            "yoyo": {
              "type": "stdio",
              "command": "#{HOMEBREW_PREFIX}/bin/yoyo",
              "args": ["--mcp-server"]
            }
          }
        }

      Full setup guide: https://github.com/avirajkhare00/yoyo#setup-4-steps
    EOS
  end

  test do
    assert_match "yoyo #{version}", shell_output("#{bin}/yoyo --version")
  end
end
