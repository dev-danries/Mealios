# Uncomment the next line to define a global platform for your project
platform :ios, '15.0'

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings.delete 'IPHONEOS_DEPLOYMENT_TARGET'
    end
  end
end

target 'Mealios' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Mealios
  pod 'Foil'
  pod 'Alamofire'
  pod 'lottie-ios'
  pod 'WrappingHStack'

  target 'MealiosScreenshots' do
    # Pods for testing
    pod 'Telegraph'
  end

  target 'MealiosTests' do
    inherit! :search_paths
    pod 'Mocker'
    pod 'Telegraph'
  end

  target 'MealiosUITests' do
    # Pods for testing
    pod 'Telegraph'
  end

end
