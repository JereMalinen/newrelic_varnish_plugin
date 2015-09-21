## New Relic Varnish Extension

This is a fork of [the original](https://github.com/varnish/newrelic_varnish_plugin) which no longer seems to be maintained

This runs on the Varnish server and reports the values from
varnishstat back into New Relic.

## Installation
1. Download (or clone) and uncompress the [latest release](https://github.com/ilons/newrelic_varnish_plugin/releases/latest), currently v0.2:
`RELEASE="v0.2" wget "https://github.com/ilons/newrelic_varnish_plugin/archive/${RELEASE}.tar.gz" -O - | tar zxvz && cd "newrelic_varnish_plugin-${RELEASE}"`
2. Install required Ruby gems (json, newrelic_plugin, bundler):
`bundle install`
3. Copy the config `config/template_newrelic_plugin.yml` to the appropriate place, for example `/etc/newrelic/newrelic_varnish_plugin.yml`
`cp config/template_newrelic_plugin.yml /etc/newrelic/newrelic_vanish_plugin.yml`
4. Edit the configuration file and fill in your New Relic license key (and any other desired options)
5. Execute plugin agent (use -h for usage hints)

Data should now get reported to you'r New Relic account
