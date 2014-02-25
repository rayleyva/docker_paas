#need consistent uid
group node[:zookeeper][:group] do
  action :create
  gid 1500
end

user node[:zookeeper][:user] do
  gid node[:zookeeper][:group]
  uid 1500
end

group node[:marathon][:group] do
  action :create
  gid 1600
end

user node[:marathon][:user] do
  gid node[:marathon][:group]
  uid 1600
end


users_manage "admin" do
  action [ :create ]
end
