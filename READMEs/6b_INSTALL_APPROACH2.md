## Installation Approach 2 - Using scripts

* Setup the demo.  Run these commands as root. 
```

mkdir /app
cd /app
git clone https://github.com/sainib/hadoop-data-pipeline.git

cd /app/hadoop-data-pipeline/scripts

bash setupAppOnHDFS.sh
bash changeValidityForFeed.sh 
bash changeValidityForProcess.sh 

bash submitEntities.sh
bash scheduleEntities.sh
 
```

* Run the demo. Run these commands as root
```

cd /app/hadoop-demos/data-pipeline/flow1/scripts

bash setupFlume.sh
bash runTest.sh

```

* To stop the processing 
```
cd /app/hadoop-data-pipeline/scripts
bash suspendEntites.sh
bash deleteEntities.sh
```

* To reset the demo (after the entities have been suspended and deleted)
```
cd /app/hadoop-data-pipeline/scripts
bash demoReset.sh
```
