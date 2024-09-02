---
title: Running Final Upgrade Steps 
---

In this section, we will rerun the `advisor build-config`, and `advisor upgrade-plan` commands to upgrade our code base to the latest Spring Boot release.

By adding the `--debug` option to `advisor build-config get` and `advisor upgrade-plan apply`, we are able to get a better understanding of what's happening underneath, for example which OpenRewrite recipes are getting applied.
```terminal:execute
command: |
  advisor build-config get --debug
  advisor build-config publish --url=${APP_ADVISOR_SERVER}
  advisor upgrade-plan get --url=${APP_ADVISOR_SERVER}
  advisor upgrade-plan apply --url=${APP_ADVISOR_SERVER} --after-upgrade-cmd=spring-javaformat:apply --debug
```

After making yourself aware of all the changes of the Spring Boot 3.0.x to 3.1.x update, **commit and push them**.
```editor:execute-command
command: workbench.view.scm
description: Open the Source Control view in editor
```

#### (Optional) Upgrade to the latest Spring Boot release
```terminal:execute
command: |
  advisor build-config get
  advisor build-config publish --url=${APP_ADVISOR_SERVER}
  advisor upgrade-plan get --url=${APP_ADVISOR_SERVER}
  advisor upgrade-plan apply --url=${APP_ADVISOR_SERVER} --after-upgrade-cmd=spring-javaformat:apply
description: Upgrade Sprin Boot from 3.1.x to 3.2.x
cascade: true
```
```terminal:execute
command: sed -i 's/>11</>17</g' pom.xml
description: Fix bug with OSS OpenRewrite recipe
hidden: true
cascade: true
```
```editor:execute-command
command: workbench.view.scm
description: Open the Source Control view in editor
```
After making yourself aware of all the changes, **commit and push them**.


```terminal:execute
command: |
  advisor build-config get
  advisor build-config publish --url=${APP_ADVISOR_SERVER}
  advisor upgrade-plan get --url=${APP_ADVISOR_SERVER}
  advisor upgrade-plan apply --url=${APP_ADVISOR_SERVER} --after-upgrade-cmd=spring-javaformat:apply
description: Upgrade Sprin Boot from 3.2.x to 3.3.x
cascade: true
```
```editor:execute-command
command: workbench.view.scm
description: Open the Source Control view in editor
```
After making yourself aware of all the changes, **commit and push them**.

Finally, let's check one more time that everything still works after we upgraded our application from 2.7 to the latest Spring Boot version!
```terminal:execute
command: ./mvnw spring-boot:run
session: 2
```

```dashboard:open-url
url: {{< param  ingress_protocol >}}://petclinic-{{< param  session_name >}}.{{< param  ingress_domain >}}
```

```terminal:interrupt
session: 2
```