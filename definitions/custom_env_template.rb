# Accepts:
#   application (application name)
#   deploy (hash of deploy attributes)
#   env (hash of custom environment settings)
# 
# Notifies a "restart Rails app <name>" resource.

define :custom_env_template do
  Chef::Log.debug("Creating custom env template definition with: #{params.inspect}")
  
  application = params[:app]
  deploy = params[:deploy_data]

  template "#{deploy[:deploy_to]}/shared/config/.env.#{deploy[:rails_env]}" do
    source ".env.erb"
    owner params[:deploy][:user]
    group params[:deploy][:group]
    mode "0660"
    variables :env => params[:env]
    notifies :run, resources(:execute => "restart Rails app #{params[:application]}")

    only_if { File.exists?("#{deploy[:deploy_to]}/shared/config") }
  end

end
