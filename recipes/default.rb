#
# Cookbook Name:: td-agent
# Recipe:: default
#
# Copyright 2011, Treasure Data, Inc.
#

td = node.default[:td_agent]

group td[:group] do
  group_name td[:group]
  gid        403
  action     [:create]
end

user td[:user] do
  comment  'td-agent'
  uid      403
  group    td[:group]
  home     td[:home]
  shell    '/bin/false'
  password nil
  supports :manage_home => true
  action   [:create, :manage]
end

directory td[:directory] do
  owner  td[:owner]
  group  td[:group]
  mode   '0755'
  action :create
end

directory "#{td[:directory]}out" do
  owner  td[:owner]
  group  td[:group]
  mode   '0755'
  action :create
end

directory "#{td[:directory]}input" do
  owner  td[:owner]
  group  td[:group]
  mode   '0755'
  action :create
end

case node['platform']
when "ubuntu"
  dist = node['lsb']['codename']
  source = (dist == 'precise') ? td[:package][:ubuntu] : td[:package][:debian]
  apt_repository "treasure-data" do
    uri source
    distribution dist
    components ["contrib"]
    action :add
  end
when "centos", "redhat"
  yum_repository "treasure-data" do
    url td[:package][:rhel]
    action :add
  end
end

if td[:template][:input][:forward]
  template "#{td[:directory]}input/forward.conf" do
    mode   0644
    source "input/forward.conf.erb"
  end
end

if td[:template][:input][:unix]
  template "#{td[:directory]}input/unix.conf" do
    mode   0644
    source "input/unix.conf.erb"
  end
end

if td[:template][:input][:http]
  template "#{td[:directory]}input/http.conf" do
    mode   0644
    source "input/http.conf.erb"
  end
end

if td[:template][:input][:debug_agent]
  template "#{td[:directory]}input/debug-agent.conf" do
    mode   0644
    source "input/debug-agent.conf.erb"
  end
end

if td[:template][:output][:tdlog]
  template "#{td[:directory]}out/tdlog.conf" do
    mode   0644
    source "out/tdlog.conf.erb"
  end
end

if td[:template][:output][:debug]
  template "#{td[:directory]}out/debug.conf" do
    mode   0644
    source "out/debug.conf.erb"
  end
end

template td[:config] do
  mode "0644"
  source "td-agent.conf.erb"
end

package "td-agent" do
  options value_for_platform(
    ["ubuntu", "debian"] => {"default" => "-f --force-yes"},
    "default" => nil
  )
  action :upgrade
end

service "td-agent" do
  action [ :enable, :start ]
  supports status: true, restart: true, reload: true
  subscribes :restart, resources(:template => td[:config])
end

node[:td_agent][:plugins].each do |plugin|
  if plugin.is_a?(Hash)
    plugin_name, plugin_attributes = plugin.first
    td_agent_gem plugin_name do
      plugin true
      %w{action version source options gem_binary}.each do |attr|
        send(attr, plugin_attributes[attr]) if plugin_attributes[attr]
      end
    end
  elsif plugin.is_a?(String)
    td_agent_gem plugin do
      plugin true
    end
  end
end

include_recipe "td-agent::specific_install"
include_recipe "td-agent::add_path"
