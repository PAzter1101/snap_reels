Pod::Spec.new do |s|
  s.name             = 'snap_reels'
  s.version          = '3.1.0'
  s.summary          = 'Vertical video reels widget for Flutter.'
  s.description      = <<-DESC
Vertical video reels widget for Flutter — packaging shim for macOS.
                       DESC
  s.homepage         = 'https://github.com/PAzter1101/snap_reels'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'PAzter1101' => 'noreply@github.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'FlutterMacOS'
  s.platform = :osx, '10.14'
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES' }
  s.swift_version = '5.0'
end
