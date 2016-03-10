storm_dir = node[:storm][:deploy][:storm_dir]

template "#{storm_dir}/apache-storm-#{node.storm.version}/log4j2/worker.xml" do
  source "worker.xml.erb"
  variables({
    :logstash_host => node.storm.logstash_host,
    :logstash_port => node.storm.logstash_port
  })
  notifies :run, "execute[reload upstart configuration]", :immediately
end


template "#{storm_dir}/apache-storm-#{node.storm.version}/log4j2/cluster.xml" do
  source "cluster.xml.erb"
  variables({
              :logstash_host => node.storm.logstash_host,
              :logstash_port => node.storm.logstash_port
            })
  notifies :run, "execute[reload upstart configuration]", :immediately
end
