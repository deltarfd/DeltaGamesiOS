platform :ios, '14.0'

target 'DeltaGames' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  
  # Pods for DeltaGames
  pod 'SwiftLint'
  pod 'SDWebImageSwiftUI'
  pod 'Alamofire'
  pod 'RealmSwift'

  target 'DeltaGamesTests' do
    inherit! :search_paths
  end

end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '14.0'
    end

    next unless target.name == 'Realm'

    target.shell_script_build_phases.each do |phase|
      next unless phase.name == 'Create Symlinks to Header Folders'

      phase.output_paths = ['$(DERIVED_FILE_DIR)/realm-symlink-phase-output.txt']
      unless phase.shell_script.include?('realm-symlink-phase-output.txt')
        phase.shell_script = <<~SCRIPT
          #{phase.shell_script}

          echo "SUCCESS" > "${SCRIPT_OUTPUT_FILE_0}"
        SCRIPT
      end
    end
  end
end
