FROM bitnami/postgresql:14-debian-10

USER root
ENV PG_CRON_VERSION 1.4.1
ENV PG_JOBMON_VERSION 1.4.1
ENV PG_PARTMAN_VERSION 4.6.0

RUN install_packages build-essential

# Build pg_cron
RUN curl -JL -o /tmp/pg_cron.tar.gz https://github.com/citusdata/pg_cron/archive/refs/tags/v$PG_CRON_VERSION.tar.gz
RUN tar xzf /tmp/pg_cron.tar.gz -C /tmp
RUN make -C /tmp/pg_cron-$PG_CRON_VERSION PG_CONFIG=/opt/bitnami/postgresql/bin/pg_config
RUN make -C /tmp/pg_cron-$PG_CRON_VERSION PG_CONFIG=/opt/bitnami/postgresql/bin/pg_config install
RUN rm -rf /tmp/pg_cron-$PG_CRON_VERSION /tmp/pg_cron.tar.gz

# Build pg_jobmon (for pg_partman)
RUN curl -JL -o /tmp/pg_jobmon.tar.gz https://github.com/omniti-labs/pg_jobmon/archive/refs/tags/v$PG_JOBMON_VERSION.tar.gz
RUN tar xzf /tmp/pg_jobmon.tar.gz -C /tmp
RUN make -C /tmp/pg_jobmon-$PG_JOBMON_VERSION PG_CONFIG=/opt/bitnami/postgresql/bin/pg_config
RUN make -C /tmp/pg_jobmon-$PG_JOBMON_VERSION PG_CONFIG=/opt/bitnami/postgresql/bin/pg_config install
RUN rm -rf /tmp/pg_jobmon-$PG_JOBMON_VERSION /tmp/pg_jobmon.tar.gz

# Build pg_partman
RUN curl -JL -o /tmp/pg_partman.tar.gz https://github.com/pgpartman/pg_partman/archive/refs/tags/v$PG_PARTMAN_VERSION.tar.gz
RUN tar xzf /tmp/pg_partman.tar.gz -C /tmp
RUN make -C /tmp/pg_partman-$PG_PARTMAN_VERSION PG_CONFIG=/opt/bitnami/postgresql/bin/pg_config
RUN make -C /tmp/pg_partman-$PG_PARTMAN_VERSION PG_CONFIG=/opt/bitnami/postgresql/bin/pg_config install
RUN rm -rf /tmp/pg_partman-$PG_PARTMAN_VERSION /tmp/pg_partman.tar.gz

USER 1001
