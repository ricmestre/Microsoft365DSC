#
# Module manifest for module 'Microsoft365DSC'
#
# Generated by: Microsoft Corporation
#
# Generated on: 2024-03-13

@{

  # Script module or binary module file associated with this manifest.
  # RootModule = ''

  # Version number of this module.
  ModuleVersion     = '1.24.403.1'

  # Supported PSEditions
  # CompatiblePSEditions = @()

  # ID used to uniquely identify this module
  GUID              = '39f599a6-d212-4480-83b3-a8ea2124d8cf'

  # Author of this module
  Author            = 'Microsoft Corporation'

  # Company or vendor of this module
  CompanyName       = 'Microsoft Corporation'

  # Copyright statement for this module
  Copyright         = '(c) 2024 Microsoft Corporation. All rights reserved.'

  # Description of the functionality provided by this module
  Description       = 'This DSC module is used to configure and monitor Microsoft tenants, including SharePoint Online, Exchange, Teams, etc.'

  # Minimum version of the PowerShell engine required by this module
  PowerShellVersion = '5.1'

  # Name of the PowerShell host required by this module
  # PowerShellHostName = ''

  # Minimum version of the PowerShell host required by this module
  # PowerShellHostVersion = ''

  # Minimum version of Microsoft .NET Framework required by this module. This prerequisite is valid for the PowerShell Desktop edition only.
  # DotNetFrameworkVersion = ''

  # Minimum version of the common language runtime (CLR) required by this module. This prerequisite is valid for the PowerShell Desktop edition only.
  # CLRVersion = ''

  # Processor architecture (None, X86, Amd64) required by this module
  # ProcessorArchitecture = ''

  # Modules that must be imported into the global environment prior to importing this module
  RequiredModules   = @()

  # Assemblies that must be loaded prior to importing this module
  # RequiredAssemblies = @()

  # Script files (.ps1) that are run in the caller's environment prior to importing this module.
  # ScriptsToProcess = @()

  # Type files (.ps1xml) to be loaded when importing this module
  # TypesToProcess = @()

  # Format files (.ps1xml) to be loaded when importing this module
  # FormatsToProcess = @()

  # Modules to import as nested modules of the module specified in RootModule/ModuleToProcess
  NestedModules     = @(
    'Modules/M365DSCAgent.psm1',
    'Modules/M365DSCDocGenerator.psm1',
    'Modules/M365DSCErrorHandler.psm1',
    'Modules/M365DSCLogEngine.psm1',
    'Modules/M365DSCPermissions.psm1',
    'Modules/M365DSCReport.psm1',
    'Modules/M365DSCReverse.psm1',
    'Modules/M365DSCStubsUtility.psm1',
    'Modules/M365DSCTelemetryEngine.psm1',
    'Modules/M365DSCUtil.psm1',
    'Modules/M365DSCDRGUtil.psm1',
    'Modules/EncodingHelpers/M365DSCEmojis.psm1',
    'Modules/EncodingHelpers/M365DSCStringEncoding.psm1',
    'Modules/M365DSCConfigurationHelper.psm1'
  )

  # Functions to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no functions to export.
  #FunctionsToExport = @()

  # Cmdlets to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no cmdlets to export.
  CmdletsToExport   = @('Assert-M365DSCBlueprint',
    'Compare-M365DSCConfigurations',
    'Confirm-M365DSCDependencies',
    'Export-M365DSCConfiguration',
    'Export-M365DSCDiagnosticData',
    'Get-M365DSCNotificationEndPointRegistration',
    'Get-M365DSCEvaluationRulesForConfiguration',
    'Import-M365DSCDependencies',
    'New-M365DSCDeltaReport',
    'New-M365DSCNotificationEndPointRegistration',
    'New-M365DSCReportFromConfiguration',
    'New-M365DSCStubFiles',
    'Remove-M365DSCNotificationEndPointRegistration',
    'Set-M365DSCAgentCertificateConfiguration',
    'Start-M365DSCConfiguration',
    'Test-M365DSCAgent',
    'Test-M365DSCDependenciesForNewVersions',
    'Test-M365DSCModuleValidity',
    'Uninstall-M365DSCOutdatedDependencies',
    'Update-M365DSCAllowedGraphScopes',
    'Update-M365DSCAzureAdApplication',
    'Update-M365DSCDependencies',
    'Update-M365DSCModule',
    'Update-M365DSCResourceDocumentationPage',
    'Update-M365DSCResourcesSettingsJSON'
  )

  # Variables to export from this module
  # VariablesToExport = @()

  # Aliases to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no aliases to export.
  AliasesToExport   = @()

  # List of all modules packaged with this module
  # ModuleList = @()

  # List of all files packaged with this module
  # FileList = @()

  # Private data to pass to the module specified in RootModule/ModuleToProcess. This may also contain a PSData hashtable with additional module metadata used by PowerShell.
  PrivateData       = @{

    PSData = @{
      # Tags applied to this module. These help with module discovery in online galleries.
      Tags         = 'DesiredStateConfiguration', 'DSC', 'DSCResourceKit', 'DSCResource', 'Microsoft365'

      # A URL to the license for this module.
      LicenseUri   = 'https://github.com/Microsoft/Microsoft365DSC/blob/master/LICENSE'

      # A URL to the main website for this project.
      ProjectUri   = 'https://github.com/Microsoft/Microsoft365DSC'

      # A URL to an icon representing this module.
      IconUri      = 'https://github.com/microsoft/Microsoft365DSC/blob/Dev/Modules/Microsoft365DSC/Dependencies/Images/Logo.png?raw=true'

      # ReleaseNotes of this module
      ReleaseNotes = '* AADAdministrativeUnit
  * Fix issue with deploying/creating a new AU with members and/or adding members to an existing AU
    FIXES [#4404](https://github.com/microsoft/Microsoft365DSC/issues/4404)
  * Updated examples to include setting Visibility and ScopedRoleMembers
  * Fix issue with Set-TargetResource was failing to apply when Verbose is set
    FIXES [#4497](https://github.com/microsoft/Microsoft365DSC/issues/4497)
* All resources
  * Fix issue where Ensure cannot be left as default 'Present'
* AADAdministrativeUnit
  * Fix issue with omitted Ensure and/or Id
    FIXES [#4437](https://github.com/microsoft/Microsoft365DSC/issues/4437)
* AADConditionalAccessPolicy
  * Fixed schema file
* EXOCalendarProcessing
  * Fixed schema file
* EXOGroupSettings
  * Fixed schema file
* EXOMailTips
  * [BREAKING CHANGE] Replaced the Organization parameter with IsSingleInstance
    FIXES [#4117](https://github.com/microsoft/Microsoft365DSC/issues/4117)
* EXOMessageClassification
  * Fixed schema file
* EXOOMEConfiguration
  * Fixed schema file
* EXOTransportRule
  * [BREAKING CHANGE] Change data type of Priority from String to Int
    FIXES [[#4136](https://github.com/microsoft/Microsoft365DSC/issues/4136)]
* IntuneAntivirusPolicyWindows10SettingCatalog
  * Add missing properties
* IntuneAppConfigurationPolicy
  * Fix comparison in Test-TargetResource
    FIXES [#4451](https://github.com/microsoft/Microsoft365DSC/issues/4451)
* IntuneDeviceCompliancePolicyWindows10
  * Fix group assignment by using the corrected function
    Update-DeviceConfigurationPolicyAssignment from module M365DSCDRGUtil
    FIXES [#4467](https://github.com/microsoft/Microsoft365DSC/issues/4467)
* IntuneDeviceEnrollmentPlatformRestriction
  * Fixed an issue where nested settings would throw a conflict
    FIXES [#4082](https://github.com/microsoft/Microsoft365DSC/issues/4082)
* IntuneDeviceEnrollmentStatusPageWindows10
  * Added support for specifying SelectedMobileAppNames in addition to SelectedMobileAppIds,
    which are different for each tenant.
    FIXES [#4494](https://github.com/microsoft/Microsoft365DSC/issues/4494)
* M365DSCRuleEvaluation
  * Log both matching and not matching resources and in XML format
* O365OrgSettings
  * Fixed missing permissions in settings.json
* SPOAccessControlSettings
  * [BREAKING CHANGE] Removed CommentsOnSitePagesDisabled parameter, because of
    duplication in SPOTenantSettings
    FIXES [#3576](https://github.com/microsoft/Microsoft365DSC/issues/3576)
  * [BREAKING CHANGE] Moved SocialBarOnSitePagesDisabled parameter to SPOTenantSettings,
    because it makes more sense there. This has nothing to do with Access Control.
* SPOTenantSettings
  * [BREAKING CHANGE] Removed ConditionalAccessPolicy parameter, because of
    duplication in SPOAccessControlSettings
    FIXES [#3576](https://github.com/microsoft/Microsoft365DSC/issues/3576)
  * Added SocialBarOnSitePagesDisabled parameter, moved from SPOAccessControlSettings.
  * Added EnableAIPIntegration.
* TeamsChannelTab
  * Fixed schema file
* TeamsGroupPolicyAssignment
  * Skip assignments that have orphaned/deleted groups or without display name
    instead of throwing an error
    FIXES [#4407](https://github.com/microsoft/Microsoft365DSC/issues/4407)
* TeamsTenantDialPlan
  * Fix output of property NormalizationRules as a string to the blueprint
    FIXES [#4428](https://github.com/microsoft/Microsoft365DSC/issues/4428)
  * Fix creation, update and deletion of resource
* TeamsUpdateManagementPolicy
  * Adds support for the NewTeamsOnly value or the UseNewTeamsClient property.
    FIXES [#4496](https://github.com/microsoft/Microsoft365DSC/issues/4496)
* DEPENDENCIES
  * Updated DSCParser to version 2.0.0.3.
* MISC
  * Initial release of Get-M365DSCEvaluationRulesForConfiguration
  * M365DSCDRGUtil
    Fix Update-DeviceConfigurationPolicyAssignment so that if the group cannot
    be found by its Id it tries to search it by display name
    FIXES [#4467](https://github.com/microsoft/Microsoft365DSC/issues/4467)
  * M365DSCReport
    Fix issue when asserting resources not covered by current conditions in
    Get-M365DSCResourceKey by always returning all their mandatory parameters
    FIXES [#4502](https://github.com/microsoft/Microsoft365DSC/issues/4502)
  * Fix broken links to integration tests in README.md
  * Changing logic to retrieve DSC Resources properties not to use DSC
    specific cmdlets.'

      # Flag to indicate whether the module requires explicit user acceptance for install/update
      # RequireLicenseAcceptance = $false

      # External dependent modules of this module
      # ExternalModuleDependencies = @()

    } # End of PSData hashtable

  } # End of PrivateData hashtable

  # HelpInfo URI of this module
  # HelpInfoURI = ''

  # Default prefix for commands exported from this module. Override the default prefix using Import-Module -Prefix.
  # DefaultCommandPrefix = ''
}
