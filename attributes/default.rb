# Encoding: utf-8
#
# Cookbook Name:: storm
# Attribute:: default
#
#

default[:storm][:version] = "0.9.3"
default[:storm][:zip_url] = "http://apache.mirror.iweb.ca/storm/apache-storm-#{node[:storm][:version]}/apache-storm-#{node[:storm][:version]}.zip"

default[:storm][:deploy][:user] = ::File.exists?("/home/vagrant") ? "vagrant" : "ubuntu"
default[:storm][:deploy][:group] = ::File.exists?("/home/vagrant") ? "vagrant" : "ubuntu"
default[:storm][:deploy][:storm_dir] = "/opt/storm"
default[:storm][:deploy][:log_dir] = "/var/log/storm"

default[:storm][:nimbus][:host] = "192.168.42.10"
default[:storm][:nimbus][:childopts] = "-Xmx512m -Djava.net.preferIPv4Stack=true"

default[:storm][:supervisor][:hosts] = [ "192.168.42.20" ]
default[:storm][:supervisor][:childopts] = "-Xmx512m -Djava.net.preferIPv4Stack=true"
default[:storm][:supervisor][:workerports] = (6700..6706).to_a

default[:storm][:worker][:childopts] = "-Xmx512m -Djava.net.preferIPv4Stack=true"

default[:storm][:ui][:childopts] = "-Xmx512m -Djava.net.preferIPv4Stack=true"

default[:storm][:java][:library_path] = "/usr/local/lib"
