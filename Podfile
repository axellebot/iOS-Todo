# Uncomment the next line to define a global platform for your project
platform :ios, '10.0'

# Comment the next line if you're not using Swift and don't want to use dynamic frameworks
use_frameworks!

# Pods for Todo
target 'Todo' do
  # Front
  pod 'RxCocoa', '~> 3.2'
  pod 'BEMCheckBox', '~> 1.4'

  # Back
  pod 'RxSwift', '~> 3.2'
  pod 'R.swift', '~> 3.0'

end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['SWIFT_VERSION'] = '3.0'
        end
    end
end

