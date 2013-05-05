# Accepts:
#   application (application name)
#   deploy (hash of deploy attributes)
#   env (hash of custom environment settings)
# 
# Notifies a "restart Rails app <name>" resource.

define :custom_env_template do
  
  template "#{params[:deploy][:current_path]}/.env.#{params[:deploy][:rails_env]}" do
    source ".env.yml.erb"
    owner params[:deploy][:user]
    group params[:deploy][:group]
    mode "0660"
    variables :env => params[:env]
    notifies :run, resources(:execute => "restart Rails app #{params[:application]}")

    only_if { File.exists?("#{params[:deploy][:current_path]}") }
  end
  
end
