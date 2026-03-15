class Yoyo < Formula
  desc "Code intelligence MCP server — 28 tools for AI agents to read and edit any codebase"
  homepage "https://github.com/avirajkhare00/yoyo"
  version "1.14.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/avirajkhare00/yoyo/releases/download/v#{version}/yoyo-aarch64-apple-darwin.tar.gz"
      sha256 "234e61d2e094fff0b0f2115663cdc75212957e0aa4d2845031769e0585dcfc1a"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/avirajkhare00/yoyo/releases/download/v#{version}/yoyo-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "ea22da3cda540b6f8cf35111c2157374429b4df621802cb1664cab51aa145eb6"
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
