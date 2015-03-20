
# Flume setup instructions

Use these instructions to setup  the flume part of the project using spooling directory flume configurations. See [Flume Spooling Dir Docs](https://flume.apache.org/FlumeUserGuide.html#spooling-directory-source)

## Copy the flume conf to the config directory 
* Copy the flume.conf file in this directory to your home directory on the gateway server
* Once done, use the following commands to setup flume. 

* cd 
* cd /etc/flume/conf
* mv flume.conf flume.conf.bak
* cd - 
* cp ./flume.conf /etc/flume/conf/flume.conf

## Start the flume process 

```
flume-ng agent -c /etc/flume/conf -f /etc/flume/conf/flume.conf -n sandbox
```


