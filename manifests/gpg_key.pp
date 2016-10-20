define indigo::gpg_key($path) {
	if "${::osfamily}" == "RedHat" {
		$cmd = "rpm --import ${path}"
		$unless_cmd = "rpm -q gpg-pubkey-$(echo $(gpg --throw-keyids --keyid-format short < ${path}) | cut --characters=11-18 | tr '[A-Z]' '[a-z]')"
	}

    exec {
        "import-${name}":
			path      => "/bin:/usr/bin:/sbin:/usr/sbin",
			command   => $cmd,
			unless    => $unless_cmd,
			require   => File[$path],
			logoutput => "on_failure",
    }
}
