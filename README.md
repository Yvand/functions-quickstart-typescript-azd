---
name: Azure Functions TypeScript HTTP Trigger using Azure Developer CLI
description: This repository contains an Azure Functions HTTP trigger quickstart written in TypeScript and deployed to Azure Functions Flex Consumption using the Azure Developer CLI (azd). The sample uses managed identity and a virtual network to make sure deployment is secure by default.
page_type: sample
languages:
- azdeveloper
- bicep
- nodejs
- typescript
products:
- azure
- azure-functions
- entra-id
urlFragment: functions-quickstart-typescript-azd
---

# Azure Functions TypeScript HTTP Trigger using Azure Developer CLI

This fork aims to provide a template which deploys resources to run Azure functions, with a more secure approach compared to [its parent project](https://github.com/Azure-Samples/functions-quickstart-typescript-azd).

## Notable changes compared to parent project

TODO

## Initialize the local project

You can initialize a project from this `azd` template in one of these ways:

+ Use this `azd init` command from an empty local (root) folder:

    ```shell
    azd init --template Yvand/functions-quickstart-typescript-azd
    ```

    Supply an environment name, such as `flexquickstart` when prompted. In `azd`, the environment is used to maintain a unique deployment context for your app.

+ Clone the GitHub template repository locally using the `git clone` command:

    ```shell
    git clone https://github.com/Yvand/functions-quickstart-typescript-azd.git
    cd functions-quickstart-typescript-azd
    ```

    You can also clone the repository from your own fork in GitHub.

## Additional documentation

Please refer to [its parent project](https://github.com/Azure-Samples/functions-quickstart-typescript-azd).
