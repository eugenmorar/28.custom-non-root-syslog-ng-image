## Pod manifest
```
apiVersion: v1
kind: Pod
metadata:
  name: syslog-ng-pod
  labels:
    app: syslog-ng
spec:
  containers:
  - name: syslog-ng
    image: balabit/syslog-ng:latest
    env:
    - name: SYSLOG_NG_CONFIG
      value: /etc/syslog-ng/syslog-ng.conf
    volumeMounts:
    - name: syslog-ng-config
      mountPath: /etc/syslog-ng
      readOnly: true
    securityContext:
      runAsUser: 1000
      runAsGroup: 1000
  volumes:
  - name: syslog-ng-config
    secret:
      secretName: syslog-ng-config
```
## Starting and connecting to the customized container
```
docker run -d --name syslog-non-root emorar/syslog-ng-non-root:latest
docker exec -it syslog-non-root /bin/bash
```
