Gem::Specification.new do |spec|
  spec.name          = "jeredis"
  spec.version       = "0.1.0"
  spec.platform      = "java"
  spec.authors       = ["Konstantin Shabanov"]
  spec.email         = ["etehtsea@gmail.com"]

  spec.summary       = spec.description = "Jedis wrapper"
  spec.homepage      = "http://github.com/etehtsea/jeredis"
  spec.license       = "MIT"

  spec.files         = `git ls-files -- lib`.split("\n")
  spec.test_files    = `git ls-files -- {spec}/*`.split("\n")

  spec.require_paths = ["lib"]

  spec.add_development_dependency "rake", ">= 10.0.0"
  spec.add_development_dependency "rspec", ">= 3.0.0", "<= 4.0.0"
  spec.add_development_dependency "database_cleaner"
  spec.add_development_dependency "redis"
  spec.add_development_dependency "pry"
end
