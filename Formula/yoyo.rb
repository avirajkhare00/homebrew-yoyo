class Yoyo < Formula
  desc "Code intelligence MCP server — 27 tools for AI agents to read and edit any codebase"
  homepage "https://github.com/avirajkhare00/yoyo"
  version "0.22.9"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/avirajkhare00/yoyo/releases/download/v#{version}/yoyo-aarch64-apple-darwin.tar.gz"
      sha256 "4a5524055f1b51196a41d736e2aad5876657d5046251b7c8c520ff0dd5b23047"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/avirajkhare00/yoyo/releases/download/v#{version}/yoyo-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "1d9a05181d8326efecb9f82b2042ee0afdc4f27a4ad8c2f439d593cd7c66e283"
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
