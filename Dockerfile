# SQL Server Command Line Tools - custom image
#FROM quay.io/centos7/s2i-base-centos7
FROM centos:centos7

# Labels
LABEL maintainer="desarollo@pqs.com.ar"
LABEL org.label-schema.schema-version="1.0"
LABEL org.label-schema.name="mssql-tools-centos7"
LABEL org.label-schema.description="mssql-tools image for openshift"
LABEL org.label-schema.url="http://pqs.com.ar"

RUN  rpm --import https://packages.microsoft.com/keys/microsoft.asc && curl -o /etc/yum.repos.d/mssql-release.repo https://packages.microsoft.com/config/rhel/7/prod.repo && ACCEPT_EULA=Y yum install -y  glibc e2fsprogs krb5-libs openssl unixODBC msodbcsql mssql-tools unixODBC-devel nc && yum clean all -y

ADD ./uid_entrypoint.sh ./
ADD ./init.sh ./
RUN chown 1001:0 *.sh && chmod +wx *.sh

RUN chmod g=u /etc/passwd
ENV PATH $PATH:/opt/mssql-tools/bin

USER 1001
ENTRYPOINT [ "./uid_entrypoint.sh" ]


CMD ["./init.sh"]