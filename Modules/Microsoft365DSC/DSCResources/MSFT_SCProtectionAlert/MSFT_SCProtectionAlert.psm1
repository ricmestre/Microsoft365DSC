function Get-TargetResource
{
    [CmdletBinding()]
    [OutputType([System.Collections.Hashtable])]
    param
    (
        [Parameter()]
        [System.String[]]
        $AlertBy,

        [Parameter()]
        [System.String[]]
        $AlertFor,

        [Parameter()]
        [ValidateSet('None', 'SimpleAggregation', 'AnomalousAggregation')]
        [System.String]
        $AggregationType,

        [Parameter()]
        [System.String]
        $Category,

        [Parameter()]
        [System.String]
        $Comment,

        [Parameter(Mandatory = $true)]
        [System.Management.Automation.PSCredential]
        $Credential,

        [Parameter()]
        [System.Boolean]
        $Disabled,

        [Parameter()]
        [System.String]
        $Filter,

        [Parameter()]
        [ValidateSet('Present', 'Absent')]
        [System.String]
        $Ensure = 'Present',

        [Parameter()]
        [System.Boolean]
        $IsSystemRule,

        [Parameter(Mandatory = $true)]
        [System.String]
        $Name,

        [Parameter()]
        [System.String]
        $NotificationCulture,

        [Parameter()]
        [System.Boolean]
        $NotificationEnabled,

        [Parameter()]
        [System.Boolean]
        $NotifyUserOnFilterMatch,

        [Parameter()]
        [System.DateTime]
        $NotifyUserSuppressionExpiryDate,

        [Parameter()]
        [System.Int32]
        $NotifyUserThrottleThreshold,

        [Parameter()]
        [System.Int32]
        $NotifyUserThrottleWindow,

        [Parameter()]
        [System.String[]]
        $NotifyUser = @(),

        [Parameter()]
        [System.String[]]
        $Operation = @(),

        [Parameter()]
        [System.String[]]
        $PrivacyManagementScopedSensitiveInformationTypes = @(),

        [Parameter()]
        [System.String[]]
        $PrivacyManagementScopedSensitiveInformationTypesForCounting = @(),

        [Parameter()]
        [System.UInt64]
        $PrivacyManagementScopedSensitiveInformationTypesThreshold,

        [Parameter()]
        [System.String]
        $Scenario,

        [Parameter()]
        [ValidateSet('Low', 'Medium', 'High')]
        [System.String]
        $Severity = 'Low',

        [Parameter()]
        [System.String]
        $StreamType,

        [Parameter()]
        [System.String]
        $TagFilter,

        [Parameter()]
        [ValidateSet('Activity', 'Malware', 'Phish', 'Malicious','MaliciousUrlClick')]
        [System.String]
        $ThreatType,

        [Parameter()]
        [ValidateRange(3,2147483647)]
        [System.Int32]
        $Threshold,

        [Parameter()]
        [ValidateRange(60,2147483647)]
        [System.Int32]
        $TimeWindow,

        [Parameter()]
        [System.String[]]
        $UserTags = @(),

        [Parameter()]
        [System.Int32]
        $VolumeThreshold
    )


    Write-Verbose -Message "Getting configuration of SCProtectionAlert for $Name"

    if ($Global:CurrentModeIsExport)
    {
        $ConnectionMode = New-M365DSCConnection -Workload 'SecurityComplianceCenter' `
            -InboundParameters $PSBoundParameters `
            -SkipModuleReload $true
    }
    else
    {
        $ConnectionMode = New-M365DSCConnection -Workload 'SecurityComplianceCenter' `
            -InboundParameters $PSBoundParameters
    }

    #Ensure the proper dependencies are installed in the current environment.
    Confirm-M365DSCDependencies

    #region Telemetry
    $ResourceName = $MyInvocation.MyCommand.ModuleName -replace 'MSFT_', ''
    $CommandName = $MyInvocation.MyCommand
    $data = Format-M365DSCTelemetryParameters -ResourceName $ResourceName `
        -CommandName $CommandName `
        -Parameters $PSBoundParameters
    Add-M365DSCTelemetryEvent -Data $data
    #endregion

    $nullReturn = $PSBoundParameters
    $nullReturn.Ensure = 'Absent'
    try
    {
        $AlertObject = Get-ProtectionAlert -Identity $Name -ErrorAction SilentlyContinue

        if ($null -eq $AlertObject)
        {
            Write-Verbose -Message "SCProtectionAlert $Name does not exist."
            return $nullReturn
        }
        else
        {
            Write-Verbose "Found existing SCProtectionAlert $($Name)"
            $result = @{
                Ensure                                                      = 'Present'
                AlertBy                                                     = $AlertObject.AlertBy
                AlertFor                                                    = $AlertObject.AlertFor
                AggregationType                                             = $AlertObject.AggregationType
                Category                                                    = $AlertObject.Category
                Comment                                                     = $AlertObject.Comment
                Disabled                                                    = $AlertObject.Disabled
                Filter                                                      = $AlertObject.Filter
                IsSystemRule                                                = $AlertObject.IsSystemRule
                Name                                                        = $AlertObject.Name
                NotificationCulture                                         = $AlertObject.NotificationCulture
                NotificationEnabled                                         = $AlertObject.NotificationEnabled
                NotifyUserOnFilterMatch                                     = $AlertObject.NotifyUserOnFilterMatch
                NotifyUserSuppressionExpiryDate                             = $AlertObject.NotifyUserSuppressionExpiryDate
                NotifyUserThrottleThreshold                                 = $AlertObject.NotifyUserThrottleThreshold
                NotifyUserThrottleWindow                                    = $AlertObject.NotifyUserThrottleWindow
                NotifyUser                                                  = $AlertObject.NotifyUser
                Operation                                                   = $AlertObject.Operation
                PrivacyManagementScopedSensitiveInformationTypes            = $AlertObject.PrivacyManagementScopedSensitiveInformationTypes
                PrivacyManagementScopedSensitiveInformationTypesForCounting = $AlertObject.PrivacyManagementScopedSensitiveInformationTypesForCounting
                PrivacyManagementScopedSensitiveInformationTypesThreshold   = $AlertObject.PrivacyManagementScopedSensitiveInformationTypesThreshold
                Scenario                                                    = $AlertObject.Scenario
                Severity                                                    = $AlertObject.Severity
                StreamType                                                  = $AlertObject.StreamType
                TagFilter                                                   = $AlertObject.TagFilter
                ThreatType                                                  = $AlertObject.ThreatType
                Threshold                                                   = $AlertObject.Threshold
                TimeWindow                                                  = $AlertObject.TimeWindow
                UserTags                                                    = $AlertObject.UserTags
                VolumeThreshold                                             = $AlertObject.VolumeThreshold
            }
            Write-Verbose -Message "Get-TargetResource Result: `n $(Convert-M365DscHashtableToString -Hashtable $result)"
            return $result
        }
    }
    catch
    {
        New-M365DSCLogEntry -Message 'Error retrieving data:' `
            -Exception $_ `
            -Source $($MyInvocation.MyCommand.Source) `
            -TenantId $TenantId `
            -Credential $Credential

        return $nullReturn
    }
}

