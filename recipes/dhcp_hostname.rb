#
# Cookbook Name:: raspbian
# Recipe:: dhcp_hostname
#
# Copyright 2015, Urbandecoder Labs LLC
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

# Source: http://blog.schlomo.schapiro.org/2013/11/setting-hostname-from-dhcp-in-debian.html
if node['raspbian']['set_hostname_from_dhcp']
  file '/etc/hostname' do
    content "localhost\n"
    owner 'root'
    group node['root_group']
    mode '0644'
  end

  file '/etc/dhcp/dhclient-enter-hooks.d/unset_old_hostname' do
    content "unset old_host_name\n"
    owner 'root'
    group node['root_group']
    mode '0644'
  end
else
  file '/etc/dhcp/dhclient-enter-hooks.d/unset_old_hostname' do
    action :delete
  end
end
