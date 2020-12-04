# Partial Configuration

New-Variable -Option ReadOnly -Name SystemSixteen -Value (Join-Path $env:SystemRoot "System")
    # Sadly, this script is evaluated during *complile* so using variables is...not doing what it seems


Configuration MMAgent
{
    param
    (
        # MSI Product ID
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [String] $OPSINSIGHTS_PID,

        # OMS Workspace ID
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [String] $OPSINSIGHTS_WS_ID,

        # OMS Workspace Key
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [String] $OPSINSIGHTS_WS_KEY
    )

    Import-DscResource -ModuleName xPSDesiredStateConfiguration # M$-preview, extra features without support
    Import-DscResource -ModuleName PSDscResources # M$-supported, replaces in-box PSDesiredStateConfiguration

    $OIPackageLocalPath = Join-Path $SystemSixteen "MMASetup-AMD64.exe"

    Service OIService
    { # Log shipping to Azure
        Name = "HealthService"
        State = "Running"

        DependsOn = "[Package]OI"
    }

    #Service audit?

    Package OI
    { # The Microsoft Management Agent installation package with workspace ID and key.
        Ensure = "Present"
        Path  = $OIPackageLocalPath
        Name = "Microsoft Monitoring Agent"
        ProductId = $OPSINSIGHTS_PID
        Arguments = '/C:"setup.exe /qn NOAPM=1 ADD_OPINSIGHTS_WORKSPACE=1 OPINSIGHTS_WORKSPACE_ID=' + $OPSINSIGHTS_WS_ID + ' OPINSIGHTS_WORKSPACE_KEY=' + $OPSINSIGHTS_WS_KEY + ' AcceptEndUserLicenseAgreement=1"'
        DependsOn = "[xRemoteFile]OIPackage"
    }

    xRemoteFile OIPackage
    { # The Microsoft Monitoring Agent installer
        Uri = "https://go.microsoft.com/fwlink/?LinkId=828603"
        DestinationPath = $OIPackageLocalPath
    }
}
