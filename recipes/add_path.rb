#
# Cookbook Name:: td-agent
# Recipe:: add_path
#
# Copyright 2013, Aiming Inc.
#

if node.default[:td_agent][:ruby][:add_path] 
  template "/etc/profile.d/fluent_ruby_path.sh" do
    source "fluent_ruby_path.sh.erb"
    mode   0755
  end
end
