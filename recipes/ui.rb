# Encoding: utf-8
#
# Cookbook Name:: storm
# Recipe:: ui
#

include_recipe "storm"

node.set[:storm][:ui][:is_ui_host] = true

# Creates storm.yaml and bin_storm.py using attributes
include_recipe 'storm::config'

template "/etc/init/storm-ui.conf" do
  source "storm-upstart-conf.erb"
  variables({
    :storm_user => node.storm.deploy.user,
    :storm_home => "#{node[:storm][:deploy][:storm_dir]}/apache-storm-#{node.storm.version}",
    :storm_service => "ui"
  })
  notifies :run, "execute[reload upstart configuration]", :immediately
end

service "storm-ui" do
  provider Chef::Provider::Service::Upstart
  action [:enable, :start]
end

logrotate_app "storm-ui" do
  frequency "daily"
  cookbook "logrotate"
  path "#{node[:storm][:deploy][:log_dir]}/ui.log"
  rotate 30
  create "640 #{node.storm.deploy.user} #{node.storm.deploy.user}"
end
