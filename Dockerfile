FROM mwaeckerlin/ubuntu-base
MAINTAINER mwaeckerlin
ENV TERM xterm

ENV DOMAIN        ""
ENV ORGANIZATION  ""
ENV PASSWORD      ""
ENV DEBUG         1

RUN echo "slapd slapd/password1 password test" | debconf-set-selections
RUN echo "slapd slapd/password2 password test" | debconf-set-selections
RUN apt-get update
RUN apt-get install -y slapd ldap-utils debconf-utils pwgen
RUN mv /etc/ldap /etc/ldap.original
RUN mv /var/lib/ldap /var/lib/ldap.original
RUN mkdir /etc/ldap /var/lib/ldap
RUN chown openldap.openldap /etc/ldap /var/lib/ldap
ADD start.sh /start.sh
CMD /start.sh

EXPOSE 389
EXPOSE 636

VOLUME /ssl
VOLUME /var/backups
VOLUME /etc/ldap
VOLUME /var/lib/ldap