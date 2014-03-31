#Facter.add("hostgroup_from_dns") do
#    setcode do
#	#ip_eth = (Facter.value(:ipaddress_eth2) || Facter.value(:ipaddress_eth3)) || Facter.value(:ipaddress_eth0)
#	ip_eth = (Facter.value(:ipaddress_eth2) || Facter.value(:ipaddress_eth3)) || ( Facter.value(:ipaddress_eth0) || Facter.value(:ipaddress_vhost0)) || Facter.value(:ipaddress_br0)
# || Facter.value(:ipaddress_eth0)
#	current_hostname = Facter.value(:hostname)
#	Facter::Util::Resolution.exec("host  #{ip_eth}").chomp
	#Facter::Util::Resolution.exec("host #{ip_eth}").sub(/.*pointer/,'').gsub(/(\w)[BFbf]*\..*/,'\1').sub(/\w+-(\w)/,'\1').gsub(/\s/,'').sub(/.*addr.arpa.notfound.*/,"#{current_hostname}").sub(/.*connectiontimedout.*/,"#{current_hostname}").sub(/^oc\d+$/,"Openstack Controller").sub(/^st\d+$/,"Storage Node").sub(/^cp\d+$/,"Openstack Compute Node").sub(/^db\d+$/,"Database Node").sub(/^ct\d+$/,"Contrail Node").sub(/^z\d+/,"Zabbix Node").sub(/^i\d+/,"Infra Node").sub(/^cblr\d*/,"Cobbler Node").sub(/^repo\d*/,"Repo Node").chomp
#	Facter::Util::Resolution.exec("host #{ip_eth}").sub(/.*pointer/,'').gsub(/(\w)[BFbf]*\..*/,'\1').sub(/\w+-(\w)/,'\1').gsub(/\s/,'').sub(/.*addr.arpa.notfound.*/,"#{current_hostname}").sub(/.*connectiontimedout.*/,"#{current_hostname}").sub(/^oc\d+$/,"os_controller_node").sub(/^st\d+$/,"storage_node").sub(/^cp\d+$/,"os_compute_node").sub(/^db\d+$/,"database_node").sub(/^ct\d+$/,"contrail_node").sub(/^z\d+/,"zabbix_node").sub(/^i\d+/,"infra_node").sub(/^cblr\d*/,"cobbler_node").sub(/^repo\d*/,"repo_node").chomp
	#Facter::Util::Resolution.exec("echo hello").chomp
#    end
#end

