FROM centos:7
MAINTAINER devops
RUN yum install -y https://repo.ius.io/ius-release-el7.rpm && \
yum install -y python36u python36u-libs python36u-devel python36u-pip
COPY requirements.txt /opt
RUN pip3 install -r /opt/requirements.txt
LABEL environment=prod \
     type=web
EXPOSE 8000
COPY devops-gl /opt/maindir
WORKDIR /opt/maindir
RUN python3 manage.py migrate && python3 manage.py makemigration
CMD ["python3", "manage.py", "runserver", "0.0.0.0:8000"]

