Pod::Spec.new do |s|
s.name             = 'GeoUniq'
s.version          = '1.1.9'
s.summary          = 'GeoUniq ios framework'


s.homepage        = "http://www.geouniq.com"
s.license         = { :type => 'CUSTOM', :file => 'LICENSE' }
s.author          = { 'Paolo Donato' => 'paolo.donato@geouniq.com' }
s.platform     = :ios
s.ios.deployment_target = '8.1'

# the Pre-Compiled Framework:
s.source          = { :http => 'https://github.com/geouniq/GeoUniqSDK-iOS/raw/master/GeoUniq.zip' }
s.ios.vendored_frameworks = 'GeoUniq.framework'
s.swift_version = "3.3"
s.pod_target_xcconfig = { 'SWIFT_VERSION' => '3.3' }

end
