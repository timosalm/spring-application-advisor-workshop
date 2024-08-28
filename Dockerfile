# syntax=docker/dockerfile:1
FROM ghcr.io/vmware-tanzu-labs/educates-base-environment

USER root

RUN yum install maven -y

RUN curl -s "https://get.sdkman.io" | bash && \
    echo "sdkman_auto_answer=true" > $HOME/.sdkman/etc/config && \
    echo "sdkman_auto_selfupdate=false" >> $HOME/.sdkman/etc/config && \
    source "$HOME/.sdkman/bin/sdkman-init.sh" && \
    sdk install java $(sdk list java | grep  "17.*[0-9]-librca" | awk '{print $NF}' | head -n 1) && \
    sdk install java $(sdk list java | grep  "11.*[0-9]-librca" | awk '{print $NF}' | head -n 1)


RUN --mount=type=secret,id=broadcom_artifactory_token --mount=type=secret,id=app_advisor_version \
  curl -v -L -H "Authorization: Bearer $(cat /run/secrets/broadcom_artifactory_token)" -o advisor-cli.tar https://packages.broadcom.com/artifactory/spring-enterprise/com/vmware/tanzu/spring/application-advisor-cli-linux/$(cat /run/secrets/app_advisor_version)/application-advisor-cli-linux-$(cat /run/secrets/app_advisor_version).tar && \
  tar -xf advisor-cli.tar --strip-components=1 --exclude=./META-INF && rm advisor-cli.tar && \
  mv advisor /usr/local/bin/

COPY <<EOF mvn-settings.xml
<settings xmlns="http://maven.apache.org/SETTINGS/1.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
  xsi:schemaLocation="http://maven.apache.org/SETTINGS/1.0.0 https://maven.apache.org/xsd/settings-1.0.0.xsd">
    <servers>
        <server>
            <id>spring-enterprise-subscription</id>
            <username>BROADCOM_ARTIFACTORY_USER_EMAIL</username>
            <password>BROADCOM_ARTIFACTORY_TOKEN</password>
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
RUN --mount=type=secret,id=broadcom_artifactory_token --mount=type=secret,id=broadcom_artifactory_user_email \
  sed -i.bak -e "s/BROADCOM_ARTIFACTORY_USER_EMAIL/$(cat /run/secrets/broadcom_artifactory_user_email)/" -e "s/BROADCOM_ARTIFACTORY_TOKEN/$(cat /run/secrets/broadcom_artifactory_token)/" mvn-settings.xml
RUN --mount=type=secret,id=app_advisor_commercial_recipes_version \
  echo "mvn dependency:get -DrepoUrl=https://packages.broadcom.com/artifactory/spring-enterprise -Dartifact=com.vmware.tanzu.spring.recipes:spring-boot-3-upgrade-recipes:$(cat /run/secrets/app_advisor_commercial_recipes_version) -s mvn-settings.xml"
RUN rm mvn-settings.xml

COPY --chown=1001:0 . /home/eduk8s/

RUN fix-permissions /home/eduk8s

USER 1001