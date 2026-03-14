class Yoyo < Formula
  desc "Code intelligence MCP server — 28 tools for AI agents to read and edit any codebase"
  homepage "https://github.com/avirajkhare00/yoyo"
  version "1.12.1"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/avirajkhare00/yoyo/releases/download/v#{version}/yoyo-aarch64-apple-darwin.tar.gz"
      sha256 "8327554f83e3383dc5ee9b8fe3efb02284e00768ef39d482764264076360078b"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/avirajkhare00/yoyo/releases/download/v#{version}/yoyo-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "13ea647462cc1cf70a9223b3a08dffb7cf31992893cbb67d15649ba72d5ec82c"
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
