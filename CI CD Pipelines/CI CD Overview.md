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

## Jenkins

There are many types of jobs Jenkins can run, we will start with the freestyle project type.

![[Pasted image 20240320120037.png]]

You can connect it to GitHub and Git

![[Pasted image 20240320120130.png]]
![[Pasted image 20240320120122.png]]

You can have it execute a shell script
![[Pasted image 20240320120153.png]]

You can set build triggers
![[Pasted image 20240320120205.png]]

You can manually build jobs and see the build history
![[Pasted image 20240320120408.png]]

You can see the build status, console output and build info
![[Pasted image 20240320120450.png]]

## Add a GitHub Repo to Jenkins via SSH

Add the GitHub HTTPS URL under the GitHub Project section
![[Pasted image 20240320132941.png]]

Choose Git for Source Code Management
![[Pasted image 20240320132957.png]]

Add the SSH URL as Repo URL
![[Pasted image 20240320133016.png]]

Add the SSH Private Key
![[Pasted image 20240320133136.png]]

You should have no errors
![[Pasted image 20240320133204.png]]

If it has any red errors, something is wrong!
![[Pasted image 20240320133227.png]]