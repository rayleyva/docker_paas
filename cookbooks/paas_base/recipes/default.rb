#
# Cookbook Name:: paas_base
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
execute "apt'd" do
  command "apt-get update -q && touch /var/tmp/updated"
  not_if "test -f /var/tmp/updated"
  only_if "which apt-get"
end

#know thyself
hostsfile_entry node["ipaddress"] do
  hostname "#{node.name}.#{node['domain']}"
  aliases [node.name]
  action :create
end

execute "dumb" do
  command "hostname #{node.name}"
  only_if "test `hostname` != node.name"
end

hosts = search(:node, "chef_environment:#{node.chef_environment}")
hosts.each do |host|
  unless host["ipaddress"].nil? 
  hostsfile_entry host["ipaddress"] do
    hostname "#{host.name}.#{node['domain']}"
    aliases [host.name]
    action :create
  end
  end
end


package "git"
