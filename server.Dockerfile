FROM eclipse-temurin:21-jre-alpine

USER root

RUN apk add curl
RUN --mount=type=secret,id=broadcom_artifactory_token --mount=type=secret,id=app_advisor_version \
  curl -L -H "Authorization: Bearer $(cat /run/secrets/broadcom_artifactory_token)" -o upgrade-service.jar https://packages.broadcom.com/artifactory/spring-enterprise/com/vmware/tanzu/spring/application-advisor-server/$(cat /run/secrets/app_advisor_version)/application-advisor-server-$(cat /run/secrets/app_advisor_version).jar
RUN chmod +x upgrade-service.jar
USER 1001

ENTRYPOINT ["java","-jar","/upgrade-service.jar"]
