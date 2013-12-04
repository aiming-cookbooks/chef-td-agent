
# TD service settings
node.default[:td_agent][:api_key] = ''
node.default[:td_agent][:plugins] = []

# TD generate template
node.default[:td_agent][:template][:input][:forward]     = true
node.default[:td_agent][:template][:input][:unix]        = false
node.default[:td_agent][:template][:input][:http]        = true
node.default[:td_agent][:template][:input][:debug_agent] = true
node.default[:td_agent][:template][:output][:tdlog]      = true
node.default[:td_agent][:template][:output][:debug]      = true

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

# Add fluent ruby path into $PATH? (to /etc/profile)
node.default[:td_agent][:ruby][:add_path] = true

# fluent ruby path
node.default[:td_agent][:ruby][:rhel] = '/usr/lib64/fluent/ruby/bin'
node.default[:td_agent][:ruby][:debian] = '/usr/lib/fluent/ruby/bin'
