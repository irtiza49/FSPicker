Pod::Spec.new do |s|
  s.name         = 'FSPicker'
  s.version      = '0.1.3'
  s.summary      = "Filestack's picker controller implementation."

  s.description  = <<-DESC
              Upload images and files of any kind. Transform them into different styles and formats. Deliver them rapidly and responsively to the world.
  DESC

  s.homepage     = 'https://github.com/filestack/FSPicker'
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author       = { 'Filestack' => 'lukasz@filestack.com' }

  s.source       = {
    :git => 'https://github.com/filestack/FSPicker.git',
    :tag => "#{s.version}-beta"
  }

  s.ios.deployment_target = '8.4'
  s.osx.deployment_target = '10.9'
  s.requires_arc = true

  s.ios.public_header_files = %w(
    FSPicker/Shared/Models/FSMimeTypes.h
    FSPicker/Shared/Models/FSProtocols.h
    FSPicker/Platforms/iOS/FSPicker.h
    FSPicker/Platforms/iOS/Models/FSConfig.h
    FSPicker/Platforms/iOS/Models/FSTheme.h
    FSPicker/Platforms/iOS/ViewControllers/FSPickerController.h
  )

  s.ios.source_files = %w(
    FSPicker/Shared/Models/*.{h,m}
    FSPicker/Platforms/iOS/*.{h,m}
    FSPicker/Platforms/iOS/Views/*.{h,m}
    FSPicker/Platforms/iOS/ViewControllers/*.{h,m}
    FSPicker/Platforms/iOS/Models/*.{h,m}
    FSPicker/Platforms/iOS/KAProgressLabel/*.{h,m}
    FSPicker/Platforms/iOS/FSImageVideoPicker/*.{h,m}
  )

  s.resources = 'FSPicker/Shared/Resources/fsImages.xcassets', 'FSPicker/Shared/Resources/fsAllowedUrlPrefix.plist'

  s.ios.dependency 'Filestack'
end
