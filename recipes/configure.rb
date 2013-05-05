# Set up app's custom configuration in the environment.
# See https://forums.aws.amazon.com/thread.jspa?threadID=118107

include_recipe "rails::configure"

node[:deploy].each do |application, deploy|

  directory "#{deploy[:deploy_to]}/shared/config" do
    group deploy[:group]
    owner deploy[:user]
    mode 0775
    action :create
    recursive true
  end

  custom_env_template do
    application application
    deploy deploy
    env node[:custom_env][application]
  end

end
