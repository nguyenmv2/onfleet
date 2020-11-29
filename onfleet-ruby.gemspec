Gem::Specification.new do |s|
  s.name        = 'onfleet-ruby'
  s.version     = '0.1.8'
  s.date        = '2017-06-06'
  s.summary     = "Onfleet ruby api"
  s.description = "To interact with Onfleet's API"
  s.authors     = ["Nick Wargnier"]
  s.email       = 'nick@stylelend.com'
  s.homepage    = 'http://rubygems.org/gems/onfleet-ruby'
  s.license     = 'MIT'

  s.add_dependency('rest-client', '>= 2.0')

  s.add_development_dependency("rspec",'~> 3.3.0', '>= 3.0.0')


  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_paths = ['lib']
end
