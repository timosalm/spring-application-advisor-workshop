# syntax=docker/dockerfile:1
FROM ghcr.io/vmware-tanzu-labs/educates-base-environment

USER root

RUN --mount=type=secret,id=broadcom_artifactory_token \
  BROADCOM_ARTIFACTORY_TOKEN=$(cat /run/secrets/broadcom_artifactory_token)
RUN --mount=type=secret,id=broadcom_artifactory_user_email \
  cat /run/secrets/broadcom_artifactory_user_email
RUN --mount=type=secret,id=app_advisor_version \
  cat /run/secrets/app_advisor_version

# RUN yum install maven -y

# RUN curl -s "https://get.sdkman.io" | bash && \
#     echo "sdkman_auto_answer=true" > $HOME/.sdkman/etc/config && \
#     echo "sdkman_auto_selfupdate=false" >> $HOME/.sdkman/etc/config && \
#     source "$HOME/.sdkman/bin/sdkman-init.sh" && \
#     sdk install java $(sdk list java | grep  "17.*[0-9]-librca" | awk '{print $NF}' | head -n 1) && \
#     sdk install java $(sdk list java | grep  "11.*[0-9]-librca" | awk '{print $NF}' | head -n 1)


RUN echo $APP_ADVISOR_VERSION

RUN curl -v -L -H "Authorization: Bearer $BROADCOM_ARTIFACTORY_TOKEN" -o advisor-cli.tar https://packages.broadcom.com/artifactory/spring-enterprise/com/vmware/tanzu/spring/application-advisor-cli-linux/${APP_ADVISOR_VERSION}/application-advisor-cli-linux-${APP_ADVISOR_VERSION}.tar && \
    tar -xf advisor-cli.tar --strip-components=1 --exclude=./META-INF && rm advisor-cli.tar && \
    mv advisor /usr/local/bin/

COPY <<EOF $HOME/.m2/settings.xml
<settings xmlns="http://maven.apache.org/SETTINGS/1.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
  xsi:schemaLocation="http://maven.apache.org/SETTINGS/1.0.0 https://maven.apache.org/xsd/settings-1.0.0.xsd">
    <servers>
        <server>
            <id>spring-enterprise-subscription</id>
            <username>$BROADCOM_ARTIFACTORY_USER_EMAIL</username>
            <password>$BROADCOM_ARTIFACTORY_TOKEN</password>
        </server>
    </servers>
    <profiles>
        <profile>
            <id>spring-enterprise</id>
            <activation>
                <activeByDefault>true</activeByDefault>
            </activation>
            <repositories>
                <repository>
                    <id>spring-enterprise-subscription</id>
                    <url>https://packages.broadcom.com/artifactory/spring-enterprise</url>
                </repository>
            </repositories>
            <pluginRepositories>
                <pluginRepository>
                    <id>spring-enterprise-subscription</id>
                    <url>https://packages.broadcom.com/artifactory/spring-enterprise</url>
                </pluginRepository>
            </pluginRepositories>
        </profile>
    </profiles>
    <activeProfiles>
        <activeProfile>spring-enterprise</activeProfile>
    </activeProfiles>
</settings>
EOF

RUN mvn dependency:get -DrepoUrl=https://packages.broadcom.com/artifactory/spring-enterprise -Dartifact=com.vmware.tanzu.spring.recipes:spring-boot-3-upgrade-recipes:$APP_ADVISOR_VERSION

COPY --chown=1001:0 . /home/eduk8s/

RUN fix-permissions /home/eduk8s

USER 1001