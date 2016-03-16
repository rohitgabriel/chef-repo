=begin
case node['platform']
when 'debian', 'ubuntu'
  'apt-get -y install telnet'
when 'redhat', 'centos', 'fedora'
  'yum -y install telnet'
end


package "apache2" do
  case node[:platform]
  when "centos","redhat","fedora","suse"
    package_name "httpd"
  when "debian","ubuntu"
    package_name "apache2"
  when "arch"
    package_name "apache"
  end
  action :install
end
=end
=begin
execute 'unzip' do
  command value_for_platform(
"debian" => { "default" => "aptitude install unzip" },
"ubuntu" => { "default" => "apt-get install unzip" },
"rhel" => { "default" => "yum install unzip" }
)
  action :run
end


if platform?("debian", "ubuntu")
  # do something if node['platform'] is debian or ubuntu
else
  # do other stuff
end
=end

