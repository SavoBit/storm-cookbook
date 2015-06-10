# Encoding: utf-8
#
# Cookbook Name:: storm
# Recipe:: drpc
#

include_recipe "storm"

storm_dir = node[:storm][:deploy][:storm_dir]

template "/etc/init/storm-drpc.conf" do
  source "storm-upstart-conf.erb"
  variables({
    :storm_user => node.storm.deploy.user,
    :storm_home => "#{storm_dir}/apache-storm-#{node.storm.version}",
    :storm_service => "drpc"
  })
  notifies :run, "execute[reload upstart configuration]", :immediately
end

service "storm-drpc" do
  provider Chef::Provider::Service::Upstart
  action [:enable, :start]
end

logrotate_app "storm-drpc" do
  frequency "daily"
  cookbook "logrotate"
  path "#{node[:storm][:deploy][:log_dir]}/drpc.log"
  rotate 30
  create "640 #{node.storm.deploy.user} #{node.storm.deploy.user}"
end
