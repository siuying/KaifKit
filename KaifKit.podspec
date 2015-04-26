Pod::Spec.new do |s|
  s.name             = "KaifKit"
  s.version          = "0.1.0"
  s.summary          = "Unofficial Kaif.io client in Objective-C."
  s.homepage         = "https://github.com/siuying/KaifKit"
  s.license          = 'MIT'
  s.author           = { "Francis Chong" => "francis@ignition.hk" }
  s.source           = { :git => "https://github.com/siuying/KaifKit.git", :tag => s.version.to_s }

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  s.dependency 'AFNetworking', '~> 2.4'
  s.dependency 'AFOAuth2Manager'
  s.dependency 'SSKeychain'
end
