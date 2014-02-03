class sethostname {
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

}
