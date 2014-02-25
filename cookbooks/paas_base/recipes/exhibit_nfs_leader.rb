directory  node[:exhibitor][:opts][:fsconfigdir] do
  owner node[:zookeeper][:user]
  action :create
  recursive true
  mode 0755
end

nfs_export node[:exhibitor][:opts][:fsconfigdir] do
    network '10.0.0.0/8'
    writeable true
    sync true
    options ['no_root_squash']
end
