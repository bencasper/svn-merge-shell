
#!/bin/sh

if [ -z "$1" ]
	then
		echo "Please supple the cms war filename you want to rollback!"
		exit -1
fi
bakApp=$1
bakDir='/letv/webapps/bak/'
runuser -l root -c 'rm -rf /letv/webapps/cms-webapp && rm -rf /letv/webapps/cms-webapp.war'
runuser -l root -c 'mkdir -p /letv/webapps/cms-webapp'
runuser -l root -c 'chown -R resin /letv/webapps'
runuser -l resin -c "cp  $bakDir$bakApp /letv/webapps/cms-webapp.war"
runuser -l resin -c 'cd /letv/webapps/cms-webapp && rm -rf * && /letv/apps/jdk/bin/jar xf /letv/webapps/cms-webapp.war'
runuser -l root -c 'cd /letv/webapps/cms-webapp/page && rm -rf template && ln -s /letv/data/page/template template'
runuser -l root -c 'cd /letv/webapps/cms-webapp/WEB-INF/ && rm -rf velocity && ln -s /letv/data/velocity velocity'
runuser -l root -c 'cd /letv/webapps/cms-webapp/ && ln -s /letv/pubdata/commonfrag/ frag'

runuser -l resin -c '/letv/script/resin-cms-webapp-8080.sh start'
