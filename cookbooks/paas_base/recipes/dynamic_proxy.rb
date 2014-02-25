package "ruby"
package "rubygems"
gem "json"

template "/usr/local/bin/dynamic_proxy.sh" do
  mode 0755
end

include_recipe "haproxy"

cron "ghetto_proxy" do
command "/usr/local/bin/dynamic_proxy.sh > /etc/haproxy/haproxy.cfg.new ; cmp /etc/haproxy/haproxy.cfg.new /etc/haproxy/haproxy.cfg || (mv /etc/haproxy/haproxy.cfg.new /etc/haproxy/haproxy.cfg; service haproxy reload)"
end

