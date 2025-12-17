WiredTiger存储引擎
内存存储引擎
MMAPv1存储引擎(mongodb 4.0不推荐使用)



配置服务器存储分片集群的元数据。元数据反映了分片集群中所有数据和组件的状态和组织。元数据包括每个分片上的块列表以及定义块的范围。

配置服务器还存储身份验证配置信息，例如基于角色的访问控制或群集的内部身份验证设置

MongoDB还使用配置服务器来管理分布式锁。

如果配置服务器副本集丢失其主节点而无法选择主节点，则群集的元数据将变为只读。您仍然可以从分片读取和写入数据，但在副本集可以选择主分区之前，不会发生块迁移或块分割。


配置文件选项
https://docs.mongodb.com/manual/reference/configuration-options/


mongod --config mongod.conf
mongos --config mongos.conf


.conf default
###################
systemLog:
   verbosity: <int>
   quiet: <boolean>
   traceAllExceptions: <boolean>
   syslogFacility: <string>
   path: <string>
   logAppend: <boolean>
   logRotate: <string>
   destination: <string>
   timeStampFormat: <string>
   component:
      accessControl:
         verbosity: <int>
      command:
         verbosity: <int>
      
      
      replication:
         verbosity: <int>
         heartbeats:
            verbosity: <int>
         rollback:
            verbosity: <int>
      storage:
         verbosity: <int>
         journal:
            verbosity: <int>
         recovery:
            verbosity: <int>
      write:
         verbosity: <int>

processManagement:
   fork: <boolean> 
   pidFilePath: <string> 
   timeZoneInfo: <string>


cloud:
   monitoring:
      free:
         state: <string> 
         tags: <string>

net:
   port: <int>
   bindIp: <string>
   bindIpAll: <boolean>
   maxIncomingConnections: <int>
   wireObjectCheck: <boolean>
   ipv6: <boolean>
   unixDomainSocket:
      enabled: <boolean>
      pathPrefix: <string>
      filePermissions: <int>
   ssl:
      sslOnNormalPorts: <boolean>  # deprecated since 2.6
      certificateSelector: <string>
      clusterCertificateSelector: <string>
      mode: <string>
      PEMKeyFile: <string>
      PEMKeyPassword: <string>
      clusterFile: <string>
      clusterPassword: <string>
      CAFile: <string>
      clusterCAFile: <string>
      CRLFile: <string>
      allowConnectionsWithoutCertificates: <boolean>
      allowInvalidCertificates: <boolean>
      allowInvalidHostnames: <boolean>
      disabledProtocols: <string>
      FIPSMode: <boolean>
   compression:
      compressors: <string>
   serviceExecutor: <string>

security:
   keyFile: <string>
   clusterAuthMode: <string>
   authorization: <string>
   transitionToAuth: <boolean>
   javascriptEnabled:  <boolean>
   redactClientLogData: <boolean>
   sasl:
      hostName: <string>
      serviceName: <string>
      saslauthdSocketPath: <string>
   enableEncryption: <boolean>
   encryptionCipherMode: <string>
   encryptionKeyFile: <string>
   kmip:
      keyIdentifier: <string>
      rotateMasterKey: <boolean>
      serverName: <string>
      port: <string>
      clientCertificateFile: <string>
      clientCertificatePassword: <string>
      clientCertificateSelector: <string>
      serverCAFile: <string>
   ldap:
      servers: <string>
      bind:
         method: <string>
         saslMechanisms: <string>
         queryUser: <string>
         queryPassword: <string>
         useOSDefaults: <boolean>
      transportSecurity: <string>
      timeoutMS: <int>
      userToDNMapping: <string>
      authz:
         queryTemplate: <string>

