class Yoyo < Formula
  desc "Code intelligence MCP server — 27 tools for AI agents to read and edit any codebase"
  homepage "https://github.com/avirajkhare00/yoyo"
  version "1.0.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/avirajkhare00/yoyo/releases/download/v#{version}/yoyo-aarch64-apple-darwin.tar.gz"
      sha256 "8ddf7c5d0d851f19a4c13585e982efa17c7e2d6b8bd565fa159fa4bb967d0b66"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/avirajkhare00/yoyo/releases/download/v#{version}/yoyo-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "6865b35cc625c939e1c31a4b887ce97772f18336161c96f1f2f2857803a5dc51"
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
