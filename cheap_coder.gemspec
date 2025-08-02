# frozen_string_literal: true

require_relative 'lib/cheap_coder/version'

Gem::Specification.new do |spec|
  spec.name = 'cheap_coder'
  spec.version = CheapCoder::VERSION
  spec.authors = ['Daiji Tsutsui']
  spec.email = ['daiji.tsutsui417@gmail.com']

  spec.summary = 'A Ruby script censor who prefers very simple scripts.'
  spec.description = 'This gem can censor Ruby scripts and only allows non-structed scripts which do not contain any system command.'
  spec.homepage = 'https://github.com/daiji-tsutsui/cheap_coder'
  spec.license = 'MIT'
  spec.required_ruby_version = '>= 3.4.0'

  spec.metadata['allowed_push_host'] = 'https://rubygems.org'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/daiji-tsutsui/cheap_coder'
  spec.metadata['changelog_uri'] = 'https://github.com/daiji-tsutsui/cheap_coder/blob/master/CHANGELOG.md'
  spec.metadata['rubygems_mfa_required'] = 'true'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  gemspec = File.basename(__FILE__)
  spec.files = IO.popen(%w[git ls-files -z], chdir: __dir__, err: IO::NULL) do |ls|
    ls.readlines("\x0", chomp: true).reject do |f|
      (f == gemspec) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git .github appveyor Gemfile])
    end
  end
  spec.bindir = 'exe'
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  # Uncomment to register a new dependency of your gem
  spec.add_dependency 'dotenv', '~> 3.1'
  spec.add_dependency 'parser', '~> 3.3'
  spec.add_dependency 'unparser', '~> 0.8'

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
