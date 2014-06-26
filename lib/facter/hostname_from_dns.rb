ip_eth = Facter.value(:default_gw_ip)
current_hostname = Facter.value(:hostname)
Facter.add("hostname_from_dns") do
    setcode do
	Facter::Util::Resolution.exec("host #{ip_eth}").sub(/.*pointer/,'').gsub(/(\w)[BFbf]*\..*/,'\1').sub(/\w+-(\w)/,'\1').gsub(/\s/,'').sub(/.*addr.arpa.notfound.*/,"#{current_hostname}").sub(/.*connectiontimedout.*/,"#{current_hostname}").chomp
    end
end

Facter.add("dnsname_from_dns") do
    setcode do
	Facter::Util::Resolution.exec("host #{ip_eth}").sub(/.*pointer/,'').gsub(/(\w)[BFbf]*\..*/,'\1').gsub(/\s/,'').sub(/.*addr.arpa.notfound.*/,"notfound").sub(/.*connectiontimedout.*/,"notfound").chomp
    end
end
