class Maiao < Formula
  desc "Seamless GitHub PR management from the command-line"
  homepage "https://github.com/tjamet/maiao"
  url "https://github.com/tjamet/maiao.git",
    tag:      "1.1.4-test-version-bump-do-not-use",
    revision: "cde21180e33704bd5f03fd2e1e88b8afaa250b9f"
  license "MIT"
  conflicts_with "git-review"
  head "https://github.com/tjamet/maiao.git",
    branch: "main"

  depends_on "go" => :build

  def install
    ldflags = %W[
      -s -w
      -X github.com/adevinta/maiao/pkg/version.Version=#{version}+homebrew-adevinta-maiao
    ]

    system "go", "build", *std_go_args(ldflags: ldflags, output: bin/"git-review"), "./cmd/maiao"
    generate_completions_from_executable(bin/"git-review", "completion")
  end

  test do
    assert_match "#{version}+homebrew-adevinta-maiao", shell_output("#{bin}/git-review version")
  end
end