storage:
   dbPath: <string>
   indexBuildRetry: <boolean>
   repairPath: <string>
   journal:
      enabled: <boolean>
      commitIntervalMs: <num>
   directoryPerDB: <boolean>
   syncPeriodSecs: <int>
   engine: <string>
   mmapv1:
      preallocDataFiles: <boolean>
      nsSize: <int>
      quota:
         enforced: <boolean>
         maxFilesPerDB: <int>
      smallFiles: <boolean>
      journal:
         debugFlags: <int>
         commitIntervalMs: <num>
   wiredTiger:
      engineConfig:
         cacheSizeGB: <number>
         journalCompressor: <string>
         directoryForIndexes: <boolean>
      collectionConfig:
         blockCompressor: <string>
      indexConfig:
         prefixCompression: <boolean>
   inMemory:
      engineConfig:
         inMemorySizeGB: <number>

operationProfiling:
   mode: <string>
   slowOpThresholdMs: <int>
   slowOpSampleRate: <double>

replication:
   oplogSizeMB: <int>
   replSetName: <string>
   secondaryIndexPrefetch: <string>
   enableMajorityReadConcern: <boolean>

sharding:
   clusterRole: <string>
   archiveMovedChunks: <boolean>

auditLog:								# Available only in MongoDB Enterprise and MongoDB Atlas.
   destination: <string>
   format: <string>
   path: <string>
   filter: <string>

snmp:
   disabled: <boolean>
   subagent: <boolean>
   master: <boolean>

replication:
   localPingThresholdMs: <int>

sharding:
   configDB: <string>

############################


net.port

27017 for mongod (if not a shard member or a config server member) or mongos instance
27018 if mongod is a shard member
27019 if mongod is a config server member


.conf
#############

systemLog:
   verbosity: 3
   quiet: false
   traceAllExceptions: true
   path: logs/mongod.log
   logAppend: false
   logRotate: rename
   destination: file
   timeStampFormat: iso8601-local
   component:
      accessControl:
         verbosity: 4
      command:
         verbosity: 4
	  control:
		 verbosity: 4 
	  ftdc:
         verbosity: 4 
	  geo:
         verbosity: 4
	  index:
         verbosity: 4
	  network:
         verbosity: 4
      query:
         verbosity: 4
      replication:
         verbosity: 4         
         heartbeats:
            verbosity: 4
         rollback:
            verbosity: 4
      sharding:  
         verbosity: 4
	  storage:
         verbosity: 4
         journal:
            verbosity: 4
         recovery:
            verbosity: 4
	  write:
		 verbosity: 4

processManagement:
   fork: true
   pidFilePath: run/mongod.pid 	# mongos,mongod,必须是绝对路径

cloud:
   monitoring:			# for repica set
      free:
         state: runtime

net:
   port: <int>				# mongos,mongod

#####
27017 for mongod (if not a shard member or a config server member) or mongos instance
27018 if mongod is a shard member
27019 if mongod is a config server member
#####
											 
   bindIp: 0.0.0.0
   bindIpAll: false
   maxIncomingConnections: 65536		# mongos,mongod
   wireObjectCheck: true		#mongos,mongod
   ipv6: false
   unixDomainSocket:
      enabled: true					#mongos,mongod
      pathPrefix: run/					#mongos,mongod
      filePermissions: 0700
   ssl:
      mode: disabled					#mongos,mongod

   compression:
      compressors: snappy		#mongos,mongod
   serviceExecutor: adaptive		#mongos,mongod

security:
   keyFile: <string>
   clusterAuthMode: <string>
   authorization: disabled		# only mongod
   transitionToAuth: false
   javascriptEnabled:  true		# mongod

storage:
   dbPath: data/db                          # only mongod
   indexBuildRetry: true				  # mongod
   repairPath: 								  # only mmapv1 引擎 and mongod
   journal:
      enabled: true							  # only mongod
      commitIntervalMs: 50
   directoryPerDB: true				# only mongod
   syncPeriodSecs: 						# default: 60 only mongod
   engine: wiredTiger					# mongod
   wiredTiger:
      engineConfig:
         cacheSizeGB: 1G
         journalCompressor: snappy
         directoryForIndexes: true
      collectionConfig:
         blockCompressor: snappy
      indexConfig:
         prefixCompression: true

operationProfiling:
   mode: off
   slowOpThresholdMs: 200              # mongod,mongos
   slowOpSampleRate: 1.0					#mongod,mongos

