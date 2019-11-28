platform :ios, '11.0'

inhibit_all_warnings!

project 'OpenWeatherApp', 'Development' => :debug, 'Staging' => :release, 'Production' => :release

target 'OpenWeatherApp' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  pod 'Dip', '7.0.1'
  pod 'SwiftLint', '0.36.0'

  target 'OpenWeatherAppTests' do
    inherit! :search_paths
    pod 'Quick', '2.2.0'
    pod 'Nimble', '8.0.4'
  end

end

plugin 'cocoapods-keys', {
  :project => "OpenWeatherApp",
  :keys => [
    "apikey"
  ]}
