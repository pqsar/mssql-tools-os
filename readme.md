# MSSQL-TOOLS For OpenShift
[![Docker Repository on Quay](https://quay.io/repository/pqsdev/mssql-tools/status "Docker Repository on Quay")](https://quay.io/repository/pqsdev/mssql-tools)

Custom MSSQL-TOOL image for OpenShift. 


## Build

Clone the repo and :

```bash
docker build -f  Dockerfile -t quay.io/pqsdev/mssql-tools:latest .
```


## Using this image

**Available on [quay.io](https://quay.io/repository/pqsdev/mssql-tools)**

This commands returns an interactive console inside the pod
```bash
oc run -i -t mssql-tools --image=quay.io/pqsdev/mssql-tools
```


One the pod is up an running `sqlcmd` can be used

```bash
sqlcmd -S aserver.pqs.local -U sa -P SuperDificultPassword -C -q "SELECT * FROM sysobjects"  
```
