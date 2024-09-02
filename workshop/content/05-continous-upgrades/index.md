---
title: Continuous And Incremental Upgrades
---

As you saw, *Spring Application Advisor* is able to continuously and incrementally upgrade your Spring dependencies in all your Git repositories. The only thing developers still have to do is to review the changes applied for an upgrade.

The recommend way to integrate *Spring Application Advisor* into your software development process is via a seperate CI pipeline that is scheduled to run for example every day or as part of your CI/CD pipelines after every build.

The automatic pull requests feature will inform the developers team about the changes, and merging it after the review will trigger the default CI/CD pipeline.

Documentation on how to setup *Spring Application Advisor* for different CI/CD providers is available [here](https://docs.vmware.com/en/Tanzu-Spring-Runtime/Commercial/Tanzu-Spring-Runtime/app-advisor-integrate-with-ci-cd.html).