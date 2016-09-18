Pod::Spec.new do |s|
  s.name         = "Log"
  s.version      = "1.0"
  s.license      = { :type => "MIT" }
  s.homepage     = "https://github.com/delba/Log"
  s.author       = { "Damien" => "damien@delba.io" }
  s.summary      = "An extensible logging framework for Swift"
  s.source       = { :git => "https://github.com/delba/Log.git", :tag => "v1.0" }

  s.ios.deployment_target = "8.0"
  s.osx.deployment_target = "10.9"
  s.tvos.deployment_target = "9.0"
  s.watchos.deployment_target = "2.0"

  s.source_files = "Source/**/*.{swift, h}"

  s.requires_arc = true
end
