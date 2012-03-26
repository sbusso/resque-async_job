# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "resque-async_job/version"

Gem::Specification.new do |s|
  s.name        = "resque-async_job"
  s.version     = Resque::AsyncJob::VERSION
  s.authors     = ["Stephane Busso"]
  s.email       = ["stephane.busso@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{A simple method to queue jobs}
  s.description = %q{A simple method to queue jobs}

  s.rubyforge_project = "resque-async_job"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  # s.add_development_dependency "rspec"
  # s.add_runtime_dependency "rest-client"
end
