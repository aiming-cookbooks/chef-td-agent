name             "td-agent"
maintainer       "Treasure Data, Inc."
maintainer_email "k@treasure-data.com"
license          "All rights reserved"
description      "Installs/Configures td-agent"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.rdoc'))
version          "0.0.7"
recipe           "td-agent", "td-agent configuration"
recipe           "td-agent::specific_install", "install specific_install"

%w{redhat centos debian ubuntu}.each do |os|
  supports os
end

depends 'apt'
depends 'yum'

attribute "td_agent/api_key",
  :display_name => "Treasure Data ApiKey",
  :description => "ApiKey for Treasure Data Service",
  :default => ''
