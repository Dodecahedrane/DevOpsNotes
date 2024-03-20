---
tags:
  - DevOps
  - CICD
---
## Continuous Integration

The CI part is the practice of integrating all the code changes into the main branch of the code repository as early and often as possible, with automatic testing of of these changes (build, unit test, linting, etc.). This catches error and build issues as early as possible, as the code is merged often it also resolves the issues of large merge conflicts that can arise when a large team work on the same code base.

## Continuous Deployment

The CD part happens in conjunction with the CI part. This is where the application is deployed to the end users. This could be by updating a web server with new contents, or by releasing a new version to download. You can do this regularly as the CI part (should) fully test your code and catch any errors before it reaches the deployment stage.

This process is automated, so requires little to no human intervention to occur, allowing for patches and changes to go out to your users quickly, giving them the best experience possible. 

## Delivery vs Deployment

Deployment = automated
Delivery = manual
## Building CI/CD Pipelines

- Commit
- Build
- Test
	- Unit
	- Integration
	- Regression
- Stage
	- Mirror of the prod environment for QA Testing
- Deploy Dev/QA
	- Possible manual QA evaluation process
- Production/End Users

### Parts of the testing pipeline

- Unit Tests
	- Unit tests validate specific code functions work as expected and designed
- Integration Tests
	- Integration tests check separate but connected code works together as expected. Such as the interaction between a frontend and an API
- Regression Tests
	- Regression tests ensure changes do no introduce unintended breaks in the code

### CI/CD Platforms

- GitHub Actions
- GitLab
- Jenkins
- TeamCity
- Azure DevOps
- AWS DevOps

