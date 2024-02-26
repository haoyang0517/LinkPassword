# Uncomment the next line to define a global platform for your project
platform :ios, '13.0'

post_install do |pi|
  pi.pods_project.targets.each do |t|
    t.build_configurations.each do |config|
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
    end
  end
end

target 'LinkPassword' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for LinkPassword

  # Dependency Injection
  pod 'Swinject', '~> 2.7.1'

  # Reactive
  pod 'RxSwift'
  pod 'RxCocoa'
   
  # Reactive Utility
  pod 'RxDataSources', '~> 5.0.0'
  pod 'RxGesture', '~> 4.0.2'
  pod 'RxBiBinding', '~> 0.3.5'

  # keyboard
  pod 'IQKeyboardManagerSwift', '~> 6.5.0'

  # Utility
  pod 'SwifterSwift', '~> 4.6.0'


end
