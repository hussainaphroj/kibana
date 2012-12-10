# Kibana Puppet Module

This module manages [Kibana](http://www.kibana.org) a highly scalable for [Logstash](http://logstash.net/) and [ElasticSearch](http://www.elasticsearch.org/).

## Basic usage

You can install kibana in different ways (see class parameter *kibana_provider*). For example directly from Github (default settings):

    include kibana

This way, Ruby libs required by Kibana are installed with your package management system (yum, apt). 

If you prefer to use gem packages (more Dev than Op :)), simply force class parameter *package_type* to 'gem': 

    class {'kibana': package_type => 'gem'}

## Dependencies

This module depends on:
 
 * [puppet-ruby](https://github.com/camptocamp/puppet-ruby) for the management of Ruby libraries

## Contributing

Please report bugs and feature request using [GitHub issue
tracker](https://github.com/camptocamp/puppet-kibana/issues).

For pull requests, it is very much appreciated to check your Puppet manifest
with [puppet-lint](https://github.com/rodjek/puppet-lint) to follow the recommended Puppet style guidelines from the
[Puppet Labs style guide](http://docs.puppetlabs.com/guides/style_guide.html).

## License

Copyright (c) 2012 <mailto:puppet@camptocamp.com> All rights reserved.

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.
    
    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.
    
    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
