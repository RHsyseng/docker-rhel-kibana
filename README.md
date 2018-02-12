# Kibana on OpenShift

This images allows deploying [Kibana](https://www.elastic.co/guide/en/kibana/6.2) on OpenShift. Two images are provided:

 * [RHEL 7.3](./Dockerfile)
 * [CentOS 7](./Dockerfile.centos7)

The following environment variables are configurable:

 * KIBANA_SERVER_PORT: Which port Kibana will listen to. Default `5601`
 * ELASTICSEARCH_URL: URL where Elasticsearch exposes the REST API. Default `http://elasticsearch:9200`
 * KIBANA_DEBUG: Boolean value to tell Kibana to start in verbose mode. Default `false`

Configurable volumes. None of them are required for the ephemeral version.

  * **data**: The location of the data files written to disk by Kibana and its plugins. Default `/var/lib/kibana`
  * **optimize**: Transpiled source code. Certain administrative actions (e.g. plugin install) result in the source code being retranspiled on the fly. Default `/usr/share/kibana/optimize`
  * **plugins**: Plugin files location. Each plugin will be contained in a subdirectory. Default `/usr/share/kibana/plugins`

An example deployment file is also included:
```
$  oc create -f kibana-deployment.yml
deploymentconfig "kibana" created
service "kibana" created
route "kibana" created
imagestream "kibana" created
```
