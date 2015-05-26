# Encoding: utf-8
#
# Cookbook Name:: storm
# Recipe:: default
#

storm_dir = node[:storm][:deploy][:storm_dir]

Chef::Application.fatal!("node[:storm][:zookeeper][:hosts] is not set by search or override") unless node[:storm][:zookeeper][:hosts]
Chef::Application.fatal!("node[:storm][:nimbus][:hosts] is not set by search or override") unless node[:storm][:nimbus][:hosts]
Chef::Application.fatal!("node[:storm][:supervisor][:hosts] is not set by search or override") unless node[:storm][:supervisor][:hosts]


%w[ curl unzip build-essential pkg-config libtool autoconf git-core uuid-dev python-dev ].each do |pkg|
    package pkg do
        retries 2
        action :install
    end
end

directory node[:storm][:deploy][:storm_dir] do
  owner node.storm.deploy.user
  group node.storm.deploy.user
  recursive true
  action :create
end


bash "Storm install" do
  user node[:storm][:deploy][:user]
  cwd storm_dir
  code <<-EOH
  mkdir storm-data || true
  wget #{node[:storm][:zip_url]}
  unzip apache-storm-#{node[:storm][:version]}.zip
  cd apache-storm-#{node[:storm][:version]}
  EOH
  not_if do
    ::File.exists?("#{storm_dir}/apache-storm-#{node[:storm][:version]}")
  end
end

execute "reload upstart configuration" do
  command "initctl reload-configuration"
  action :nothing
end

directory node[:storm][:deploy][:log_dir] do
  owner node.storm.deploy.user
  group node.storm.deploy.user
  recursive true
end
