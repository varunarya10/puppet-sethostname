# Class: sethostname
#
# This class configure hostname by refering reverse dns lookup. It also setup cname from long dns name to function based dns name
# Parameters:
# $domain_name: dns domain name
# $dns_master_server: dns master server address 
# $dnsupdate_key: secret key to update dns
# $update_dns: true or false to determine whether cname to be added to dns

class sethostname (
  $domain_name,
  $dns_master_server,
  $dnsupdate_key,
  $update_dns = false,      
) {

#    file { "/etc/hosts":
#	ensure => present,
#        owner => root,
#        group => root,
#        mode => 644,
#	content => template("sethostname/hosts.erb"),
#    	notify => File["/etc/hostname"],
#}

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

  if $dnsname_from_dns != 'notfound' {
    if $update_dns {
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
  }
}
