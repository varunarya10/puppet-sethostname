Facter.add("hostname_from_dns") do
    setcode do
	ip_eth = (Facter.value(:ipaddress_eth2) || Facter.value(:ipaddress_eth3)) || ( Facter.value(:ipaddress_eth0) || Facter.value(:ipaddress_vhost0)) || Facter.value(:ipaddress_br0)
# || Facter.value(:ipaddress_eth0)
	current_hostname = Facter.value(:hostname)
#	Facter::Util::Resolution.exec("host  #{ip_eth0}").chomp
	Facter::Util::Resolution.exec("host #{ip_eth}").sub(/.*pointer/,'').gsub(/(\w)[BFbf]*\..*/,'\1').sub(/\w+-(\w)/,'\1').gsub(/\s/,'').sub(/.*addr.arpa.notfound.*/,"#{current_hostname}").sub(/.*connectiontimedout.*/,"#{current_hostname}").chomp
    end
end

Facter.add("dnsname_from_dns") do
    setcode do
#	ip_eth = (Facter.value(:ipaddress_eth2) || Facter.value(:ipaddress_eth3)) || Facter.value(:ipaddress_eth0)
	ip_eth = (Facter.value(:ipaddress_eth2) || Facter.value(:ipaddress_eth3)) || ( Facter.value(:ipaddress_eth0) || Facter.value(:ipaddress_vhost0)) || Facter.value(:ipaddress_br0)
# || Facter.value(:ipaddress_eth0)
	current_hostname = Facter.value(:hostname)
#	Facter::Util::Resolution.exec("host  #{ip_eth0}").chomp
	Facter::Util::Resolution.exec("host #{ip_eth}").sub(/.*pointer/,'').gsub(/(\w)[BFbf]*\..*/,'\1').gsub(/\s/,'').sub(/.*addr.arpa.notfound.*/,"#{current_hostname}").sub(/.*connectiontimedout.*/,"#{current_hostname}").chomp
    end
end