function Set-TargetResource
{

    [CmdletBinding()]
    param
    (
        [Parameter()]
        [System.String[]]
        $AlertBy,

        [Parameter()]
        [System.String[]]
        $AlertFor,

        [Parameter()]
        [ValidateSet('None', 'SimpleAggregation', 'AnomalousAggregation')]
        [System.String]
        $AggregationType,

        [Parameter()]
        [System.String]
        $Category,

        [Parameter()]
        [System.String]
        $Comment,

        [Parameter(Mandatory = $true)]
        [System.Management.Automation.PSCredential]
        $Credential,

        [Parameter()]
        [System.Boolean]
        $Disabled,

        [Parameter()]
        [System.String]
        $Filter,

        [Parameter()]
        [ValidateSet('Present', 'Absent')]
        [System.String]
        $Ensure = 'Present',

        [Parameter()]
        [System.Boolean]
        $IsSystemRule,

        [Parameter(Mandatory = $true)]
        [System.String]
        $Name,

        [Parameter()]
        [System.String]
        $NotificationCulture,

        [Parameter()]
        [System.Boolean]
        $NotificationEnabled,

        [Parameter()]
        [System.Boolean]
        $NotifyUserOnFilterMatch,

        [Parameter()]
        [System.DateTime]
        $NotifyUserSuppressionExpiryDate,

        [Parameter()]
        [System.Int32]
        $NotifyUserThrottleThreshold,

        [Parameter()]
        [System.Int32]
        $NotifyUserThrottleWindow,

        [Parameter()]
        [System.String[]]
        $NotifyUser = @(),

        [Parameter()]
        [System.String[]]
        $Operation = @(),

        [Parameter()]
        [System.String[]]
        $PrivacyManagementScopedSensitiveInformationTypes = @(),

        [Parameter()]
        [System.String[]]
        $PrivacyManagementScopedSensitiveInformationTypesForCounting = @(),

        [Parameter()]
        [System.UInt64]
        $PrivacyManagementScopedSensitiveInformationTypesThreshold,

        [Parameter()]
        [System.String]
        $Scenario,

        [Parameter()]
        [ValidateSet('Low', 'Medium', 'High')]
        [System.String]
        $Severity = 'Low',

        [Parameter()]
        [System.String]
        $StreamType,

        [Parameter()]
        [System.String]
        $TagFilter,

        [Parameter()]
        [ValidateSet('Activity', 'Malware', 'Phish', 'Malicious','MaliciousUrlClick')]
        [System.String]
        $ThreatType,

        [Parameter()]
        [ValidateRange(3,2147483647)]
        [System.Int32]
        $Threshold,

        [Parameter()]
        [ValidateRange(60,2147483647)]
        [System.Int32]
        $TimeWindow,

        [Parameter()]
        [System.String[]]
        $UserTags = @(),

        [Parameter()]
        [System.Int32]
        $VolumeThreshold
    )


    Write-Verbose -Message "Setting configuration of SCProtectionAlert for $Name"

    #Ensure the proper dependencies are installed in the current environment.
    Confirm-M365DSCDependencies

    #region Telemetry
    $ResourceName = $MyInvocation.MyCommand.ModuleName -replace 'MSFT_', ''
    $CommandName = $MyInvocation.MyCommand
    $data = Format-M365DSCTelemetryParameters -ResourceName $ResourceName `
        -CommandName $CommandName `
        -Parameters $PSBoundParameters
    Add-M365DSCTelemetryEvent -Data $data
    #endregion

    $ConnectionMode = New-M365DSCConnection -Workload 'SecurityComplianceCenter' `
        -InboundParameters $PSBoundParameters

    $CurrentAlert = Get-TargetResource @PSBoundParameters

    if ($CurrentAlert.IsSystemRule) {
        Write-Verbose "Amending or creating a 'SystemRule' is currently not supported. "
    }
    elseif (('Present' -eq $Ensure) -and ('Absent' -eq $CurrentAlert.Ensure))
    {
        $CreationParams = $PSBoundParameters
        $CreationParams.Remove('Credential')
        $CreationParams.Remove('Ensure')
        $CreationParams.Remove('IsSystemRule')
        $CreationParams.Remove('Scenario')
        $CreationParams.Remove('StreamType')
        $CreationParams.Remove('TagFilter')
        $CreationParams.Remove('UserTags')


        New-ProtectionAlert @CreationParams
    }
    elseif (('Present' -eq $Ensure) -and ('Present' -eq $CurrentAlert.Ensure))
    {
        $CreationParams = $PSBoundParameters
        $CreationParams.Remove('Credential')
        $CreationParams.Remove('Ensure')
        $CreationParams.Remove('Name')
        $CreationParams.Remove('ThreatType')
        $CreationParams.Remove('IsSystemRule')
        $CreationParams.Remove('Scenario')
        $CreationParams.Remove('StreamType')
        $CreationParams.Remove('TagFilter')
        $CreationParams.Remove('UserTags')

        $Alert = Get-ProtectionAlert -Identity $Name
        $CreationParams.Add('Identity', $Alert.Name)

        Write-Verbose "Updating ProtectionAlert with values: $(Convert-M365DscHashtableToString -Hashtable $CreationParams)"
        Set-ProtectionAlert @CreationParams
    }
    elseif (('Absent' -eq $Ensure) -and ('Present' -eq $CurrentAlert.Ensure))
    {
        # If the Alert exists and it shouldn't, simply remove it;
        $Alert = Get-ProtectionAlert -Identity $Name
        Remove-ProtectionAlert -Identity $Alert.Identity
    }
}

function Test-TargetResource
{
    [CmdletBinding()]
    [OutputType([System.Boolean])]
    param
    (
        [Parameter()]
        [System.String[]]
        $AlertBy,

        [Parameter()]
        [System.String[]]
        $AlertFor,

        [Parameter()]
        [ValidateSet('None', 'SimpleAggregation', 'AnomalousAggregation')]
        [System.String]
        $AggregationType,

        [Parameter()]
        [System.String]
        $Category,

        [Parameter()]
        [System.String]
        $Comment,

        [Parameter(Mandatory = $true)]
        [System.Management.Automation.PSCredential]
        $Credential,

        [Parameter()]
        [System.Boolean]
        $Disabled,

        [Parameter()]
        [System.String]
        $Filter,

        [Parameter()]
        [ValidateSet('Present', 'Absent')]
        [System.String]
        $Ensure = 'Present',

        [Parameter()]
        [System.Boolean]
        $IsSystemRule,

        [Parameter(Mandatory = $true)]
        [System.String]
        $Name,

        [Parameter()]
        [System.String]
        $NotificationCulture,

        [Parameter()]
        [System.Boolean]
        $NotificationEnabled,

        [Parameter()]
        [System.Boolean]
        $NotifyUserOnFilterMatch,

        [Parameter()]
        [System.DateTime]
        $NotifyUserSuppressionExpiryDate,

        [Parameter()]
        [System.Int32]
        $NotifyUserThrottleThreshold,

        [Parameter()]
        [System.Int32]
        $NotifyUserThrottleWindow,

        [Parameter()]
        [System.String[]]
        $NotifyUser = @(),

        [Parameter()]
        [System.String[]]
        $Operation = @(),

        [Parameter()]
        [System.String[]]
        $PrivacyManagementScopedSensitiveInformationTypes = @(),

        [Parameter()]
        [System.String[]]
        $PrivacyManagementScopedSensitiveInformationTypesForCounting = @(),

        [Parameter()]
        [System.UInt64]
        $PrivacyManagementScopedSensitiveInformationTypesThreshold,

        [Parameter()]
        [System.String]
        $Scenario,

        [Parameter()]
        [ValidateSet('Low', 'Medium', 'High')]
        [System.String]
        $Severity = 'Low',

        [Parameter()]
        [System.String]
        $StreamType,

        [Parameter()]
        [System.String]
        $TagFilter,

        [Parameter()]
        [ValidateSet('Activity', 'Malware', 'Phish', 'Malicious','MaliciousUrlClick')]
        [System.String]
        $ThreatType,

        [Parameter()]
        [ValidateRange(3,2147483647)]
        [System.Int32]
        $Threshold,

        [Parameter()]
        [ValidateRange(60,2147483647)]
        [System.Int32]
        $TimeWindow,

        [Parameter()]
        [System.String[]]
        $UserTags = @(),

        [Parameter()]
        [System.Int32]
        $VolumeThreshold
    )
    #Ensure the proper dependencies are installed in the current environment.
    Confirm-M365DSCDependencies

    #region Telemetry
    $ResourceName = $MyInvocation.MyCommand.ModuleName -replace 'MSFT_', ''
    $CommandName = $MyInvocation.MyCommand
    $data = Format-M365DSCTelemetryParameters -ResourceName $ResourceName `
        -CommandName $CommandName `
        -Parameters $PSBoundParameters
    Add-M365DSCTelemetryEvent -Data $data
    #endregion

    Write-Verbose -Message "Testing configuration of SCProtectionAlert for $Name"

    $CurrentValues = Get-TargetResource @PSBoundParameters
    Write-Verbose -Message "Target Values: $(Convert-M365DscHashtableToString -Hashtable $PSBoundParameters)"

    $ValuesToCheck = $PSBoundParameters
    $ValuesToCheck.Remove('Credential') | Out-Null

    $TestResult = Test-M365DSCParameterState -CurrentValues $CurrentValues `
        -Source $($MyInvocation.MyCommand.Source) `
        -DesiredValues $PSBoundParameters `
        -ValuesToCheck $ValuesToCheck.Keys

    Write-Verbose -Message "Test-TargetResource returned $TestResult"

    return $TestResult
}

