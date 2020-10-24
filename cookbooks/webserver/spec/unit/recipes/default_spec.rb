#
# Cookbook Name:: webserver
# Spec:: default
#
# Copyright (c) 2020 The Authors, All Rights Reserved.

require 'spec_helper'

describe 'webserver::default' do
  context 'When all attributes are default, on an unspecified platform' do
    let(:chef_run) do
      runner = ChefSpec::ServerRunner.new
      runner.converge(described_recipe)
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end

    it 'Install httpd package' do
      expect (chef_run).to install_package('httpd')
    end

    it 'create the index.html file' do
      expect (chef_run).to create_template('/var/www/html/index.html')
    end

    it 'http service started' do
      expect (chef_run).to start_service('httpd')
    end

    it 'http service enabled' do
      expect (chef_run).to enable_service('httpd')
    end
  end
end
