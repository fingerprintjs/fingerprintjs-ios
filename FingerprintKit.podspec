Pod::Spec.new do |spec|
  # Name and version
  spec.name         = 'FingerprintKit'
  spec.version      = '1.0.0rc1'

  # License
  spec.license      = { type: 'MIT', file: 'LICENSE' }

  # Contact information
  spec.homepage     = 'https://fingerprintjs.com/'
  spec.authors      = {
    'FingerprintJS': 'fingerprintkit@fingerprintjs.com',
    'Petr Palata': 'petr.palata@fingerprintjs.com'
  }

  # FingerprintKit description
  spec.summary = 'Lightweight fingerprinting library for iOS'
  spec.description = <<-DESC
  FingerprintKit provides a simple API to generate a unique device fingerprint computed from a combination
  of device signals (hardware information, available identifiers, OS information and device settings).
  It operates only locally (i.e. no data are sent, seen or stored by a third party).
  DESC

  # Git location
  spec.source = {
    git: 'https://github.com/fingerprintjs/fingerprintjs-ios.git', tag: '1.0.0rc1'
  }

  # Build (source files, deployment target)
  spec.source_files = 'FingerprintKit/FingerprintKit/**/*.{swift,h,m}'
  spec.ios.deployment_target = '13.0'
  spec.swift_versions = ['5.3', '5.4', '5.5', '5.6']

  # Tests
  spec.test_spec 'Tests' do |test_spec|
    test_spec.source_files = 'FingerprintKit/FingerprintKitTests/**/*.{swift,h,m}'
  end
end
