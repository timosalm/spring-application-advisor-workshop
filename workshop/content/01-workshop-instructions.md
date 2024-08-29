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

```execute
advisor upgrade-plan apply --url=${APP_ADVISOR_SERVER}
```

```editor:execute-command
command: workbench.view.scm
description: Open Source Control view in editor
```

```execute
sdk use java $(sdk list java | grep installed | grep  "17.*[0-9]-librca" | awk '{print $NF}' | head -n 1)
```


