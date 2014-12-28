# Encoding: utf-8
#
# Cookbook Name:: storm
# Recipe:: config
#

storm_dir = node[:storm][:deploy][:storm_dir]

template "Storm conf file" do
  path "#{storm_dir}/apache-storm-#{node[:storm][:version]}/conf/storm.yaml"
  source "storm.yaml.erb"
  owner node[:storm][:deploy][:user]
  group node[:storm][:deploy][:group]
  mode 0644
end

template "#{storm_dir}/apache-storm-#{node.storm.version}/bin/storm" do
  source "bin_storm.py.erb"
  owner node[:storm][:deploy][:user]
  group node[:storm][:deploy][:group]
  mode 0755
end
