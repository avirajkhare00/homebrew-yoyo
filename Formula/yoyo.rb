class Yoyo < Formula
  desc "Code intelligence MCP server — 28 tools for AI agents to read and edit any codebase"
  homepage "https://github.com/avirajkhare00/yoyo"
  version "1.3.1"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/avirajkhare00/yoyo/releases/download/v#{version}/yoyo-aarch64-apple-darwin.tar.gz"
      sha256 "ce0b423259cd099ce130f56c5f0e8e72cbab4e8df8c518b62da4ad10196cb525"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/avirajkhare00/yoyo/releases/download/v#{version}/yoyo-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "b1c1c5518f326629c929e326542f714282de180fb2b40aa8bf73e1ef563d3689"
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
