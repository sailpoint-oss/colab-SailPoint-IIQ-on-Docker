# SailPoint IdentityIQ on Docker

A complete Docker-based development environment for SailPoint IdentityIQ (IIQ), designed to simplify local development, testing, onboarding, and connector validation.

This project provides a ready-to-use infrastructure for SailPoint IdentityIQ using Docker Compose, including SQL Server, OpenLDAP, Mailhog, preconfigured connectors, aggregation tasks, and SSB support.

> ⚠️ This repository DOES NOT contain any proprietary SailPoint binaries.
> You must obtain the required files directly from the SailPoint Compass portal.

---

# Tested With

- IdentityIQ 8.5
- IdentityIQ 8.5p1
- SSB v7.0.2
- SQL Server 2019
- Docker Compose v2
- OpenJDK 11
- Tomcat 9

---

# Architecture

```text
+--------------------------------------------------+
|               SailPoint IdentityIQ               |
|              Tomcat + OpenJDK + SSB              |
+--------------------------------------------------+
                     |
                     |
         +-----------------------+
         |     SQL Server 2019   |
         +-----------------------+
              |             |
              |             |
              v             v
        IdentityIQ      AppMock

                     |
         --------------------------------
         |                              |
         v                              v

   OpenLDAP                         Mailhog
```

---

# Features

- Docker-based SailPoint IdentityIQ environment
- Fast local development setup
- SSB (Standard Services Build) support
- SQL Server integration
- OpenLDAP integration
- Mailhog SMTP integration
- JDBC connector examples
- Delimited File connector
- Aggregation tasks preconfigured
- Provisioning examples for Accounts and Groups
- Support for custom SQL scripts
- Support for custom OpenLDAP attributes
- Development-ready environment

---

# Included Connectors

This environment includes 3 preconfigured applications with aggregation tasks.

## 1. Delimited File Connector (Human Resources)

- Dominant application
- Identity aggregation ready

## 2. JDBC Application

- Account provisioning
- Group provisioning
- Aggregation tasks included

## 3. OpenLDAP Application

- Account provisioning
- Group provisioning
- Aggregation tasks included

---

# Requirements

Before starting, ensure you have:

- Docker
- Docker Compose
- Access to SailPoint Compass
- Valid SailPoint IdentityIQ license

Download the following binaries from SailPoint Compass:

```text
identityiq-8.5.zip
identityiq-8.5p1.jar
ssb-v7.0.2.zip
```

---

# Clone Repository

```bash
git clone https://github.com/luisfpadovani/docker-iiq-sailpoint.git
cd docker-iiq-sailpoint
```

---

# Configure SailPoint Binaries (Required)

Place the downloaded files in the following directories.

## IdentityIQ GA

```text
tomcat/file_install/ssb/base/ga/
└── identityiq-8.5.zip
```

## IdentityIQ Patch

```text
tomcat/file_install/ssb/base/patch/
└── identityiq-8.5p1.jar
```

## SSB

```text
tomcat/file_install/
└── ssb.zip
```

Rename:

```text
ssb-v7.0.2.zip → ssb.zip
```

---

# Configure Database Scripts (Required)

Move the SQL scripts to:

```text
sqlserver_iiq/scripts
```

Rename the files using the following order.

## Database Creation

```text
create_identityiq_tables-8.5.sqlserver
→ 1-create_identityiq_tables-8.5.sqlserver
```

## Database Upgrade

```text
upgrade_identityiq_tables.sqlserver
→ 2-upgrade_identityiq_tables.sqlserver
```

## Patch Upgrade

```text
upgrade_identityiq_tables-8.5p1.sqlserver
→ 3-upgrade_identityiq_tables-8.5p1.sqlserver
```

---

# Extract Patch Upgrade Script

To extract the patch upgrade SQL script from the patch JAR file, use:

```bash
jar xvf identityiq-8.5p1.jar
```

---

# Important Database Notes

You MUST change the default passwords inside:

```text
create_identityiq_tables-8.5.sqlserver
```

Recommended password:

```text
Change@123
```

Update the following users:

- IdentityIQ
- IdentityIQPlugin

---

# Custom SQL Scripts

If you need custom database scripts (for extended attributes or custom structures), add them using the following naming convention:

```text
4-custom.sqlserver
5-custom.sqlserver
...
n-custom.sqlserver
```

Place them in:

```text
sqlserver_iiq/scripts
```

Docker Compose automatically executes scripts sequentially.

---

# Disable Mock Applications (Optional)

If you do NOT want the fake applications and demo configurations, add the following entries to:

```text
docker.ignorefiles.properties
```

