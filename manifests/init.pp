class sethostname (
	$domain_name,
	$dns_master_server,
	$dnsupdate_key
) {
  $nic = 'eth1'
  $hgs_to_use_fe_for_connectivity	= ['storage_node','database_node','contrail_node','cobbler_node','repo_node']
#  $hgs_to_use_fe_for_connectivity=

  if $hostgroup_from_dns in $hgs_to_use_fe_for_connectivity {
	$dns_host_name_part =  regsubst($dnsname_from_dns,'^(\w\w\d\d\d\d)(\w)(-.*)','\1f\3','I')
  } else {
	$dns_host_name_part =  regsubst($dnsname_from_dns,'^(\w\w\d\d\d\d)(\w)(-.*)','\1b\3','I')
  }
    file { "/etc/hosts":
	ensure => present,
        owner => root,
        group => root,
        mode => 644,
	content => template("sethostname/hosts.erb"),
    	notify => File["/etc/hostname"],
}

    file { "/etc/hostname":
   	ensure => present,
    	owner => root,
    	group => root,
    	mode => 644,
    	content => "${::hostname_from_dns}\n",
    }
->
  exec { "set-hostname":
    command => "/bin/hostname -F /etc/hostname",
    path   => "/usr/bin:/usr/sbin:/bin",
    unless => "test $hostname  = `cat /etc/hostname`",
  }

  exec { "set-dns-cname":
    command => "nsupdate <<EOF
server $dns_master_server
key dhcpupdate $dnsupdate_key
zone $domain_name
update add ${hostname_from_dns}.${domain_name} 86400 IN CNAME ${dns_host_name_part}.${domain_name}
send
EOF
",
    path   => "/usr/bin:/usr/sbin:/bin",
    unless => "host ${hostname_from_dns}.${domain_name}",
  }
}
