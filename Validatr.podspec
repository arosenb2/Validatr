#
# Be sure to run `pod lib lint Validatr.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'Validatr'
  s.version          = '1.0.0'
  s.summary          = 'Swift 5 library for validating UITextField'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
Provides a set of validation methods and a functional approach to run validation on the text within UITextField
                       DESC

  s.homepage         = 'https://github.com/arosenb2/Validatr'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Aaron Rosenbaum' => 'aaron.rosenbaum@gmail.com' }
  s.source           = { :git => 'https://github.com/arosenb2/Validatr.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/aaronrosenbaum'

  s.ios.deployment_target = '11.0'
  s.swift_version = '5.0'

  s.source_files = 'Validatr/Classes/**/*'
  
  # s.resource_bundles = {
  #   'Validatr' => ['Validatr/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'UIKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end

