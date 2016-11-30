Pod::Spec.new do |s|
    s.name         = 'ANWeather'
    s.version      = '1.0.0'
    s.summary      = 'it is a easy way to study a weather app'
    s.homepage     = 'https://github.com/ANNIGM/weather.git'
    s.license      = 'MIT'
    s.authors      = {'Annie' => 'aunty_m@sina.com'}
    s.platform     = :ios, '10.0'
    s.source       = {:git => 'https://github.com/ANNIGMe/weather.git', :tag => s.version}
    s.resource     = 'weather/weather.bundle'
    s.requires_arc = true
end
