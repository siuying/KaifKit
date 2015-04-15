#
# Be sure to run `pod lib lint KaifKit.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "KaifKit"
  s.version          = "0.1.0"
  s.summary          = "A short description of KaifKit."
  s.description      = <<-DESC
                       An optional longer description of KaifKit

                       * Markdown format.
                       * Don't worry about the indent, we strip it!
                       DESC
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
