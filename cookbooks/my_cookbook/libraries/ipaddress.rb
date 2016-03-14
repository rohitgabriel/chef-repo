class Chef::Recipe
def self.netmask(ipaddress)
IPAddress(ipaddress).netmask
end
end


