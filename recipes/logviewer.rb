storm_dir = node[:storm][:deploy][:storm_dir]

template "/etc/init/storm-logviewer.conf" do
  source "storm-upstart-conf.erb"
  variables({
    :storm_user => node.storm.deploy.user,
    :storm_home => "#{storm_dir}/apache-storm-#{node.storm.version}",
    :storm_service => "logviewer"
  })
  notifies :run, "execute[reload upstart configuration]", :immediately
end

service "storm-logviewer" do
  provider Chef::Provider::Service::Upstart
  action [:enable, :start]
end

