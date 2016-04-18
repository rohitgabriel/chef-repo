#
# Cookbook Name:: elk
# Recipe:: java

node.default['java']['install_flavor'] = 'oracle'
node.default['java']['jdk_version'] = '8'
node.default['java']['oracle']['accept_oracle_download_terms'] = true
node.default['java']['oracle_rpm']['type'] = 'jdk'
node.default['java']['oracle']['jce']['enabled'] = true
node.default['java']['java_home'] = '/usr/lib/jvm/java-8-oracle-amd64'

# Download from original oracle is way too slow, and tend to timeout
# Original Oracle JDK download link
# http://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html
# http://download.oracle.com/otn-pub/java/jdk/8u40-b26/jdk-8u40-linux-x64.tar.gz
# Cache jdk file of Oracle
node.default['java']['jdk']['8']['x86_64']['url'] = \
"http://#{node['elk']['repo_server']}/jdk-8u40-linux-x64.tar.gz"

# shasum -a 256 ./jdk-8u40-linux-x64.tar.gz
node.default['java']['jdk']['8']['x86_64']['checksum'] = \
'da1ad819ce7b7ec528264f831d88afaa5db34b7955e45422a7e380b1ead6b04d'

include_recipe 'java'

# symbol link /usr/bin/java
link '/usr/bin/java' do
  to '/usr/lib/jvm/java-8-oracle-amd64/bin/java'
end
