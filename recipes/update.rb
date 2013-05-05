# Fast-apply an app's custom configuration.

if node[:opsworks][:instance][:layers].include?('rails-app')
  node[:deploy].each do |application, deploy|
  
    # It would be nice to skip when the app's application_type isn't "rails,"
    # but that isn't supplied in the JSON when executing individual recipes.
    
    execute "restart Rails app #{application}" do
      cwd deploy[:current_path]
      command "cd #{deploy[:deploy_to]} && #{node[:opsworks][:rails_stack][:restart_command]}"
      action :nothing
    end
    
    custom_env_template do
      application application
      deploy deploy
      env node[:custom_env][application]
    end
    
  end
end
