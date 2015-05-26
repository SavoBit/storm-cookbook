# Encoding: utf-8
#
# Cookbook Name:: storm
# Recipe:: singlenode
#

include_recipe "storm"

storm_dir = node[:storm][:deploy][:storm_dir]

directory node[:storm][:deploy][:storm_dir] do
  owner node.storm.deploy.user
  group node.storm.deploy.user
  recursive true
  action :create
end


template "Storm conf file" do
  path "#{storm_dir}/apache-storm-#{node[:storm][:version]}/conf/storm.yaml"
  source "singlenode.yaml.erb"
  owner node[:storm][:deploy][:user]
  group node[:storm][:deploy][:group]
  mode 0644
end

bash "Start nimbus" do
  user node[:storm][:deploy][:user]
  cwd storm_dir
  code <<-EOH
  pid=$(pgrep -f backtype.storm.daemon.nimbus)
  if [ -z $pid ]; then
    nohup apache-storm-#{node[:storm][:version]}/bin/storm nimbus >>nimbus.log 2>&1 &
  fi
  EOH
end

bash "Start supervisor" do
  user node[:storm][:deploy][:user]
  cwd storm_dir
  code <<-EOH
  pid=$(pgrep -f backtype.storm.daemon.supervisor)
  if [ -z $pid ]; then
    nohup apache-storm-#{node[:storm][:version]}/bin/storm supervisor >>supervisor.log 2>&1 &
  fi
  EOH
end

bash "Start DRPC" do
  user node[:storm][:deploy][:user]
  cwd storm_dir
  code <<-EOH
  pid=$(pgrep -f backtype.storm.daemon.drpc)
  if [ -z $pid ]; then
    nohup apache-storm-#{node[:storm][:version]}/bin/storm drpc >>drpc.log 2>&1 &
  fi
  EOH
end

bash "Start ui" do
  user node[:storm][:deploy][:user]
  cwd storm_dir
  code <<-EOH
  pid=$(pgrep -f backtype.storm.ui.core)
  if [ -z $pid ]; then
    nohup apache-storm-#{node[:storm][:version]}/bin/storm ui >>ui.log 2>&1 &
  fi
  EOH
end
