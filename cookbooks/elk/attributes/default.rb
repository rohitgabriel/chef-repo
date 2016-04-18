# -*- encoding: utf-8 -*-
default['elk']['repo_server'] = '104.236.159.226:18000'
default['elk']['logstash_port'] = '9301'
default['elk']['allocated_memory'] = '256m'
default['elk']['elasticsearch_cluster_name'] = 'authright'
default['elk']['elasticsearch_port'] = 9200

default['elk']['logstash_version'] = '1.5.3'
default['elk']['elasticsearch_version'] = '1.6.0'
default['elk']['kibana_version'] = '4.0.0-beta3'
default['elk']['kibana_download_url'] = ''
default['elk']['download_checksum'] = ''
default['elk']['kibana_java_opts'] = '-Xms128m -Xmx128m $JAVA_OPTS'
default['elk']['kibana_host'] = '0.0.0.0'
default['elk']['kibana_port'] = '5601'
default['elk']['kibana_elasticsearch_server'] = 'http://127.0.0.1:9200'
default['elk']['kibana_elasticsearch_index'] = '.kibana'
default['elk']['kibana_default_app_id'] = 'discover'
default['elk']['kibana_request_timeout'] = '60'
default['elk']['kibana_shared_timeout'] = '30000'
default['elk']['kibana_verify_ssl'] = true
