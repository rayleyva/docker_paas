zk_leader="unknown"
search(:node, "recipes:*nfs_leader AND chef_environment:#{node.chef_environment}").each do |node| 
  zk_leader=node['ipaddress']
end

if zk_leader.eql? "unknown"
  raise "Ruh roh, you're using the NFS follower recipe but we couldn't find a NFS leader."
end

directory  node[:exhibitor][:opts][:fsconfigdir] do
  owner node[:zookeeper][:user]
  action :create
  recursive true
  mode 0755
end

mount node[:exhibitor][:opts][:fsconfigdir] do
    device "#{zk_leader}:#{node[:exhibitor][:opts][:fsconfigdir]}"
    fstype "nfs"
    options "rw"
end