replication:
   oplogSizeMB: 								# mongod
   replSetName: 								# mongod,副本集名称,副本集中的所有主机必须具有相同的集合名称,不能用于关联于storage.indexBuildRetry,对于WiredTiger,storage.journal.enable:false不能用于关联replication.replSetname

   enableMajorityReadConcern: true

sharding:
   clusterRole: <string>					#mongod mongod在分片集群中的角色,configsvr-配置服务器启动,27019默认启动,shardsvr-分片服务器启动,27018默认启动
															#注意:设置sharding.clusterRole要求mongod 实例以复制方式运行。要将实例部署为副本集成员，请使用该replSetName 设置并指定副本集的名称。
   archiveMovedChunks: false

snmp:
   disabled: true 	# mongod
   subagent: false 
   master: false
	
replication:
   localPingThresholdMs: 15		# mongos

sharding:
   configDB: <string>

########
sharding:
  configDB: <configReplSetName>/cfg1.example.net:27019, cfg2.example.net:27019,...
分片mongos群集的实例必须指定相同的配置服务器副本集名称，但可以指定副本集的不同成员的主机名和端口
配置服务器可以部署为副本集模式,并且必须用WiredTiger引擎  



配置服务器,27019为配置服务器端口
mongo --host 192.168.10.1 --port 27019
config={_id:"configSvrReplSet",members:[{_id:0,host:"192.168.10.1:27019"},{_id:1,host:"192.168.10.2:27019"},{_id:2,host:"192.168.10.3:27019"}]}
rs.initiate(config)	
#查看状态
rs.status();

分片服务器,27018为分片服务器端口,如果有多个分片,每个分片的副本集必须都如此
mongo --host 192.168.10.1 --port 27018

use admin
config={_id:"shard01ReplSet",members:[{_id:0,host:"192.168.10.1:27018"},{_id:1,host:"192.168.10.2:27018"},{_id:2,host:"192.168.10.3:27018"}]}
rs.initiate(config)	

或者(不建议,或者所有的添加到副本中的方式都必须相同)
rs.initiate()									//设置本机30.23.8.182为主节点
rs.add("192.168.10.2:27018")		//添加备份机
rs.addArb("192.168.10.3:27018")		//添加仲裁节点
rs.status() 						//查看状态

config={_id:"shard02ReplSet",members:[{_id:0,host:"192.168.10.4:27028"},{_id:1,host:"192.168.10.5:27028"},{_id:2,host:"192.168.10.6:27028"}]}


路由服务器,添加分片
use  admin
sh.addShard("shard01ReplSet/192.168.10.1:27018,192.168.10.2:27018,192.168.10.3:27018")
sh.addShard("shard02ReplSet/192.168.10.4:27028,192.168.10.5:27028,192.168.10.6:27028")
sh.status()


实现分片功能
设置分片chunk大小

连接路由

mongos> use config
mongos> db.settings.save({"_id":"chunksize","value":1})
#设置块大小为1M是方便实验，不然需要插入海量数据
模拟写入数据

mongos> use school
mongos> show collections
mongos> for(i=1;i<=50000;i++){db.user.insert({"id":i,"name":"jack"+i})}
#在school库的user表中循环写入五万条数据
启动数据库分片

mongos>sh.enableSharding("school")
#我们可以自定义需要分片的库或表
为school库中的user集合创建索引，然后对表进行分片

mongos> db.user.createIndex({"id":1})
#以"id"作为索引
mongos> sh.shardCollection("school.user",{"id":1})
#根据"id"对user表进行分片
mongos> sh.status()
#查看分片情况
mongos> sh.help()
#查看分片相关的命令


FAQ
配置服务和分片的data目录不能混在一起,否则有
ERROR: child process failed, exited with error number 100
To see additional information in this output, start without the "--fork" option.
这样的提示

上述的报错,如果在异常关闭mongodb的时候,也会出现,因为,.sock/.pid以及data目录中有数据,删除就可以


另外,分片的副本不要重合,否则,可能会导致在副本集中,出现混乱
建立副本集的时候,最好用rs.initiate(config)方式,不要用add的模式,否则在路由端添加分片的时候,会出现无法通讯的情况


  

