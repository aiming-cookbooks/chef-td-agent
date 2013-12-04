# -*- coding:utf-8 -*-

require 'serverspec'
require 'pathname'

include Serverspec::Helper::Exec
include Serverspec::Helper::DetectOS

RSpec.configure do |c|
  c.before :all do
    c.os = backend(Serverspec::Commands::Base).check_os
    c.path = '/sbin:/usr/bin'
  end
end

describe "td-agent daemon" do
  it "has a running service of td-agent" do
    expect(service("td-agent")).to be_running
  end
end
