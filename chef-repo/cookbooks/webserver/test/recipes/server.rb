# # encoding: utf-8

# Inspec test for recipe webserver::server

# The Inspec reference, with examples and extensive documentation, can be
# found at https://docs.chef.io/inspec_reference.html

describe service('httpd') do
  it { should be_installed }
  it { should be_running }
  it { should be_enabled }
end

describe port(80) do
  it { should be_listening }
end