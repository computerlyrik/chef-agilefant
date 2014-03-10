#
# Cookbook Name:: agilefant
# Recipe:: default
#
# Copyright 2014, computerlyrik
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

include_recipe 'mysql::server'
include_recipe 'database::mysql'
mysql_connection_info = {
  host: 'localhost',
  username: 'root',
  password: node['mysql']['server_root_password']
}

node.set_unless['agilefant']['mysql_password'] = secure_password

mysql_database_user node['agilefant']['mysql_user'] do
  password node['agilefant']['mysql_password']
  database_name node['agilefant']['mysql_user']
  connection mysql_connection_info
  action [:create, :grant]
end

mysql_database node['agilefant']['mysql_user'] do
  connection mysql_connection_info
  action :create
end

application 'jenkins' do
  path         '/usr/local/jenkins'
  owner        node['tomcat']['user']
  group        node['tomcat']['group']
  repository   'https://github.com/Agilefant/agilefant.git'
  scm_provider Chef::Provider::Git
  java_webapp do
    migration_command 'mvn packge'
    database do
      driver     'org.gjt.mm.mysql.Driver'
      database   'agilefant'
#      port       5678
      username   node['agilefant']['mysql_user']
      password   node['agilefant']['mysql_password']
      max_active 1
      max_idle   2
      max_wait   3
    end
#    context_template 'jenkins-context.xml.erb'
  end

  tomcat
end