function Export-TargetResource
{
    [CmdletBinding()]
    [OutputType([System.String])]
    param
    (
        [Parameter(Mandatory = $true)]
        [System.Management.Automation.PSCredential]
        $Credential
    )
    $ConnectionMode = New-M365DSCConnection -Workload 'SecurityComplianceCenter' `
        -InboundParameters $PSBoundParameters `
        -SkipModuleReload $true
    #Ensure the proper dependencies are installed in the current environment.
    Confirm-M365DSCDependencies

    #region Telemetry
    $ResourceName = $MyInvocation.MyCommand.ModuleName -replace 'MSFT_', ''
    $CommandName = $MyInvocation.MyCommand
    $data = Format-M365DSCTelemetryParameters -ResourceName $ResourceName `
        -CommandName $CommandName `
        -Parameters $PSBoundParameters
    Add-M365DSCTelemetryEvent -Data $data
    #endregion

    try
    {
        [array]$Alerts = Get-ProtectionAlert -ErrorAction Stop

        $totalAlerts = $Alerts.Length
        if ($null -eq $totalAlerts)
        {
            $totalAlerts = 1
        }
        $i = 1
        if ($totalAlerts.Length -eq 0)
        {
            Write-Host $Global:M365DSCEmojiGreenCheckMark
        }
        else
        {
            Write-Host "`r`n" -NoNewline
        }
        $dscContent = ''
        foreach ($alert in $Alerts)
        {
            Write-Host "    |---[$i/$($totalAlerts)] $($alert.Name)" -NoNewline
            $Params = @{
                Name       = $Alert.Name
                Credential = $Credential
            }
            $Results = Get-TargetResource @Params
            $Results = Update-M365DSCExportAuthenticationResults -ConnectionMode $ConnectionMode `
                -Results $Results
            $currentDSCBlock = Get-M365DSCExportContentForResource -ResourceName $ResourceName `
                -ConnectionMode $ConnectionMode `
                -ModulePath $PSScriptRoot `
                -Results $Results `
                -Credential $Credential

            $dscContent += $currentDSCBlock
            Save-M365DSCPartialExport -Content $currentDSCBlock `
                -FileName $Global:PartialExportFileName
            Write-Host $Global:M365DSCEmojiGreenCheckMark
            $i++
        }
        return $dscContent
    }
    catch
    {
        Write-Host $Global:M365DSCEmojiRedX

        New-M365DSCLogEntry -Message 'Error during Export:' `
            -Exception $_ `
            -Source $($MyInvocation.MyCommand.Source) `
            -TenantId $TenantId `
            -Credential $Credential

        return ''
    }
}

Export-ModuleMember -Function *-TargetResource
