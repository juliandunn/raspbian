#
# Cookbook Name:: raspbian
# Recipe:: ipv6
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

if node['raspbian']['enable_ipv6']
  append_if_no_line 'enable ipv6 in modules' do
    path '/etc/modules'
    line 'ipv6'
  end

  execute 'enable ipv6' do
    command '/sbin/modprobe ipv6'
    not_if '/sbin/lsmod | grep ipv6'
  end
else
  execute 'disable ipv6' do
    command '/sbin/modprobe -r ipv6'
    only_if '/sbin/lsmod | grep ipv6'
  end

  delete_lines 'disable ipv6 in modules' do
    path '/etc/modules'
    pattern '^#ipv6'
  end
end
