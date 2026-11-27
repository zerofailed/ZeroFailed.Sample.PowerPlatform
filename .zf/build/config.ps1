<#
The build process for the sample solution, using the 'ZeroFailed.Build.PowerPlatform' extension.

By default, the extension is installed from the 'main' branch of its GitHub repository. To use a
local clone instead, for example while changing the extension, set ZF_SAMPLE_LOCAL_EXTENSIONS_PATH
to the folder that holds the clone (such as '/workspaces' in the dev container).
#>

$extensionName = "ZeroFailed.Build.PowerPlatform"
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
. ZeroFailed.tasks -ZfPath $here/.zf/build

#
# Build process configuration
#

# Customise the build process
task . FullBuild

#
# Build process extensibility points - uncomment and implement as required
#

# task RunFirst {}
# task PreInit {}
# task PostInit {}
# task PreVersion {}
# task PostVersion {}
# task PreBuild {}
# task PostBuild {}
# task PreTest {}
# task PostTest {}
# task PreAnalysis {}
# task PostAnalysis {}
# task PrePackage {}
# task PostPackage {}
# task RunLast {}
