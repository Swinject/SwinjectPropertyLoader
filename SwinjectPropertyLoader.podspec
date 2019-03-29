Pod::Spec.new do |s|
  s.name             = "SwinjectPropertyLoader"
  s.version          = "1.1.0"
  s.summary          = "Swinject extension to load property values from resources"
  s.description      = <<-DESC
                       SwinjectPropertyLoader is an extension of Swinject to load property values from resources that are bundled with your application/framework.
                       DESC
  s.homepage         = "https://github.com/Swinject/SwinjectPropertyLoader"
  s.license          = 'MIT'
  s.author           = 'Swinject Contributors'
  s.source           = { :git => "https://github.com/Swinject/SwinjectPropertyLoader.git", :tag => s.version.to_s }

  s.source_files = 'Sources/**/*.{swift,h}'
  s.ios.deployment_target = '8.0'
  s.osx.deployment_target = '10.10'
  s.watchos.deployment_target = '2.0'
  s.tvos.deployment_target = '9.0'
  s.dependency 'Swinject', '~> 2.6.0'
  s.requires_arc = true
end
