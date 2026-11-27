# Settings shared by every environment. The settings for one environment are in 'config/<environment>.ps1',
# and override these.
#
# The public sample holds no real IDs. Set them in environment variables locally, or in GitHub variables
# for the workflows.
@{
    # The settings that each environment must have. None yet, while the sample runs offline.
    RequiredConfiguration = @()

    azureTenantId = $env:ZF_SAMPLE_AZURE_TENANT_ID
}
