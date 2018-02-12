FROM rhel7:7.3

MAINTAINER OpenShift Development <dev@lists.openshift.redhat.com>

USER 0

ENV KIBANA_HOME=/usr/share/kibana \
    KIBANA_VER=6.2.1 \
    KIBANA_CONF=/etc/kibana \
    HOME=/opt/app-root/src \
    KIBANA_PORT=5601 \
    KIBANA_DEBUG=false \
    ELASTICSEARCH_URL=http://elasticsearch:9200

LABEL io.k8s.description="Kibana container" \
      io.k8s.display-name="Kibana ${KIBANA_VER}" \
      io.openshift.expose-services="${KIBANA_PORT}:https" \
      io.openshift.tags="elasticsearch,kibana" \
      architecture=x86_64 \
      name="openshift3/kibana"

EXPOSE ${KIBANA_PORT}

COPY elasticsearch.repo /etc/yum.repos.d/elasticsearch.repo
# install the RPMs in a separate step so it can be cached
RUN rpm --import https://artifacts.elastic.co/GPG-KEY-elasticsearch
RUN yum install -y --setopt=tsflags=nodocs \
                kibana-${KIBANA_VER} && \
    yum clean all

COPY config/kibana.yml ${KIBANA_CONF}

WORKDIR ${HOME}
USER 999
CMD ["sh", "-c", "${KIBANA_HOME}/bin/kibana --server.port=${KIBANA_PORT} --elasticsearch.url=${ELASTICSEARCH_URL} --logging.verbose=${KIBANA_DEBUG}"]
