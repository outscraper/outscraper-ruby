# frozen_string_literal: true

require_relative "lib/outscraper/version"

Gem::Specification.new do |spec|
  spec.name = "outscraper"
  spec.version = Outscraper::VERSION
  spec.authors = ["Outscraper"]
  spec.email = ["support@outscraper.com"]

  spec.summary = "Ruby bindings for the Outscraper API"
  spec.description = "The library provides convenient access to the Outscraper API from applications written in the Python language. Allows using Outscraper's services from your code. See https://outscraper.com for details."
  spec.homepage = "https://github.com/outscraper/outscraper-ruby"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.7.0"


  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/outscraper/outscraper-ruby"
  spec.metadata["changelog_uri"] = "https://github.com/outscraper/outscraper-ruby"
  spec.metadata["bug_tracker_uri"] = "https://github.com/outscraper/outscraper-ruby/issues"
  spec.metadata["documentation_uri"] = "https://app.outscraper.com/api-docs"
  spec.metadata["github_repo"] = "ssh://github.com/outscraper/outscraper-ruby"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
  spec.add_dependency "httparty"

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
