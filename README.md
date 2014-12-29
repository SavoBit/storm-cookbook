# Storm Chef Cookbook

This cookbook has been forked from [hmalphettes/storm-project-cookbook](https://github.com/hmalphettes/storm-project-cookbook) and a first pass of modifications have been made to support any Storm version
(0.9.1-incubating by default), added recipe for a single node cluster deployment, a recipe for a UI node
and added/cleaned some options. I am using this cookbook with Chef Solo and Vagrant.
Lots of modifications are still required to put this cookbook in better shape.

This cookbook will install the following:
- Storm 0.9.3 by default but configurable
- logrotate

# Requirement

- Ubuntu Linux
- Java 1.7 need to be installed. I suggest this [Java cookbook](git://github.com/opscode-cookbooks/java.git)
- Zookeeper Cluster

# Recipes

- storm::singlenode
- storm::nimbus
- storm::supervisor
- storm::ui
- storm::drpc
- storm::config

The `storm::singlenode` recipe installs nimbus, supervisor, drpc and ui on the same node.

# Default options

You must override or set the following in some manner such as in a
role, wrapper / application cookbook before running any recipe other
than storm::singlenode:

* Array of zookeeper FQDN or IP addresses  
  `default[:storm][:zookeeper][:hosts]`
* Single FQDN or IP of nimbus host  
  `default[:storm][:nimbus][:host]`
* Array of supervisor FQDN or IP addresses  
  `default[:storm][:supervisor][:hosts]`


See attributes/default.rb for other attributes that can be set

# Example Vagranfile

Complete [Vagrantfile](https://github.com/colinsurprenant/redstorm/blob/v0.6.5/vagrant/Vagrantfile)

```
chef.add_recipe "java"
chef.add_recipe "storm::singlenode"

chef.json = {
  :java => {
    :oracle => {
      "accept_oracle_download_terms" => true
    },
    :install_flavor => "oracle",
    :jdk_version => "7",
  },

  :storm => {
    :deploy => {
      :user => "storm",
      :group => "storm",
    },
    :nimbus => {
      :host => "localhost",
      :childopts => "-Xmx128m",
    },
    :supervisor => {
      :hosts =>  ["localhost"],
      :childopts => "-Xmx128m",
    },
    :worker => {
      :childopts => "-Xmx128m",
    },
    :ui => {
      :childopts => "-Xmx128m",
    },
  },
}
```
