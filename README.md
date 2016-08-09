## New Relic Varnish Extension

This is a fork of [the original](https://github.com/varnish/newrelic_varnish_plugin) which no longer seems to be maintained

This runs on the Varnish server and reports the values from
varnishstat back into New Relic.

Tested with Varnish version 3.

## Instructions for running the Varnish extension agent
1. Download (or clone) and uncompress the [latest release](https://github.com/ilons/newrelic_varnish_plugin/releases/latest), currently v0.2:
`RELEASE="v0.2" && wget "https://github.com/ilons/newrelic_varnish_plugin/archive/${RELEASE}.tar.gz" -O - | tar -zxvz && cd "newrelic_varnish_plugin-${RELEASE}"`
2. Install required Ruby gems (json, newrelic_plugin, bundler):
`bundle install`
3. Copy the config `config/template_newrelic_plugin.yml` to the appropriate place, for example `/etc/newrelic/newrelic_varnish_plugin.yml`
`cp config/template_newrelic_plugin.yml /etc/newrelic/newrelic_vanish_plugin.yml`
4. Edit the configuration file and fill in your New Relic license key (and any other desired options)
5. Optionally, Install daemon:
`cp config/newrelic_varnish_plugin_daemon.sh /etc/init.d/newrelic-varnish.sh && chmod +x /etc/init.d/newrelic-varnish`
6. Execute plugin agent (use -h for usage hints)
`./newrelic_varnish_plugin -c /etc/newrelic/newrelic_varnish.yml -p /var/run/newrelic_varnish.pid` && `service newrelic-varnish start`
7. Go back to the Extensions list and after a brief period you will see an entry for your extension

Data should now get reported to your New Relic account

## Testing / Development
To build install the plugin in an isolated environment:

1. Install docker
2. `docker build .`
3. `docker run --rm -it <build image id>`