```text
Application/Application-HumanResources.xml
Application/Application-Jdbc.xml
Application/Application-Openldap.xml
CorrelationConfig/CorrelationConfig-HumanResourcesEmployee.xml
CorrelationConfig/CorrelationConfig-JdbcEmployee.xml
CorrelationConfig/CorrelationConfig-Openldap.xml
Form/Form-CreateAccountJdbc.xml
Form/Form-CreateAccountOpenldap.xml
Form/Form-CreateGroupJdbc.xml
Form/Form-CreateGroupOpenldap.xml
Form/Form-UpdateAccountJdbc.xml
Form/Form-UpdateGroupJdbc.xml
Form/Form-UpdateGroupOpenldap.xml
ObjectConfig/ObjectConfig-IdentityHumanResources.xml
Rule/Rule-HumanResourcesBuildmapEmployee.xml
Rule/Rule-HumanResourcesCreationEmployee.xml
Rule/Rule-HumanResourcesEmail.xml
Rule/Rule-HumanResourcesFirstName.xml
Rule/Rule-HumanResourcesLastName.xml
Rule/Rule-HumanResourcesManager.xml
Rule/Rule-HumanResourcesName.xml
Rule/Rule-HumanResourcesStatus.xml
Rule/Rule-HumanResourcesType.xml
Rule/Rule-IdentityGetEmployee.xml
Rule/Rule-IdentityGetFirstname.xml
Rule/Rule-IdentityGetFullName.xml
Rule/Rule-IdentityGetLastname.xml
Rule/Rule-JdbcCreateProvision.xml
Rule/Rule-JdbcDeleteProvision.xml
Rule/Rule-JdbcDisableProvision.xml
Rule/Rule-JdbcEnableProvision.xml
Rule/Rule-JdbcSetNameGroup.xml
Rule/Rule-JdbcUpdateProvision.xml
Rule/Rule-OpenldapSetAccountDn.xml
Rule/Rule-OpenldapSetGroupDn.xml
Rule/Rule-RuleLibraryGetAttributesRequest.xml
Rule/Rule-SetGroupRequest.xml
SystemConfiguration/SystemConfiguration-Email.xml
TaskDefinition/TaskDefinition-HumanResourcesAccountAggregation.xml
TaskDefinition/TaskDefinition-JdbcAccountAggregation.xml
TaskDefinition/TaskDefinition-JdbcGroupAggregation.xml
TaskDefinition/TaskDefinition-OpenLdapAccountAggregation.xml
TaskDefinition/TaskDefinition-OpenLdapGroupAggregation.xml
UI/UIConfig-Uiconfig.xml
```

---

# Start Containers

Run:

```bash
docker compose up
```

Or detached mode:

```bash
docker compose up -d
```

---

# Access IdentityIQ

After startup:

```text
http://localhost:8080/identityiq
```

---

# Container Descriptions

## TOMCAT

```text
tomcat:9.0.89-jdk11-temurin
```

Container running SailPoint IdentityIQ 8.5p1 with:

- OpenJDK 11
- Apache Tomcat 9
- SSB deployment

Includes a mounted volume:

```text
/opt/file
```

Used for fake identity data.

---

## SQL SERVER

```text
mcr.microsoft.com/mssql/server:2019-CU4-ubuntu-16.04
```

Hosts:

- IdentityIQ database
- IdentityIQPlugin database
- AppMock database

### Database Credentials

#### IdentityIQ

```text
Host: 10.5.0.3
User: IdentityIQ
Password: Change@123
```

#### IdentityIQPlugin

```text
Host: 10.5.0.3
User: IdentityIQPlugin
Password: Change@123
```

#### AppMock

```text
Host: 10.5.0.3
User: AppMock
Password: Change@123
```

---

## OPENLDAP

```text
osixia/openldap:1.5.0
```

Used to simulate a fake LDAP application.

Mounted volumes:

```text
/container/service/slapd/assets/config/bootstrap/schema/attributes.schema
/container/service/slapd/assets/config/bootstrap/ldif/custom/adata.ldif
```

### LDAP Credentials

```text
Host: 10.5.0.4
User: cn=admin,dc=corp1
Password: test1234
```

---

## MAILHOG

```text
mailhog/mailhog
```

SMTP server container used for email testing.

---

# Environment Variables (.ENV)

The repository includes a `.ENV` file with configurable parameters.

## OpenLDAP Variables

```text
LDAP_ADMIN_PASSWORD=
LDAP_BASE_DN=
LDAP_ORGANISATION=
LDAP_DOMAIN=
```

---

# Volume Variables

Recommended to customize only on Windows environments.

```text
LDAP_DATA_SCHEMA=
LDAP_DATA=
DIRECTORY_TOMCAT_APPLICATION=
```

---

# Windows Notes

It is recommended to customize mounted volume paths when running on Windows.

Update the `.ENV` file accordingly.

---

# Use Cases

This project is ideal for:

- Local IIQ development
- SailPoint training labs
- Connector testing
- SSB validation
- Rapid onboarding
- Demo environments
- CI/CD experiments
- Integration testing

---

# Notes

- This project is intended for development and learning purposes.
- SailPoint IdentityIQ is proprietary software.
- Do NOT publish SailPoint binaries to public repositories.
- Do NOT push SailPoint binaries to Docker registries.

---

# Contributing

Contributions are welcome.

Feel free to fork the repository and submit pull requests.

---

# Disclaimer

This project is NOT officially supported by SailPoint.

Use at your own risk.
