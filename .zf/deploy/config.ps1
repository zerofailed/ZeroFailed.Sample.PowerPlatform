<#
The deployment process for the sample solution, using the 'ZeroFailed.Deploy.PowerPlatform' extension.
The settings for each environment are in the 'config' folder.

By default, the extension is installed from the 'main' branch of its GitHub repository. To use a
local clone instead, for example while changing the extension, set ZF_SAMPLE_LOCAL_EXTENSIONS_PATH
to the folder that holds the clone (such as '/workspaces' in the dev container).
#>

$extensionName = "ZeroFailed.Deploy.PowerPlatform"
if ($env:ZF_SAMPLE_LOCAL_EXTENSIONS_PATH) {
    $zerofailedExtensions = @(
        @{
            Name = $extensionName
            Path = Join-Path $env:ZF_SAMPLE_LOCAL_EXTENSIONS_PATH $extensionName "module" -Resolve
        }
    )
    # A local extension is a working copy, so don't record it in the lock file
    $zerofailedExtensionsLockMode = "Off"
}
else {
    $zerofailedExtensions = @(
        @{
            Name = $extensionName
            GitRepository = "https://github.com/zerofailed/$extensionName"
            GitRef = "main"
        }
    )
}

# Load the tasks and process
. ZeroFailed.tasks -ZfPath $here/.zf/deploy

#
# Deployment process configuration
#

# Customise the deployment process
task . FullDeployment

# Until the sample has a tenant to deploy to, its environment config has no tenant ID. Without one,
# skip signing in to Azure, so that the deployment process can still run offline.
task skipConnectAzureWhenNoTenant -After readConfiguration {
    if (!$DeploymentConfig.azureTenantId) {
        Write-Warning "The environment '$EnvironmentName' has no 'azureTenantId', so the deployment won't sign in to Azure."
        $script:SkipConnectAzure = $true
    }
}

#
# Deployment process extensibility points - uncomment and implement as required
#

# task RunFirst {}
# task PreInit {}
# task PostInit {}
# task PreProvision {}
# task PostProvision {}
# task PreDeploy {}
# task PostDeploy {}
# task PreTest {}
# task PostTest {}
# task RunLast {}
