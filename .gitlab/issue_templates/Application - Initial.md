## Summary

Requesting application to be hardened. This is only for initial hardening of a container.


## Version Information

Current version: (State the current version of the application as you see it)

## Communication

All communication should occur through this issue. This ensures that all information is documented in a centralized location and also ensures that all of the assignees are notified of updates. It is imperative that all required parties are listed as assignees of this issue and that individuals are not removed. Please do not remove anyone from the assignee list.

If you need to contact the Container Hardening team, please identify your assigned point of contact. You can find your point of contact by:
1. They should be listed as an assignee on this ticket
2. They should be listed in the `hardening_manifest.yaml` file under the `maintainers` section with a field of `cht_member: true`

If you have no assignee, feel free to tag Container Hardening leadership in your issue by commenting on this issue with your questions/concerns and then add `/cc @ironbank-notifications/leadership`. Gitlab will automatically notify all Container Hardening leadership to look at this issue and respond.

##  Get Unstuck/AMA:  
Iron Bank Get Unstuck/AMA Working Sessions every Wednesday from 1630-1730EST.  
Need some help with your containers getting through Iron Bank? Have questions on where things are at? Are you feeling stuck and want to figure out the next steps? This is the meeting for you! Come meet with the Iron Bank leadership and engineers to get answers to your questions. 
 Register in advance for this meeting: https://www.zoomgov.com/meeting/register/vJIsf-ytpz8qHSN_JW8Hl9Qf0AZZXSCSmfo  
After registering, you will receive a confirmation email containing information about joining the meeting. 
 
If you have any questions, please come to our Get Unstuck/AMA sessions. There we will have the right combination of business folks and engineers to get your questions answered.

## Responsibilities

If this application is owned by a Contributor or Vendor (identifed as `Owner::Contributor` and `Owner::Vendor` respectively), then it is your responsibility to drive this issue through completion. This means that the Container Hardening team is not here to help push any deadlines/timeframes you may have with other customers or DoD agencies. If you have issues with the activity, you may notify Container Hardening leadership above. Do not change the ownership labels.


## Definition of Done


This checklist is meant to provide a high level overview of the process and steps for getting your container(s) onto Iron Bank. 

