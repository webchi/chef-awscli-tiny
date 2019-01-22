#
# Cookbook:: awscli-tiny
# Recipe:: default
#
# Copyright:: 2019, The Authors, All Rights Reserved.

uname = node['awscli']['user']
home_dir = '/home/' + uname

python_runtime '2' do
    provider :system
    pip_version false
    setuptools_version false
    virtualenv_version false
    wheel_version false
end

remote_file "#{home_dir}/get-pip.py" do
    source 'https://bootstrap.pypa.io/get-pip.py'
    owner uname
    group uname
    mode '0755'
end

execute 'install pip' do
    command "sudo -u #{uname} -H sh -c 'python #{home_dir}/get-pip.py --user'"
    not_if "test -e #{home_dir}/.local/bin/pip"
end

execute 'add bashrc' do
    user uname
    command "sudo -u #{uname} -H sh -c 'touch #{home_dir}/.bashrc'"
    not_if "test -e #{home_dir}/.bashrc"
end

execute 'add local path' do
    user uname
    command "sudo -u #{uname} -H sh -c 'echo export PATH=#{home_dir}/.local/bin:$PATH' >> #{home_dir}/.bashrc"
    not_if "cat #{home_dir}/.bashrc | grep 'export PATH=~/.local/bin:$PATH'"
end

execute 'install aws' do
    command "sudo -u #{uname} -H sh -c '#{home_dir}/.local/bin/pip install awscli --upgrade --user'"
    not_if "test -e #{home_dir}/.local/bin/aws"
end

directory "#{home_dir}/.aws" do
    owner uname
    group uname
    mode '0755'
    action :create
end

template "#{home_dir}/.aws/config" do
    source "config.erb"
    owner uname
    group uname
    mode '0600'
end

template "#{home_dir}/.aws/credentials" do
    source "credentials.erb"
    owner uname
    group uname
    mode '0600'
end