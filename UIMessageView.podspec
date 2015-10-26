#
# Be sure to run `pod lib lint UIMessageView.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "UIMessageView"
  s.version          = "0.2.1"
  s.summary          = "A replication of the Messages view in iOS 8"
  s.description      = <<-DESC
                       UIMessageView can be used to create a "Messages" screen that
                       looks and feels similar to the built in messages applicaiton
                       on iOS. The styles can be easily updated to fit your own design
                       by replacing the images with the design you desire... Remember to
                       keep the filenames the same though!
                       DESC
  s.homepage         = "https://github.com/AppEaseLtd/UIMessageView"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "Robin Crorie" => "robin@appease.biz" }
  s.source           = { :git => "https://github.com/AppEaseLtd/UIMessageView.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/AppEaseLtd'

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  s.resources = 'Pod/Assets/*.png'


  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