- [ ] Create a Repo1 account (https://repo1.dso.mil/users/sign_in) to get access to the public repository of containers. You can register by clicking on the 'Sign in with Iron Bank SSO' button in the sign-in page, followed by the Register button

- [ ] Fill out the onboarding form: https://p1.dso.mil/#/products/iron-bank/getting-started 

- [ ] Attend our once weekly onboarding session where you can ask questions. [Register here](https://www.zoomgov.com/meeting/register/vJIsce6rpzkqGq9hHHRscNfGENYqvRL1s10%E2%81%A9).

- [ ] Your Onboarding form will be processed by the Iron Bank team, who will then assign it a priority level and create your repository. You will receive an email that your Gitlab issue has been created and is ready for you to complete the hardening process

- [ ] Ensure that all POCs are assigned to the issue to ensure proper tracking and notifications

## Hardening Process

### Repository Requirements

[Full documentation](https://repo1.dso.mil/dsop/dccscr/-/blob/master/Hardening/structure_requirements.md)

- [ ] A Dockerfile has been created in the root of the repository

- [ ] Hardening_manifest.yaml has been created in the root of the repository

- [ ] The project has a LICENSE or a copy of the EULA

- [ ] The project has a README in the root of the repository with sufficient instructions on using the Iron Bank version of the image

- [ ] If your container is an enterprise/commercial container, the opensource version is ready

- [ ] Scripts used in the Dockerfile are placed into a `scripts` directory

- [ ] Configuration files are placed into a `config` directory

- [ ] Project is [configured for automatic renovate updates](https://repo1.dso.mil/dsop/dccscr/-/blob/master/Hardening/Renovate.md) (if possible)

  - [ ] Renovate.json is present in root of repository

  - [ ] Reviewers have been specified for notifications on new merge requests

### Dockerfile Requirements 

[Full documentation](https://repo1.dso.mil/dsop/dccscr/-/blob/master/Hardening/Dockerfile_Requirements.md)

- [ ] There is one Dockerfile named Dockerfile

- [ ] The Dockerfile has the BASE_REGISTRY, BASE_IMAGE, and BASE_TAG arguments (used for local builds; the values in hardening_manifest.yaml are what will be used in the Container Hardening Pipeline)

- [ ] The Dockerfile is [based on a hardened Iron Bank image](https://repo1.dso.mil/dsop/dccscr/-/blob/master/Hardening/Dockerfile_Requirements.md#requirements)

- [ ] The Dockerfile includes a HEALTHCHECK (required if it is an application container)

- [ ] The Dockerfile starts the container as a non-root USER. Otherwise, if you must run as root, you must have proper justification.

- [ ] If your ENTRYPOINT entails using a script, the script is copied from a scripts directory on the project root

- [ ] No ADD instructions are used in the Dockerfile

## Hardening Manifest

[Full documentation](https://repo1.dso.mil/dsop/dccscr/-/tree/master/hardening%20manifest)

- [ ] Begin with this example and update with relevant information: https://repo1.dso.mil/dsop/dccscr/-/blob/master/hardening%20manifest/hardening_manifest.yaml

- [ ] Hardening manifest adheres to the following schema: https://repo1.dsop.io/ironbank-tools/ironbank-pipeline/-/blob/master/schema/hardening_manifest.schema.json

- [ ] The BASE_IMAGE and BASE_TAG arguments refer to a hardened/approved Iron Bank image (BASE_REGISTRY defaults to `registry1.dso.mil/ironbank` in the pipeline)

- [ ] Relevant image metadata has been entered for the corresponding labels

- [ ] Any downloaded resources include a checksum for verification (letters must be lowercase)

- [ ] For resource URLs that require authentication, credentials have been provided to an Iron Bank team member

- [ ] The maintainers' contact information has been provided in the `maintainers` section

## Gitlab CI Pipeline

[Full documentation](https://repo1.dso.mil/dsop/dccscr/-/tree/master/pipeline)

- [ ] Validate your container builds successfully through the Gitlab CI pipeline. When viewing the repository in repo1.dso.mil, go to `CI/CD > Pipelines` on the left. From there, you can see the status of your pipelines.

- [ ] Review scan output from `csv output` stage of the pipeline. For instructions on downloading the findings spreadsheet, click [here](https://repo1.dso.mil/dsop/dccscr/-/blob/master/pre-approval/spreadsheet.md)

- [ ] Fix vulnerabilities that were found and run the pipeline again before requesting a merge to the development branch

## Pre-Approval:

[Full documentation](https://repo1.dso.mil/dsop/dccscr/-/tree/master/pre-approval)

- [ ] Submit a Merge Request to the development branch

- [ ] Feature branch has been merged into development

- [ ] All findings from the development branch pipeline have been justified per the above documentation

- [ ] Justifications have been attached to this issue

- [ ] Apply the `Approval` label and remove the `Doing` label to indicate this container is ready for the approval phase

_Note: The justifications must be provided in a timely fashion. Failure to do so could result in new findings being identified which may start this process over._

## Approval Process (Container Hardening Team processes):

[Full documentation](https://repo1.dso.mil/dsop/dccscr/-/tree/master/approval)

- [ ] Peer review from Container Hardening Team

- [ ] Findings Approver has reviewed and approved all justifications

- [ ] Approval request has been sent to Authorizing Official

- [ ] Approval request has been processed by Authorizing Official

One of the following statuses is assigned:

- [ ] Conditional approval has been granted by the Authorizing Official for this container (`Approval::Expiring` label is applied)

- [ ] This container has been approved by the Authorizing Official (`Approved` label is applied)

_Note: If the above approval process is kicked back for any reason, the `Approval` label will be removed and the issue will be sent back to `Open`. Any comments will be listed in this issue for you to address. Once they have been addressed, you may re-add the `Approval` label._

## Post-Approval

[Full documentation](https://repo1.dso.mil/dsop/dccscr/-/tree/master/post%20approval)

- [ ] Your issue has been closed

- [ ] Your project has been merged into master

- [ ] Master branch pipeline has completed successfully (at this point, the image is made available on `ironbank.dso.mil` and `registry1.dso.mil` )

_Note: Now that your application has been approved, your container(s) will be subjected to continuous monitoring. If new CVEs are discovered or bugs are identified, you will need to address the issues and return to step 5 (Gitlab CI Pipeline). As you make changes, please make sure you are adhering to all of the requirements of the hardening process._



### Continuous Monitoring

Once a container is approved, the `Approved` label will be applied to this issue and it will be closed. You will be able to find your applications on http://ironbank.dsop.io and https://registry1.dsop.io.

In addition to the above, your application will now be subscribed to continuous monitoring. This means that any new findings discovered as part of this will need justifications. To satisfy this process, any new findings will trigger a new Gitlab issue in this project with the label `Container::New Findings`. All members listed in the `maintainers` section of the `hardening_manifest.yaml` file will automatically be assigned. It is your responsibility as a Contributor or Vendor to monitor for this and provide justifications in a timely fashion. This newly created issue will have all the instructions necessary to complete the process. Failure to provide justifications could result in the revocation of the application's approval status.

### Updates

It is imperative that application updates be submitted as quickly as possible. We do not want applications to become stale. To help with this process, Ironbank recommends using a tool called [Renovate](https://github.com/renovatebot/renovate). This requires a `renovate.json` file to be placed in your project and can automate the creation of issues and merge requests.

If not using Renovate, it will be up to you as a Contributor or Vendor to keep this image up-to-date at all times. When you wish to submit an application update, you must create a new issue in this project using the `Application - Update` template and associate it with the corresponding merge request. If you submit a merge request alone, work will not proceed until a related issue is created. These issues are tracked using the label `Container::Update`.

Additionally, it is imperative that all updates must be followed through to completion. Simply submitting an application update but not following through on justifications and approvals does not suffice and risk your application's approval status being revoked.

### Bugs

Occassionally, users may file bug reports for your application. It is your responsibility to monitor for these since they are created inside your project repository. Assignees will automatically be populated by the `members` section of the `hardening_manifest.yaml` file and will have the label `Bug`.







/label ~"Container::Initial"