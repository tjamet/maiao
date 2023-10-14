class Maiao < Formula
  desc "Seamless GitHub PR management from the command-line"
  homepage "https://github.com/tjamet/maiao"
  url "https://github.com/tjamet/maiao.git",
    tag:      "0.0.0-test-release-action-do-not-use",
    revision: "c3ce0c6ebd03c8c7d3f98e97f2c0e71057b3d40f"
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
