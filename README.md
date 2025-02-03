# ILIAS Helm Chart

This Helm chart deploys the ILIAS e-learning platform on a Kubernetes cluster. It supports deploying ILIAS with either a single MariaDB instance or a Galera cluster for high availability.  It also includes deployment of the ILIAS RPC server, automatic database backups, and ILIAS cron jobs.

## Prerequisites

- Kubernetes cluster
- Helm 3

## Installing the Chart

1. Add the repository (if you haven't already):

```bash
helm repo add ilias-helm https://relaxdays.github.io/ilias-helm/
helm repo update
```

2. Install the chart:

```bash
helm install ilias ilias-helm/ilias -n <your-namespace> # Replace with your release name and namespace
```

## Uninstalling the Chart

```bash
helm uninstall ilias -n <your-namespace> # Replace with your release name and namespace
```

## Configuration

The following table describes the configurable parameters in the `values.yaml` file:

| Parameter | Description | Default |
|---|---|---|
| `ilias.image` | ILIAS Docker image name | `srsolutions/ilias` |
| `ilias.tag` | ILIAS Docker image tag | `9-php8.2-apache` |
| `ilias.port` | ILIAS service port | `80` |
| `ilias.autoSetup` | Automatically run ILIAS setup | `true` |
| `ilias.autoUpdate` | Automatically run ILIAS update (ILIAS >= 7) | `0` |
| `ilias.devMode` | Enable ILIAS development mode | `0` |
| `ilias.installArguments` | Arguments for ILIAS installation | `""` |
| `ilias.updateArguments` | Arguments for ILIAS update (ILIAS >= 7) | `""` |
| `ilias.skipUpdate` | Skip ILIAS update (ILIAS < 6) | `0` |
| `ilias.db.host` | MariaDB host. If empty, it will be set by the MariaDB chart. | `""` |
| `ilias.db.user` | ILIAS database user | `ilias` |
| `ilias.db.password` | ILIAS database password. Overridden by `mariadb.auth.rootPassword` if set. | `""` |
| `ilias.db.name` | ILIAS database name | `ilias` |
| `ilias.db.dump` | Path to the ILIAS database dump file | `setup/sql/ilias3.sql` |
| `ilias.clientName` | ILIAS client name | `default` |
| `ilias.hostName` | ILIAS host name. Defaults to the pod's hostname. | `""` |
| `ilias.timezone` | ILIAS timezone | `Europe/Berlin` |
| `ilias.maxUploadSize` | Maximum file upload size | `200M` |
| `ilias.errorsPath` | Path to ILIAS error logs | `/var/iliasdata/ilias/errors` |
| `ilias.memoryLimit` | PHP memory limit | `4096M` |
| `ilias.rootPassword` | ILIAS root password | `""` |
| `ilias.defaultSkin` | Default ILIAS skin | `default` |
| `ilias.defaultStyle` | Default ILIAS style | `delos` |
| `ilias.sessionLifetime` | ILIAS session lifetime (in seconds) | `1800` |
| `ilias.dumpAutoload` | Whether to dump autoload files | `0` |
| `ilias.phpConfig` | Custom PHP configuration | See `values.yaml` |
| `ilias.clientIni` | Custom ILIAS client INI configuration | See `values.yaml` |
| `ilias.setupJson` | Custom ILIAS setup JSON configuration | See `values.yaml` |
| `ilias.iliasIni` | Custom ILIAS INI configuration | See `values.yaml` |
| `ilias.volumes.data.size` | Size of the persistent volume for ILIAS data | `4Gi` |
| `ilias.volumes.data.accessMode` | Access mode for the ILIAS data persistent volume | `ReadWriteMany` |
| `ilias.volumes.iliasdata.size` | Size of the persistent volume for ILIAS data directory | `4Gi` |
| `ilias.volumes.iliasdata.accessMode` | Access mode for the ILIAS data directory persistent volume | `ReadWriteMany` |
| `ilias.resources.requests.cpu` | CPU requests for the ILIAS pod | `200m` |
| `ilias.resources.requests.memory` | Memory requests for the ILIAS pod | `4G` |
| `ilias.resources.limits.cpu` | CPU limits for the ILIAS pod | `3` |
| `ilias.resources.limits.memory` | Memory limits for the ILIAS pod | `6G` |
| `iliasRPCServer.image` | ILIAS RPC server Docker image | `srsolutions/ilias-ilserver` |
| `iliasRPCServer.tag` | ILIAS RPC server Docker image tag | `9-openjdk17-jre` |
| `iliasRPCServer.nicId` | ILIAS RPC server NIC ID | `0` |
| `iliasRPCServer.logLevel` | ILIAS RPC server log level | `INFO` |
| `iliasRPCServer.threads` | ILIAS RPC server number of threads | `1` |
| `iliasRPCServer.ramBufferSize` | ILIAS RPC server RAM buffer size | `256` |
| `iliasRPCServer.maxFileSize` | ILIAS RPC server maximum file size | `500` |
| `iliasRPCServer.port` | ILIAS RPC server port | `11111` |
| `iliasRPCServer.iliasIni` | ILIAS RPC server ILIAS INI configuration | See `values.yaml` |
| `iliasRPCServer.ilServerProperties` | ILIAS RPC server properties configuration | See `values.yaml` |
| `iliasRPCServer.volumes.lucene.size` | Size of the persistent volume for ILIAS RPC server Lucene data | `4Gi` |
| `iliasRPCServer.volumes.lucene.accessMode` | Access mode for the ILIAS RPC server Lucene data persistent volume | `ReadWriteOnce` |
| `extraVolumes` | Array of extra volumes to mount | `[]` |
| `extraVolumeMounts` | Array of extra volume mounts | `[]` |
| `ingress.enabled` | Enable Ingress | `true` |
| `ingress.annotations` | Ingress annotations | See `values.yaml` |
| `ingress.hosts` | Ingress hosts | See `values.yaml` |
| `ingress.tls` | Ingress TLS configuration | See `values.yaml` |
| `mariadbgalera.enabled` | Enable Galera cluster | `false` |
| `mariadbgalera.rootUser.password` | Galera root user password | `""` |
| `mariadbgalera.db.user` | Galera database user | `ilias` |
| `mariadbgalera.db.password` | Galera database password | `""` |
| `mariadbgalera.db.name` | Galera database name | `ilias` |
| `mariadbgalera.persistence.enabled` | Enable persistence for Galera data | `true` |
| `mariadbgalera.persistence.size` | Size of the persistent volume for Galera data | `10Gi` |
| `mariadbgalera.galera.mariabackup.password` | Password for `mariabackup` | `secret` |
| `mariadbgalera.mariadbConfiguration` | Custom MariaDB configuration for Galera | See `values.yaml` |
| `mariadb.enabled` | Enable single MariaDB instance | `true` |
| `mariadb.auth.username` | MariaDB user | `ilias` |
| `mariadb.auth.password` | MariaDB user password | `""` |
| `mariadb.auth.rootPassword` | MariaDB root password | `""` |
| `mariadb.auth.database` | MariaDB database name | `ilias` |
| `mariadb.persistence.enabled` | Enable persistence for MariaDB data | `true` |
| `mariadb.persistence.size` | Size of the persistent volume for MariaDB data | `10Gi` |
| `mariadb.primary.configuration` | Custom MariaDB configuration | See `values.yaml` |
| `mariadbBackup.enabled` | Enable MariaDB backups | `true` |
| `mariadbBackup.schedule` | Backup schedule (cron expression) | `0 3 * * *` |
| `mariadbBackup.volume.size`| Size of Backup volume | `4Gi` |
| `cronjob.enabled` | Enables or disables the ILIAS cron job. | `true` |
| `cronjob.image` | The Docker image to use for the cron job. | `srsolutions/ilias` |
| `cronjob.tag` | The Docker image tag to use for the cron job. | `9-php8.2-apache` |
| `cronjob.schedule` | The schedule for the cron job, using cron expression format. | `0 2 * * *` (Daily at 2 AM) |


# Thank you to
Many thanks goes to these great projects:  
* Ilias by ILIAS open source e-Learning e.V. - https://github.com/ILIAS-eLearning/ILIAS
* Ilias Docker image by srsolutions ag - https://github.com/srsolutionsag/docker-ilias 
* Bitnami Helm charts by Broadcom Inc. - https://github.com/bitnami/charts

# License
This project is licensed under GPLv3.