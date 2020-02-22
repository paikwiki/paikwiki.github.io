# coding: utf-8

Gem::Specification.new do |spec|
  spec.name          = "jekyll-theme-paikwiki"
  spec.version       = "0.1.0"
  spec.authors       = ["paikwiki"]
  spec.email         = ["paikwiki@gmail.com"]

  spec.summary       = "Jekyll theme for paikwiki.github.io"
  spec.homepage      = "https://github.com/paikwiki/paikwiki.github.io.git"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").select { |f| f.match(%r{^(assets|_layouts|_includes|_sass|LICENSE|README)}i) }

  spec.add_runtime_dependency "jekyll", "~> 4.0"

  spec.add_development_dependency "bundler", "~> 1.12"
  spec.add_development_dependency "rake", "~> 10.0"
end
