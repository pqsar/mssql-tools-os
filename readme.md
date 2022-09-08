# MSSQL-TOOLS For OpenShift

[![Docker Repository on Quay](https://quay.io/repository/pqsdev/mssql-tools-os/status "Docker Repository on Quay")](https://quay.io/repository/pqsdev/mssql-tools-os)

Custom MSSQL-TOOL image for OpenShift.

## Build

Clone the repo and :

```bash
docker build -f  Dockerfile -t quay.io/pqsdev/mssql-tools-os:latest .
```

## Using this image

**Available on [quay.io](https://quay.io/repository/pqsdev/mssql-tools-os)**

This commands returns an interactive console inside the pod

```bash
oc run -i -t mssql-tools --image=quay.io/pqsdev/mssql-tools-os
```

One the pod is up an running `sqlcmd` can be used

```bash
sqlcmd -S aserver.pqs.local -U sa -P SuperDificultPassword -C -q "SELECT TOP 10 * FROM sysobjects"
```

## Deployment

```yml
apiVersion: v1
kind: Secret
metadata:
  name: mssql-tools
  labels:
    app: mssql-tools
stringData :
  MSSQL_SERVER: localhost
  MSSQL_DATABASE: master
  MSSQL_USER: a_sql_user
  MSSQL_PASSWORD: SuperDificultPassword

---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: mssql-tools
  labels:
    app: mssql-tools
spec:
  replicas: 1
  selector:
    matchLabels:
      app: mssql-tools
  template:
    metadata:
      labels:
        app: mssql-tools
    spec:
      containers:
        - name: mssql-tools
          image: quay.io/pqsdev/mssql-tools-os
          livenessProbe:
            exec:
              command:
              - /bin/sh
              - health.sh
            initialDelaySeconds: 5
            periodSeconds: 5
          readinessProbe:
            httpGet:
              path: /
              port: 8080
            initialDelaySeconds: 10
            periodSeconds: 10
            timeoutSeconds: 1
            failureThreshold: 3
          ports:
            - name: http
              containerPort: 8080
              protocol: TCP
          env:
            - name: MSSQL_SERVER
              valueFrom:
                secretKeyRef:
                  name: mssql-tools
                  key: MSSQL_SERVER
            - name: MSSQL_DATABASE
              valueFrom:
                secretKeyRef:
                  name: mssql-tools
                  key: MSSQL_DATABASE
            - name: MSSQL_USER
              valueFrom:
                secretKeyRef:
                  name: mssql-tools
                  key: MSSQL_USER
            - name: MSSQL_PASSWORD
              valueFrom:
                secretKeyRef:
                  name: mssql-tools
                  key: MSSQL_PASSWORD
            - name: TZ
              value: America/Buenos_Aires
          resources:
            requests:
              memory: '128Mi'
              cpu: '250m'
            limits:
              memory: '256Mi'
              cpu: '500m'
```
