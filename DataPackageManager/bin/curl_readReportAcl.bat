@ECHO OFF

SET PASSWORD=%1

SET SERVICE_HOST=http://localhost:8888
SET SCOPE=knb-lter-nin
SET IDENTIFIER=1
SET REVISION=1

curl -i --user uid=gmn-pasta,o=LTER,dc=ecoinformatics,dc=org:%PASSWORD% -G %SERVICE_HOST%/package/report/acl/eml/%SCOPE%/%IDENTIFIER%/%REVISION%
