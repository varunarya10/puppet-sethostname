class sethostname (
	$domain_name = "mu.jio"
) {
    $nic = 'eth1'
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
update add ${hostname_from_dns}.${domain_name} 86400 IN CNAME ${dnsname_from_dns}.${domain_name}
send
EOF
",
    path   => "/usr/bin:/usr/sbin:/bin",
    unless => "host ${hostname_from_dns}.${domain_name}",
  }
}
