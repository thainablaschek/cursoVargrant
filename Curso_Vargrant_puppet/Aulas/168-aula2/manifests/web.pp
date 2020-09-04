exec { "apt-update":
  command => "/usr/bin/apt-get update"
}
exec { "musicjungle":
    command => "mysqladmin -uroot create musicjungle",
    unless => "myslq -u root musicjungle"
    path => "/usr/bin",
    require => Service["mysql"]
}

package { ["openjdk-7-jre", "tomcat7", "mysql-server"]:
    ensure => installed,
    require => Exec["apt-update"]
}

service { "mysql":
    ensure => running,
    enable => true,
    hasstatus => true,
    hasrestart => true,
    require => Package["mysql-server"]
}


service { "tomcat7":
    ensure => running,
    enable => true,
    hasstatus => true,
    hasrestart => true,
    require => Package["tomcat7"]
}

file { "/var/lib/tomcat7/webapps/vraptor-musicjungle.war":
    source => "/168-aula2/manifests/vraptor-musicjungle.war",
    owner => "tomcat7",
    group => "tomcat7",
    mode => 0644,
    require => Package["tomcat7"],
    notify => Service["tomcat7"]
}



