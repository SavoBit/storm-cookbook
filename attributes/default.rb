# Encoding: utf-8
#
# Cookbook Name:: storm
# Attribute:: default
#
#

default[:storm][:version] = "0.9.5"
default[:storm][:zip_url] = "http://mirrors.advancedhosters.com/storm/apache-storm-#{node[:storm][:version]}/apache-storm-#{node[:storm][:version]}.zip"

default[:storm][:deploy][:user] = ::File.exists?("/home/vagrant") ? "vagrant" : "ubuntu"
default[:storm][:deploy][:group] = ::File.exists?("/home/vagrant") ? "vagrant" : "ubuntu"
default[:storm][:deploy][:storm_dir] = "/opt/storm"
default[:storm][:deploy][:local_dir] = "/opt/storm/storm-data"
default[:storm][:deploy][:log_dir] = "/var/log/storm"

#
# Set these somewhere before the default recipe is called 
# You can use search or statically set them in a wrapper/application reciepe
#
# Array of zookeeper FQDN or IP addresses
default[:storm][:zookeeper][:hosts] = nil 
# Single FQDN or IP of nimbus host
default[:storm][:nimbus][:host] = nil
# Array of supervisor FQDN or IP addresses
default[:storm][:supervisor][:hosts] = nil

default[:storm][:nimbus][:childopts] = "-Xmx512m -Djava.net.preferIPv4Stack=true"
default[:storm][:nimubs][:topology][:debug] = true
default[:storm][:nimbus][:task][:launch][:secs] = 240
default[:storm][:supervisor][:worker][:start][:timeout][:secs] = 240
default[:storm][:supervisor][:worker][:timeout][:secs] = 240

default[:storm][:supervisor][:childopts] = "-Xmx512m -Djava.net.preferIPv4Stack=true"
default[:storm][:supervisor][:workerports] = (6700..6713).to_a

default[:storm][:worker][:childopts] = "-Xmx512m -Djava.net.preferIPv4Stack=true"

default[:storm][:ui][:childopts] = "-Xmx512m -Djava.net.preferIPv4Stack=true"

default[:storm][:java][:library_path] = "/usr/local/lib"
