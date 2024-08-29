---
title: Workshop Instructions
---

```execute
git clone {{< param  git_protocol >}}://{{< param  git_host >}}/spring-petclinic && cd spring-petclinic
```

```terminal:execute
command: cd spring-petclinic && ./mvnw spring-boot:run
session: 2
```

WARNING: TAKES around 5 min, feel free to continue and come back

```dashboard:open-url
url: {{< param  ingress_protocol >}}://petclinic-{{< param  session_name >}}.{{< param  ingress_domain >}}
```

```terminal:interrupt
session: 2
```

```execute
advisor --help
```

```execute
advisor build-config get
```

```editor:open-file
file: ~/spring-petclinic/target/.advisor/build-config.json
```

```execute
advisor build-config publish --url=${APP_ADVISOR_SERVER}
```

```execute
advisor upgrade-plan get --url=${APP_ADVISOR_SERVER}
```

# Step 1: Upgrade java from 8 to 11

```execute
advisor upgrade-plan apply --url=${APP_ADVISOR_SERVER}
```

```editor:execute-command
command: workbench.view.scm
description: Open Source Control view in editor
```

# Step 2: Upgrade java from 11 to 17

```execute
advisor build-config get
advisor build-config publish --url=${APP_ADVISOR_SERVER}
advisor upgrade-plan get --url=${APP_ADVISOR_SERVER}
advisor upgrade-plan apply --url=${APP_ADVISOR_SERVER}
```

```editor:execute-command
command: workbench.view.scm
description: Open Source Control view in editor
```

```terminal:execute
command: sdk use java $(sdk list java | grep installed | grep  "17.*[0-9]-librca" | awk '{print $NF}' | head -n 1)
session: 1
cascade: true
```
```terminal:execute
command: sdk use java $(sdk list java | grep installed | grep  "17.*[0-9]-librca" | awk '{print $NF}' | head -n 1)
session: 2
hidden: true
```
```terminal:execute
command: ./mvnw spring-boot:run
session: 2
```

Spring Application Advisor preserves your coding style by doing the minimum required changes in the source files. However, if you are using a Maven or Gradle formatter like spring-javaformat for your repository, add the --after-upgrade-cmd option to the advisor upgrade-plan apply command as follows.

```execute
git restore .
```

```execute
advisor upgrade-plan apply --url=${APP_ADVISOR_SERVER} --after-upgrade-cmd=spring-javaformat:apply
```
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

# Step 3: Upgrade spring-boot from 2.7.x to 3.0.x & more

```execute
advisor build-config get
advisor build-config publish --url=${APP_ADVISOR_SERVER}
advisor upgrade-plan get --url=${APP_ADVISOR_SERVER}
advisor upgrade-plan apply --url=${APP_ADVISOR_SERVER} --after-upgrade-cmd=spring-javaformat:apply
```

```editor:execute-command
command: workbench.view.scm
description: Open Source Control view in editor
```

```terminal:execute
command: ./mvnw spring-boot:run
session: 2
```

# Step 4: Upgrade spring-boot from 3.0.x to 3.1.x & more
```execute
advisor build-config get
advisor build-config publish --url=${APP_ADVISOR_SERVER}
advisor upgrade-plan get --url=${APP_ADVISOR_SERVER}
advisor upgrade-plan apply --url=${APP_ADVISOR_SERVER} --after-upgrade-cmd=spring-javaformat:apply
```

# Step 5: Upgrade spring-boot from 3.1.x to 3.2.x & more
```execute
advisor build-config get
advisor build-config publish --url=${APP_ADVISOR_SERVER}
advisor upgrade-plan get --url=${APP_ADVISOR_SERVER}
advisor upgrade-plan apply --url=${APP_ADVISOR_SERVER} --after-upgrade-cmd=spring-javaformat:apply
```

# Step 5: Upgrade spring-boot from 3.2.x to 3.3.x & more
```execute
advisor build-config get
advisor build-config publish --url=${APP_ADVISOR_SERVER}
advisor upgrade-plan get --url=${APP_ADVISOR_SERVER}
advisor upgrade-plan apply --url=${APP_ADVISOR_SERVER} --after-upgrade-cmd=spring-javaformat:apply
```





