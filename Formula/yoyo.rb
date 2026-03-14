class Yoyo < Formula
  desc "Code intelligence MCP server — 28 tools for AI agents to read and edit any codebase"
  homepage "https://github.com/avirajkhare00/yoyo"
  version "1.12.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/avirajkhare00/yoyo/releases/download/v#{version}/yoyo-aarch64-apple-darwin.tar.gz"
      sha256 "3980be09566fb3ad13eb173becc62198d9d217792593da958773e1cc4c0a47dd"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/avirajkhare00/yoyo/releases/download/v#{version}/yoyo-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "1ea0f5d3b6e9e6a5940074375df63dfc57eb3fab49564663903221a46422062f"
    end
  end

  def install
    bin.install Dir["yoyo-*"].first => "yoyo"
  end

  def caveats
    <<~EOS
      Getting started:

        1. Index your project
           yoyo index --path /path/to/your/project

        2. Connect to Claude Code
           Add to ~/.claude/settings.json:

           {
             "mcpServers": {
               "yoyo": {
                 "type": "stdio",
                 "command": "#{HOMEBREW_PREFIX}/bin/yoyo",
                 "args": ["--mcp-server"]
               }
             }
           }

        3. Add the hook (makes Claude prefer yoyo tools over grep/cat)
           In your project: .claude/settings.local.json

           {
             "hooks": {
               "UserPromptSubmit": [{
                 "hooks": [{
                   "type": "command",
                   "command": "echo '[yoyo] Use supersearch not grep. Use symbol+include_source not cat.'"
                 }]
               }]
             }
           }

        4. Restart Claude Code, then start a session
           Claude calls llm_instructions automatically on first contact.
    EOS
  end

  test do
    assert_match "yoyo #{version}", shell_output("#{bin}/yoyo --version")
  end
end
