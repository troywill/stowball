#!/bin/bash
sudo gem install --no-rdoc --no-ri rails
exit

Usage: gem install GEMNAME [GEMNAME ...] [options] -- --build-flags [options]

  Options:
        --platform PLATFORM          Specify the platform of gem to install
    -v, --version VERSION            Specify version of gem to install

  Install/Update Options:
    -i, --install-dir DIR            Gem repository directory to get installed
                                     gems
    -n, --bindir DIR                 Directory where binary files are
                                     located
    -d, --[no-]rdoc                  Generate RDoc documentation for the gem on
                                     install
        --[no-]ri                    Generate RI documentation for the gem on
                                     install
    -E, --[no-]env-shebang           Rewrite the shebang line on installed
                                     scripts to use /usr/bin/env
    -f, --[no-]force                 Force gem to install, bypassing dependency
                                     checks
    -t, --[no-]test                  Run unit tests prior to installation
    -w, --[no-]wrappers              Use bin wrappers for executables
                                     Not available on dosish platforms
    -P, --trust-policy POLICY        Specify gem trust policy
        --ignore-dependencies        Do not install any required dependent gems
    -y, --include-dependencies       Unconditionally install the required
                                     dependent gems
        --[no-]format-executable     Make installed executable names match ruby.
                                     If ruby is ruby18, foo_exec will be
                                     foo_exec18
        --[no-]user-install          Install in user's home directory instead
                                     of GEM_HOME. Defaults to using home directory
                                     only if GEM_HOME is not writable.
        --development                Install any additional development
                                     dependencies

  Local/Remote Options:
    -l, --local                      Restrict operations to the LOCAL domain
    -r, --remote                     Restrict operations to the REMOTE domain
    -b, --both                       Allow LOCAL and REMOTE operations
    -B, --bulk-threshold COUNT       Threshold for switching to bulk
                                     synchronization (default 1000)
        --source URL                 Use URL as the remote source for gems
    -p, --[no-]http-proxy [URL]      Use HTTP proxy for remote operations
    -u, --[no-]update-sources        Update local source cache

  Common Options:
    -h, --help                       Get help on this command
    -V, --[no-]verbose               Set the verbose level of output
    -q, --quiet                      Silence commands
        --config-file FILE           Use this config file instead of default
        --backtrace                  Show stack backtrace on errors
        --debug                      Turn on Ruby debugging


  Arguments:
    GEMNAME       name of gem to install

  Summary:
    Install a gem into the local repository

  Description:
    The install command installs local or remote gem into a gem repository.
    
    For gems with executables ruby installs a wrapper file into the executable
    directory by deault.  This can be overridden with the --no-wrappers option.
    The wrapper allows you to choose among alternate gem versions using
    _version_.
    
    For example `rake _0.7.3_ --version` will run rake version 0.7.3 if a newer
    version is also installed.

  Defaults:
    --both --version '>= 0' --rdoc --ri --no-force
    --no-test --install-dir /usr/lib/ruby/gems/1.9.1
