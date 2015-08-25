
#PREP WORK

## Ambari
* Make sure that following component are running 
	- Hive
	- Falcon
	- Oozie
	- Flume

* Ambari Config / Setting
```
// Save and restart all components after changing configs

// Hive, set
webhcat.proxyuser.oozie.groups = *
webhcat.proxyuser.oozie.hosts = *

// hdfs - core site
hadoop.proxyuser.oozie.groups = *
hadoop.proxyuser.oozie.hosts = *

hadoop.proxyuser.falcon.groups = *
hadoop.proxyuser.falcon.hosts = *

// Oozie
oozie.service.AuthorizationService.security.enabled = false

```
