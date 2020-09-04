# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'Gomble' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Gomble
pod 'XLPagerTabStrip'
pod 'SideMenu'
pod 'ImageSlideshow'
pod 'EFColorPicker'
pod 'SwiftyJSON'
pod 'iOSDropDown'
pod 'ExpandableCell'
pod 'AKImageCropperView'
pod 'Alamofire'
pod 'AlamofireImage'
pod 'JGProgressHUD'
pod 'Toast-Swift'
pod 'SDWebImage'
pod 'FBSDKLoginKit'

  target 'GombleTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'GombleUITests' do
    # Pods for testing
  end

end

DEFAULT_SWIFT_VERSION = '5.0'

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['SWIFT_VERSION'] = DEFAULT_SWIFT_VERSION
    end
  end
end
