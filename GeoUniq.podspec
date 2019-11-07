Pod::Spec.new do |s|
s.name             = 'GeoUniq'
s.version          = '1.5.10'
s.summary          = 'GeoUniq ios framework'


s.homepage        = "http://www.geouniq.com"
s.license         = { :type => 'CUSTOM', :file => 'LICENSE' }
s.author          = { 'Paolo Donato' => 'paolo.donato@geouniq.com' }
s.platform     = :ios
s.ios.deployment_target = '8.1'

# the Pre-Compiled Framework:
s.source          = { :http => "https://github.com/geouniq/GeoUniqSDK-iOS/raw/master/GeoUniq-#{s.version}.zip" }
s.ios.vendored_frameworks = 'GeoUniq.framework'
s.swift_version = "4.2"
s.pod_target_xcconfig = { 'SWIFT_VERSION' => '4.2' }

end
