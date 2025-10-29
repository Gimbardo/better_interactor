# frozen_string_literal: true

require_relative "lib/better_interactor/version"

Gem::Specification.new do |spec|
  spec.name = "better_interactor"
  spec.version = BetterInteractor::VERSION
  spec.authors = ["Gamberi Elia"]
  spec.email = ["me@gimbaro.dev"]

  spec.summary = "Better Interactor is a small gem that aims to improve a lot of stuff that is missing in the main interactor gem"
  spec.homepage = "https://gimbaro.dev"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.2.0"

  spec.metadata["allowed_push_host"] = "https://rubygems.org/"
  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/Gimbardo/better_interactor"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  gemspec = File.basename(__FILE__)
  spec.files = IO.popen(%w[git ls-files -z], chdir: __dir__, err: IO::NULL) do |ls|
    ls.readlines("\x0", chomp: true).reject do |f|
      (f == gemspec) ||
        f.start_with?(*%w[bin/ Gemfile .gitignore .rspec spec/ .github/ .rubocop.yml])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  spec.add_dependency "interactor-rails", "~> 2.3"
  spec.add_dependency "activesupport", ">= 6.0"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
