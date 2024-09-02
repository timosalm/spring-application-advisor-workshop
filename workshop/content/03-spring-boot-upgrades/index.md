---
title: Spring Boot 2.7 to 3.0 Upgrade
---

Finally, it's time for a more complex upgrade of our sample application that really shows what **Spring Application Advisor** can do for you - the upgrade from Spring Boot 2.7 to 3.0.


First, we need the latest upgrade plan.
```execute
advisor build-config get
advisor build-config publish --url=${APP_ADVISOR_SERVER}
advisor upgrade-plan get --url=${APP_ADVISOR_SERVER}
```

Let's run the Spring Boot 2.7 to 3.0 upgrade.
```execute
advisor upgrade-plan apply --url=${APP_ADVISOR_SERVER} --after-upgrade-cmd=spring-javaformat:apply
```

By switching to the Source Control view in embedded editor, you can have a closer look at all the changes applied to our code base.
```editor:execute-command
command: workbench.view.scm
description: Open the Source Control view in editor
```
After making yourself aware of all the changes, **commit and push them**.

Feel free to also run the application to ensure everyting still works.
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


