FROM eclipse-temurin:21-jre-alpine

USER root

RUN apk add curl

USER 1001

RUN --mount=type=secret,id=broadcom_artifactory_token --mount=type=secret,id=app_advisor_version \
  curl -L -H "Authorization: Bearer $(cat /run/secrets/broadcom_artifactory_token)" -o upgrade-service.jar https://packages.broadcom.com/artifactory/spring-enterprise/com/vmware/tanzu/spring/application-advisor-server/$(cat /run/secrets/app_advisor_version)/application-advisor-server-$(cat /run/secrets/app_advisor_version).jar

ENTRYPOINT ["java","-jar","/upgrade-service.jar"]
