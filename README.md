# ZeroFailed.Sample.PowerPlatform

A sample repository that shows a Power Platform build and deployment process, set up with the [ZeroFailed.Build.PowerPlatform](https://github.com/zerofailed/ZeroFailed.Build.PowerPlatform) and [ZeroFailed.Deploy.PowerPlatform](https://github.com/zerofailed/ZeroFailed.Deploy.PowerPlatform) extensions.

> **Status:** early development. The extensions don't have any tasks yet, so the build and deployment processes run their stages without doing anything. The sample solution, pipelines and environment settings are added as the extensions gain features.

## Layout

| Path | Contents |
| --- | --- |
| `build.ps1` | Entry point for the build process |
| `.zf/build/` | Build configuration (`config.ps1`) and its extensions lock file |
| `deploy.ps1` | Entry point for the deployment process |
| `.zf/deploy/` | Deployment configuration (`config.ps1`) and its extensions lock file |
| `config/` | Settings for each environment: `common.ps1` holds the shared settings, and `<environment>.ps1` overrides them for one environment |

The build and deployment processes both define stages with the same names, such as `Init` and `Test`, so they can't be loaded in one InvokeBuild session. That's why each has its own entry point and its own `.zf` folder.

## Running locally

You need PowerShell 7.4 or later. The scripts install the other modules they need (InvokeBuild, ZeroFailed and the extensions).

```pwsh
# Run the build process
./build.ps1

# Run the deployment process for the 'dev' environment (the default)
./deploy.ps1

# Report the changes that a deployment to the 'test' environment would make, without making them
./deploy.ps1 -EnvironmentName test -PowerPlatformWhatIf
```

The what-if switch is called `-PowerPlatformWhatIf` rather than `-WhatIf`, because InvokeBuild reserves the name `WhatIf`.

### Environment settings

The sample holds no real tenant, subscription or environment IDs. Each one is read from an environment variable, or from a GitHub variable in the workflows:

| Variable | Setting |
| --- | --- |
| `ZF_SAMPLE_AZURE_TENANT_ID` | `azureTenantId`: the Entra tenant to sign in to |

When no tenant ID is set, the deployment doesn't sign in to Azure, so it can run offline.

### Using local copies of the extensions

By default, the extensions are installed from the `main` branch of their GitHub repositories. To try changes to the extensions before they're merged, clone them into one folder and set `ZF_SAMPLE_LOCAL_EXTENSIONS_PATH` to that folder:

```pwsh
$env:ZF_SAMPLE_LOCAL_EXTENSIONS_PATH = '/workspaces'   # holds ZeroFailed.Build.PowerPlatform and ZeroFailed.Deploy.PowerPlatform
./build.ps1
./deploy.ps1 -PowerPlatformWhatIf
```

Local extensions are working copies, so the lock files aren't used or updated while this variable is set.

## Extension versions

The lock files `.zf/build/extensions.lock.json` and `.zf/deploy/extensions.lock.json` record the exact version of each extension. GitHub Actions runs use these versions, even after newer commits are pushed to the extensions' `main` branches. To update to the latest versions:

1. Delete `.zf/build/extensions` and `.zf/deploy/extensions`.
2. Run `./build.ps1` and `./deploy.ps1 -PowerPlatformWhatIf`, without `ZF_SAMPLE_LOCAL_EXTENSIONS_PATH` set.
3. Commit the updated lock files.
