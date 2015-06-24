#
# Be sure to run `pod lib lint ApIdleManager.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "ApIdleManager"
  s.version          = "0.0.3"
  s.summary          = "APIdleManager is a iOS custom class that allows developers to set-up a custom idle timeout without subclassing UIApplication"
  s.homepage         = "https://github.com/MitchellMalleo/APIdleManager"
  s.license          = 'MIT'
  s.author           = { "Mitch Malleo" => "mitchellmalleo@gmail.com" }
  s.source           = { :git => "https://github.com/MitchellMalleo/APIdleManager.git", :tag => s.version.to_s }
  s.platform     = :ios, '5.0'
  s.requires_arc = true
  s.source_files = 'Classes', 'Classes/**/*.{h,m}'
end
