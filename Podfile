# Uncomment the next line to define a global platform for your project
platform :ios, '14.0'

target 'Mealios' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Mealios
  pod 'Foil'
  pod 'Alamofire'
  pod 'lottie-ios'
  pod 'AlamofireNetworkActivityLogger', '~> 3.4'

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
