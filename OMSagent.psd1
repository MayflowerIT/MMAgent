@{
    RootModule = 'OMSagent.schema.psm1'
    ModuleVersion = '1.0'
    GUID = 'b3dcc531-5a80-4d18-8011-e1645a765bcc'

    Author = 'John D Pell'
    CompanyName = 'Mayflower IS&T'
    Copyright = '(c) 2020 gaelicWizard.LLC. All Rights Reserved'
    #Description = ''

    PowerShellVersion = '4.0'
    #DotNetFrameworkVersion = ''
    #CLRVersion = ''

    ProcessorArchitecture = 'Amd64'

    RequiredModules = @('xPSDesiredStateConfiguration', 'PSDscResources')

    PrivateData = @{
        PSData = @{
            Tags = @('DSC','OMS')
            # LicenseUri = ''
            ProjectUri = 'https://github.com/MayflowerIT/OMSagent'
            # IconUri = ''
            # ReleaseNotes = ''
}   }   }
