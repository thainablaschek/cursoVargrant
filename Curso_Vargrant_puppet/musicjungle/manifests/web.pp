exec { "apt-update":
  command => "/usr/bin/apt-get update"
}

package { ["openjdk-7-jre", "tomcat7"]:
    ensure => installed,
    require => Exec["apt-update"]
}

service{"tomcat7"
  ensure => running,
  enable => true,
  hasstatus => true, 
  hasrestart => true,
  require => package["tomcat7"]
}

file{ "/var/lib/tomcat7/webapps/vraptor-musicjungle.war":
  source => "home/thaina/Documentos/Curso_Vargrant_puppet/musicjungle/vraptor-musicjungle.war",
  owner => tomcat7,
  group => tomcat7.
  mode => 0644,
  require => package["tomcat7"],
  notify => service["tomcat7"]
}