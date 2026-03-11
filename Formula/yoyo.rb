class Yoyo < Formula
  desc "Code intelligence MCP server — 28 tools for AI agents to read and edit any codebase"
  homepage "https://github.com/avirajkhare00/yoyo"
  version "1.7.3"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/avirajkhare00/yoyo/releases/download/v#{version}/yoyo-aarch64-apple-darwin.tar.gz"
      sha256 "85bd1afb44e8600d9d00fedd628b9d7a090386315085c924a51e7655f443b4e4"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/avirajkhare00/yoyo/releases/download/v#{version}/yoyo-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "01355726ce05402e9ea3ed8bdb70b2fba6e52cd05916a97009e5fc50444a7c8b"
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
