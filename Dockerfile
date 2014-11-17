#FROM centos:centos6
FROM docker.cn/docker/centos:centos6

MAINTAINER timesking <timesking@gmail.com>

#RUN cp /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo.bak
#RUN curl http://mirrors.163.com/.help/CentOS6-Base-163.repo > /etc/yum.repos.d/CentOS-Base.repo


RUN rpm -ivh http://nginx.org/packages/centos/6/noarch/RPMS/nginx-release-centos-6-0.el6.ngx.noarch.rpm
RUN yum -y install nginx which openssh-server php php-devel php-mysql php-cli php-gd php-process php-fpm php-mbstring php-ldap php-pecl-apc php-pecl-json git subversion mercurial
RUN yum clean all

# Download Phabricator bundle.
RUN mkdir -p /srv/www/phabricator

# Create a directory for the source code.
RUN mkdir -p /srv/repo/

RUN mv /etc/nginx/conf.d/default.conf /etc/nginx/conf.d/default.conf.bak
ADD etc/phabricator.conf /etc/nginx/conf.d/phabricator.conf

ADD scripts /scripts
RUN chmod +x /scripts/start.sh
RUN touch /first_run

# Expose our web root and log directories log.
VOLUME ["/srv/www/phabricator", "/srv/git", "/var/log"]

# Kicking in
CMD ["/scripts/start.sh"]

##TODO, sendmail, repo, local path, uri, apc.stat=0, mercucial
##https://secure.phabricator.com/book/phabricator/article/utf8/
