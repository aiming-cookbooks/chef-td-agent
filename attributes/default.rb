
# TD service settings
node.default[:td_agent][:api_key] = ''
node.default[:td_agent][:plugins] = []

# TD environment settings
node.default[:td_agent][:user]          = 'td-agent' 
node.default[:td_agent][:home]          = '/var/run/td-agent'
node.default[:td_agent][:owner]         = 'td-agent'
node.default[:td_agent][:group]         = 'td-agent'
node.default[:td_agent][:directory]     = '/etc/td-agent/'
node.default[:td_agent][:config]        = '/etc/td-agent/td-agent.conf'
node.default[:td_agent][:log_directory] = '/var/log/td-agent'

# TD package repository
node.default[:td_agent][:package][:ubuntu] = 'http://packages.treasure-data.com/precise/'
node.default[:td_agent][:package][:debian] = 'http://packages.treasure-data.com/debian/'
node.default[:td_agent][:package][:rhel]   = 'http://packages.treasure-data.com/redhat/$basearch'
