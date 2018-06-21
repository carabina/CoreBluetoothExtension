Pod::Spec.new do |s|
  s.name             = 'CoreBluetoothExtension'
  s.version          = '0.1.0'
  s.summary          = 'A short description of CoreBluetoothExtension.'
  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/itanchao/CoreBluetoothExtension'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'itanchao' => 'itanchao@gmail.com' }
  s.source           = { :git => 'https://github.com/itanchao/CoreBluetoothExtension.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'

  s.source_files = 'CoreBluetoothExtension/**/*'
  s.public_header_files = 'MobikeCoreBluetooth/Public/{*.h}'
  s.private_header_files = 'MobikeCoreBluetooth/Private/{*.h}'
  s.dependency 'ReactiveObjC'
end
