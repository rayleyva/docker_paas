template "/usr/local/bin/gitreceive" do
  mode 0755
end

execute "init receive_user" do
  command "/usr/local/bin/gitreceive init"
  not_if "id git"
end

template "/home/git/receiver" do
  source "paas_hook.erb"
  owner "git"
end
