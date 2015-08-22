Pod::Spec.new do |s|
  s.name             = "NRGProfiler"
  s.version          = "1.0.0"
  s.summary          = "Simple time profiling library in Objective-C based on MTU (Mach Time Units)"
  s.homepage         = "https://github.com/NRGRepo/NRGProfiler"
  s.license          = { :type => "Apache", :file => "LICENSE" }
  s.author           = { "Georgiy Malyukov" => "" }
  s.source           = { :git => "https://github.com/NRGRepo/NRGProfiler.git", :tag => s.version.to_s }
  s.social_media_url = 'http://deadlineru.livejournal.com'

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  s.resource_bundles = {
    'test' => ['Pod/Assets/*.png']
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end