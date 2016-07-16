Pod::Spec.new do |s|
  s.name     = 'SCPinViewController'
  s.version  = '0.0.1'
  s.license  = 'MIT'
  s.summary  = 'Super customization pin code validator'
  s.homepage = 'http://gitlab.sugarandcandy.ru/iOS/SCPinViewController'
  s.social_media_url = 'https://twitter.com/sugarandcandyru'
  s.authors  = { 'Sugar and Candy' => 'hi@sugarandcandy.ru' }
  s.source   = { :git => 'https://github.com/SugarAndCandy/SCPinViewController.git', :tag => s.version, :submodules => true }
  s.requires_arc = true
  s.platform     = :ios, "8.0"
  s.ios.deployment_target = "8.0"

  s.public_header_files = 'SCPinViewController/**/SC*.h'
  s.source_files = 'SCPinViewController/**/SC*.{m,h}'
  s.resource_bundles = {
    'SCPinViewControllerBudle' => ['SCPinViewController/**/*.{png}','SCPinViewController/**/*.{xib}']
  }
end
