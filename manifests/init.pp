class indigo (
        $indigo_release                 = $indigo::params::indigo_release,
        $indigo_failovermethod          = $indigo::params::indigo_failovermethod,
        $indigo_priority                = $indigo::params::indigo_priority,
        $indigo_protect                 = $indigo::params::indigo_protect,
        $indigo_enabled                 = $indigo::params::indigo_enabled,
        $indigo_gpgcheck                = $indigo::params::indigo_gpgcheck,
        $indigo_gpgkey                  = $indigo::params::indigo_gpgkey,
        $indigo_updates_failovermethod  = $indigo::params::indigo_updates_failovermethod,
        $indigo_updates_priority        = $indigo::params::indigo_updates_priority,
        $indigo_updates_protect         = $indigo::params::indigo_updates_protect,
        $indigo_updates_enabled         = $indigo::params::indigo_updates_enabled,
        $indigo_updates_gpgcheck        = $indigo::params::indigo_updates_gpgcheck,
        $indigo_updates_gpgkey          = $indigo::params::indigo_updates_gpgkey,
        $indigo_3rdparty_failovermethod = $indigo::params::indigo_3rdparty_failovermethod,
        $indigo_3rdparty_priority       = $indigo::params::indigo_3rdparty_priority,
        $indigo_3rdparty_protect        = $indigo::params::indigo_3rdparty_protect,
        $indigo_3rdparty_enabled        = $indigo::params::indigo_3rdparty_enabled,
        $indigo_3rdparty_gpgcheck       = $indigo::params::indigo_3rdparty_gpgcheck,
        $indigo_3rdparty_gpgkey         = $indigo::params::indigo_3rdparty_gpgkey,
    ) inherits indigo::params {
    if "${::operatingsystem}" == "CentOS" and "${::operatingsystemmajrelease}" == "7" {
		yumrepo {
			"INDIGO-${indigo_release}-base":
			  name           => "INDIGO-${indigo_release} - Base",
			  baseurl        => "http://repo.indigo-datacloud.eu/repository/indigo/${indigo_release}/centos7/\$basearch/base",
			  failovermethod => $indigo_failovermethod,
              priority       => $indigo_priority,
              protect        => $indigo_protect,
			  enabled        => $indigo_enabled,
			  gpgcheck       => $indigo_gpgcheck,
			  gpgkey         => $indigo_gpgkey,
		}

        yumrepo {
			"INDIGO-${indigo_release}-updates":
			  name           => "INDIGO-${indigo_release} - Updates",
			  baseurl        => "http://repo.indigo-datacloud.eu/repository/indigo/${indigo_release}/centos7/\$basearch/updates",
			  failovermethod => $indigo_updates_failovermethod,
              priority       => $indigo_updates_priority,
              protect        => $indigo_updates_protect,
			  enabled        => $indigo_updates_enabled,
			  gpgcheck       => $indigo_updates_gpgcheck,
			  gpgkey         => $indigo_updates_gpgkey,
		}

        yumrepo {
			"INDIGO-${indigo_release}-third-party":
			  name           => "INDIGO-${indigo_release} - third-party",
			  baseurl        => "http://repo.indigo-datacloud.eu/repository/indigo/${indigo_release}/centos7/\$basearch/third-party",
			  failovermethod => $indigo_3rdparty_failovermethod,
              priority       => $indigo_3rdparty_priority,
              protect        => $indigo_3rdparty_protect,
			  enabled        => $indigo_3rdparty_enabled,
			  gpgcheck       => $indigo_3rdparty_gpgcheck,
			  gpgkey         => $indigo_3rdparty_gpgkey,
		}

		file {
			"/etc/pki/rpm-gpg/RPM-GPG-KEY-indigo":
				ensure => present,
				owner  => "root",
				group  => "root",
				mode   => "0644",
				source => "puppet:///modules/epel/RPM-GPG-KEY-indigo",
		}

    	indigo::gpg_key{
			"indigo":
      			path   => "/etc/pki/rpm-gpg/RPM-GPG-KEY-indigo",
      			before => Yumrepo["INDIGO-${indigo_release}-base",
								  "INDIGO-${indigo_release}-updates",
								  "INDIGO-${indigo_release}-third-party"],
    	}
    }
    elsif "${::operatingsystem}" == "Ubuntu" and "${::operatingsystemmajrelease}" == "14.04" {
    }
    else {
        notice("Your operating system ${::operatingsystem} (release: ${::operatingsystemmajrelease}) is not currently supported by INDIGO-DataCloud project.")
    }
}
