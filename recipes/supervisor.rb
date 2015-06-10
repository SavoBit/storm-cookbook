# Encoding: utf-8
#
# Cookbook Name:: storm
# Recipe:: supervisor
#

include_recipe "storm"

node.set[:storm][:supervisor][:is_supervisor_host] = true

include_recipe 'storm::config'

storm_dir = node[:storm][:deploy][:storm_dir]

template "/etc/init/storm-supervisor.conf" do
  source "storm-upstart-conf.erb"
  variables({
    :storm_user => node.storm.deploy.user,
    :storm_home => "#{storm_dir}/apache-storm-#{node.storm.version}",
    :storm_service => "supervisor"
  })
  notifies :run, "execute[reload upstart configuration]", :immediately
end

include_recipe 'storm::config'


service "storm-supervisor" do
  provider Chef::Provider::Service::Upstart
  action [:enable, :start]
end

logrotate_app "storm-supervisor" do
  frequency "daily"
  cookbook "logrotate"
  path "#{node[:storm][:deploy][:log_dir]}/supervisor.log"
  rotate 30
  create "640 #{node.storm.deploy.user} #{node.storm.deploy.user}"
end
