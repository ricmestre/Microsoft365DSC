function Get-TargetResource
{
    [CmdletBinding()]
    [OutputType([System.Collections.Hashtable])]
    param
    (
        #region resource generator code
        [Parameter()]
        [System.String]
        $Id,

        [Parameter()]
        [System.String]
        $AuthenticationType,

        [Parameter()]
        [System.String]
        $AvailabilityStatus,

        [Parameter()]
        [System.Boolean]
        $IsAdminManaged,

        [Parameter()]
        [System.Boolean]
        $IsDefault,

        [Parameter()]
        [System.Boolean]
        $IsInitial,

        [Parameter()]
        [System.Boolean]
        $IsRoot,

        [Parameter()]
        [System.Boolean]
        $IsVerified,

        [Parameter()]
        [System.String]
        $Manufacturer,

        [Parameter()]
        [System.String]
        $Model,

        [Parameter()]
        [System.Int32]
        $PasswordNotificationWindowInDays,

        [Parameter()]
        [System.Int32]
        $PasswordValidityPeriodInDays,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance]
        $State,

        [Parameter()]
        [System.String[][]]
        $SupportedServices,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance[]]
        $DomainNameReferences,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance[]]
        $ServiceConfigurationRecords,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance[]]
        $VerificationDnsRecords,


        #endregion
        

        [Parameter(Mandatory = $true)]
        [System.String]
        [ValidateSet('Absent', 'Present')]
        $Ensure,

        [Parameter()]
        [System.Management.Automation.PSCredential]
        $Credential,

        [Parameter()]
        [System.String]
        $ApplicationId,

        [Parameter()]
        [System.String]
        $TenantId,

        [Parameter()]
        [System.String]
        $ApplicationSecret,

        [Parameter()]
        [System.String]
        $CertificateThumbprint
    )

    try
    {
        $ConnectionMode = New-M365DSCConnection -Workload 'MicrosoftGraph' `
            -InboundParameters $PSBoundParameters `
            -ProfileName 'v1.0'
        Select-MgProfile 'v1.0' -ErrorAction Stop
    }
    catch
    {
        Write-Verbose -Message "Reloading1"
    }

    #Ensure the proper dependencies are installed in the current environment.
    Confirm-M365DSCDependencies

    #region Telemetry
    $ResourceName = $MyInvocation.MyCommand.ModuleName.Replace("MSFT_", "")
    $CommandName = $MyInvocation.MyCommand
    $data = Format-M365DSCTelemetryParameters -ResourceName $ResourceName `
        -CommandName $CommandName `
        -Parameters $PSBoundParameters
    Add-M365DSCTelemetryEvent -Data $data
    #endregion

    $nullResult = $PSBoundParameters
    $nullResult.Ensure = 'Absent'
    try
    {
        
        #region resource generator code
        $getValue = Get-MgDomain `
            -ErrorAction Stop | Where-Object `
            -FilterScript {
                $_.AdditionalProperties.'@odata.type' -eq '#microsoft.graph.domain' -and  $_.displayName -eq $($DisplayName)
            }

        if (-not $getValue)
        {
            [array]$getValue = Get-MgDomain `
                -ErrorAction Stop | Where-Object `
            -FilterScript {
                $_.id -eq $id
            }
        }
        #endregion
        

        if ($null -eq $getValue)
        {
            Write-Verbose -Message "Nothing with id {$id} was found"
            return $nullResult
        }

        Write-Verbose -Message "Found something with id {$id}"
        $results = @{
            
            #region resource generator code
            Id = $getValue.Id 
            AuthenticationType = $getValue.AuthenticationType 
            AvailabilityStatus = $getValue.AvailabilityStatus 
            IsAdminManaged = $getValue.IsAdminManaged 
            IsDefault = $getValue.IsDefault 
            IsInitial = $getValue.IsInitial 
            IsRoot = $getValue.IsRoot 
            IsVerified = $getValue.IsVerified 
            Manufacturer = $getValue.Manufacturer 
            Model = $getValue.Model 
            PasswordNotificationWindowInDays = $getValue.PasswordNotificationWindowInDays 
            PasswordValidityPeriodInDays = $getValue.PasswordValidityPeriodInDays 
            SupportedServices = $getValue.SupportedServices 

            
            Ensure                = 'Present'
            Credential            = $Credential
            ApplicationId         = $ApplicationId
            TenantId              = $TenantId
            ApplicationSecret     = $ApplicationSecret
            CertificateThumbprint = $CertificateThumbprint
        }
        if ($getValue.State)
        {
            $results.Add("State", (Get-M365DSCDRGComplexTypeToHashtable -ComplexObject $getValue.State))
        }
        if ($getValue.DomainNameReferences)
        {
            $results.Add("DomainNameReferences", (Get-M365DSCDRGComplexTypeToHashtable -ComplexObject $getValue.DomainNameReferences))
        }
        if ($getValue.ServiceConfigurationRecords)
        {
            $results.Add("ServiceConfigurationRecords", (Get-M365DSCDRGComplexTypeToHashtable -ComplexObject $getValue.ServiceConfigurationRecords))
        }
        if ($getValue.VerificationDnsRecords)
        {
            $results.Add("VerificationDnsRecords", (Get-M365DSCDRGComplexTypeToHashtable -ComplexObject $getValue.VerificationDnsRecords))
        }

        return [System.Collections.Hashtable] $results
    }
    catch
    {
        try
        {
            Write-Verbose -Message $_
            $tenantIdValue = ""
            if (-not [System.String]::IsNullOrEmpty($TenantId))
            {
                $tenantIdValue = $TenantId
            }
            elseif ($null -ne $Credential)
            {
                $tenantIdValue = $Credential.UserName.Split('@')[1]
            }
            Add-M365DSCEvent -Message $_ -EntryType 'Error' `
                -EventID 1 -Source $($MyInvocation.MyCommand.Source) `
                -TenantId $tenantIdValue
        }
        catch
        {
            Write-Verbose -Message $_
        }
        return $nullResult
    }
}

function Set-TargetResource
{
    [CmdletBinding()]
    param
    (
        
        #region resource generator code
                [Parameter()]
        [System.String]
        $Id,

        [Parameter()]
        [System.String]
        $AuthenticationType,

        [Parameter()]
        [System.String]
        $AvailabilityStatus,

        [Parameter()]
        [System.Boolean]
        $IsAdminManaged,

        [Parameter()]
        [System.Boolean]
        $IsDefault,

        [Parameter()]
        [System.Boolean]
        $IsInitial,

        [Parameter()]
        [System.Boolean]
        $IsRoot,

        [Parameter()]
        [System.Boolean]
        $IsVerified,

        [Parameter()]
        [System.String]
        $Manufacturer,

        [Parameter()]
        [System.String]
        $Model,

        [Parameter()]
        [System.Int32]
        $PasswordNotificationWindowInDays,

        [Parameter()]
        [System.Int32]
        $PasswordValidityPeriodInDays,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance]
        $State,

        [Parameter()]
        [System.String[][]]
        $SupportedServices,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance[]]
        $DomainNameReferences,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance[]]
        $ServiceConfigurationRecords,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance[]]
        $VerificationDnsRecords,


        #endregion
        

        [Parameter(Mandatory = $true)]
        [System.String]
        [ValidateSet('Absent', 'Present')]
        $Ensure,

        [Parameter()]
        [System.Management.Automation.PSCredential]
        $Credential,

        [Parameter()]
        [System.String]
        $ApplicationId,

        [Parameter()]
        [System.String]
        $TenantId,

        [Parameter()]
        [System.String]
        $ApplicationSecret,

        [Parameter()]
        [System.String]
        $CertificateThumbprint
    )

    try
    {
        $ConnectionMode = New-M365DSCConnection -Workload 'MicrosoftGraph' `
            -InboundParameters $PSBoundParameters `
            -ProfileName 'v1.0'
    }
    catch
    {
        Write-Verbose -Message $_
    }

    #Ensure the proper dependencies are installed in the current environment.
    Confirm-M365DSCDependencies

    #region Telemetry
    $ResourceName = $MyInvocation.MyCommand.ModuleName.Replace("MSFT_", "")
    $CommandName = $MyInvocation.MyCommand
    $data = Format-M365DSCTelemetryParameters -ResourceName $ResourceName `
        -CommandName $CommandName `
        -Parameters $PSBoundParameters
    Add-M365DSCTelemetryEvent -Data $data
    #endregion

    $currentInstance = Get-TargetResource @PSBoundParameters

    $PSBoundParameters.Remove('Ensure') | Out-Null
    $PSBoundParameters.Remove('Credential') | Out-Null
    $PSBoundParameters.Remove('ApplicationId') | Out-Null
    $PSBoundParameters.Remove('ApplicationSecret') | Out-Null
    $PSBoundParameters.Remove('TenantId') | Out-Null

    if ($Ensure -eq 'Present' -and $currentInstance.Ensure -eq 'Absent')
    {
        Write-Verbose -Message "Creating {$DisplayName}"
        $CreateParameters = $PSBoundParameters
        $CreateParameters.Remove("Id") | Out-Null

        $AdditionalProperties = Get-M365DSCAdditionalProperties -Properties ([System.Collections.Hashtable]$PSBoundParameters)
        
        #region resource generator code
        New-MgDomain @CreateParameters
        #endregion
        
    }
    elseif ($Ensure -eq 'Present' -and $currentInstance.Ensure -eq 'Present')
    {
        Write-Verbose -Message "Updating {$DisplayName}"
        [System.Collections.Hashtable]$UpdateParameters = $PSBoundParameters
        $UpdateParameters.Remove("Id") | Out-Null
        $AdditionalProperties = Get-M365DSCAdditionalProperties -Properties ([System.Collections.Hashtable]$PSBoundParameters)

        $ConvertedParameters = @()
        foreach ($key in $UpdateParameters.Keys)
        {
            if (($UpdateParameters[$key]).GetType().Name -eq 'CimInstance')
            {
                Write-Verbose -Message "Converting complex property {$key} to Hashtable"
                $hashtableValue = Get-M365DSCDRGComplexTypeToHashtable -ComplexObject $UpdateParameters[$key]
                $currentParameter = @{
                    Name = $key
                    Value = $hashtableValue
                }
                $ConvertedParameters += $currentParameter
            }
        }

        foreach ($convertedParameter in $ConvertedParameters)
        {
            if (-not $readOnlyParameters.Contains($convertedParameter.Name))
            {
                $UpdateParameters[$convertedParameter.Name] = $convertedParameter.Value
            }
        }
        <#
        if ($AdditionalProperties)
        {
            $UpdateParameters.Add("AdditionalProperties", $AdditionalProperties)
        }#>
        
        #region resource generator code
        Write-Verbose -Message ($UpdateParameters | Out-String)
        Update-MgDomain @UpdateParameters `
            -DomainId $currentInstance.Id
        #endregion
        
    }
    elseif ($Ensure -eq 'Absent' -and $currentInstance.Ensure -eq 'Present')
    {
        Write-Verbose -Message "Removing {$DisplayName}"

        
        #region resource generator code
        #endregion
        

        
        #region resource generator code
        Remove-MgDomain -DomainId $currentInstance.Id
        #endregion
        
    }
}

function Test-TargetResource
{
    [CmdletBinding()]
    [OutputType([System.Boolean])]
    param
    (
        
        #region resource generator code
                [Parameter()]
        [System.String]
        $Id,

        [Parameter()]
        [System.String]
        $AuthenticationType,

        [Parameter()]
        [System.String]
        $AvailabilityStatus,

        [Parameter()]
        [System.Boolean]
        $IsAdminManaged,

        [Parameter()]
        [System.Boolean]
        $IsDefault,

        [Parameter()]
        [System.Boolean]
        $IsInitial,

        [Parameter()]
        [System.Boolean]
        $IsRoot,

        [Parameter()]
        [System.Boolean]
        $IsVerified,

        [Parameter()]
        [System.String]
        $Manufacturer,

        [Parameter()]
        [System.String]
        $Model,

        [Parameter()]
        [System.Int32]
        $PasswordNotificationWindowInDays,

        [Parameter()]
        [System.Int32]
        $PasswordValidityPeriodInDays,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance]
        $State,

        [Parameter()]
        [System.String[][]]
        $SupportedServices,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance[]]
        $DomainNameReferences,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance[]]
        $ServiceConfigurationRecords,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance[]]
        $VerificationDnsRecords,


        #endregion
        

        [Parameter(Mandatory = $true)]
        [System.String]
        [ValidateSet('Absent', 'Present')]
        $Ensure,

        [Parameter()]
        [System.Management.Automation.PSCredential]
        $Credential,

        [Parameter()]
        [System.String]
        $ApplicationId,

        [Parameter()]
        [System.String]
        $TenantId,

        [Parameter()]
        [System.String]
        $ApplicationSecret,

        [Parameter()]
        [System.String]
        $CertificateThumbprint
    )

    #Ensure the proper dependencies are installed in the current environment.
    Confirm-M365DSCDependencies

    #region Telemetry
    $ResourceName = $MyInvocation.MyCommand.ModuleName.Replace("MSFT_", "")
    $CommandName = $MyInvocation.MyCommand
    $data = Format-M365DSCTelemetryParameters -ResourceName $ResourceName `
        -CommandName $CommandName `
        -Parameters $PSBoundParameters
    Add-M365DSCTelemetryEvent -Data $data
    #endregion

    Write-Verbose -Message "Testing configuration of {$id}"

    $CurrentValues = Get-TargetResource @PSBoundParameters

    Write-Verbose -Message "Current Values: $(Convert-M365DscHashtableToString -Hashtable $CurrentValues)"
    Write-Verbose -Message "Target Values: $(Convert-M365DscHashtableToString -Hashtable $PSBoundParameters)"

    $ValuesToCheck = $PSBoundParameters
    $ValuesToCheck.Remove('Credential') | Out-Null
    $ValuesToCheck.Remove('ApplicationId') | Out-Null
    $ValuesToCheck.Remove('TenantId') | Out-Null
    $ValuesToCheck.Remove('ApplicationSecret') | Out-Null

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
        [Parameter()]
        [System.Management.Automation.PSCredential]
        $Credential,

        [Parameter()]
        [System.String]
        $ApplicationId,

        [Parameter()]
        [System.String]
        $TenantId,

        [Parameter()]
        [System.String]
        $ApplicationSecret,

        [Parameter()]
        [System.String]
        $CertificateThumbprint
    )

    $ConnectionMode = New-M365DSCConnection -Workload 'MicrosoftGraph' `
        -InboundParameters $PSBoundParameters `
        -ProfileName 'v1.0'

    #Ensure the proper dependencies are installed in the current environment.
    Confirm-M365DSCDependencies

    #region Telemetry
    $ResourceName = $MyInvocation.MyCommand.ModuleName.Replace("MSFT_", "")
    $CommandName = $MyInvocation.MyCommand
    $data = Format-M365DSCTelemetryParameters -ResourceName $ResourceName `
        -CommandName $CommandName `
        -Parameters $PSBoundParameters
    Add-M365DSCTelemetryEvent -Data $data
    #endregion

    try
    {
        
        #region resource generator code
        [array]$getValue = Get-MgDomain `
            -ErrorAction Stop | Where-Object `
            -FilterScript {
                $_.AdditionalProperties.'@odata.type' -eq '#microsoft.graph.domain' 
            }

        if (-not $getValue)
        {
            [array]$getValue = Get-MgDomain `
                -ErrorAction Stop
        }
        #endregion
        

        $i = 1
        $dscContent = ''
        if ($getValue.Length -eq 0)
        {
            Write-Host $Global:M365DSCEmojiGreenCheckMark
        }
        else
        {
            Write-Host "`r`n" -NoNewline
        }
        foreach ($config in $getValue)
        {
            Write-Host "    |---[$i/$($getValue.Count)] $($config.id)" -NoNewline
            $params = @{
                id           = $config.id
                Ensure                = 'Present'
                Credential            = $Credential
                ApplicationId         = $ApplicationId
                TenantId              = $TenantId
                ApplicationSecret     = $ApplicationSecret
                CertificateThumbprint = $CertificateThumbprint
            }

            $Results = Get-TargetResource @Params
            $Results = Update-M365DSCExportAuthenticationResults -ConnectionMode $ConnectionMode `
                -Results $Results
                    if ($Results.State)
        {
            $complexTypeStringResult = Get-M365DSCDRGComplexTypeToString -ComplexObject $Results.State -CIMInstanceName MicrosoftGraphdomainstate
            if ($complexTypeStringResult)
            {
                $Results.State = $complexTypeStringResult            }
            else
            {
                $Results.Remove('State') | Out-Null            }
        }
        if ($Results.DomainNameReferences)
        {
            $complexTypeStringResult = Get-M365DSCDRGComplexTypeToString -ComplexObject $Results.DomainNameReferences -CIMInstanceName MicrosoftGraphdirectoryobject
            if ($complexTypeStringResult)
            {
                $Results.DomainNameReferences = $complexTypeStringResult            }
            else
            {
                $Results.Remove('DomainNameReferences') | Out-Null            }
        }
        if ($Results.ServiceConfigurationRecords)
        {
            $complexTypeStringResult = Get-M365DSCDRGComplexTypeToString -ComplexObject $Results.ServiceConfigurationRecords -CIMInstanceName MicrosoftGraphdomaindnsrecord
            if ($complexTypeStringResult)
            {
                $Results.ServiceConfigurationRecords = $complexTypeStringResult            }
            else
            {
                $Results.Remove('ServiceConfigurationRecords') | Out-Null            }
        }
        if ($Results.VerificationDnsRecords)
        {
            $complexTypeStringResult = Get-M365DSCDRGComplexTypeToString -ComplexObject $Results.VerificationDnsRecords -CIMInstanceName MicrosoftGraphdomaindnsrecord
            if ($complexTypeStringResult)
            {
                $Results.VerificationDnsRecords = $complexTypeStringResult            }
            else
            {
                $Results.Remove('VerificationDnsRecords') | Out-Null            }
        }

            $currentDSCBlock = Get-M365DSCExportContentForResource -ResourceName $ResourceName `
                -ConnectionMode $ConnectionMode `
                -ModulePath $PSScriptRoot `
                -Results $Results `
                -Credential $Credential
                    if ($Results.State)
        {
            $currentDSCBlock = Convert-DSCStringParamToVariable -DSCBlock $currentDSCBlock -ParameterName "State"
        }
        if ($Results.DomainNameReferences)
        {
            $currentDSCBlock = Convert-DSCStringParamToVariable -DSCBlock $currentDSCBlock -ParameterName "DomainNameReferences"
        }
        if ($Results.ServiceConfigurationRecords)
        {
            $currentDSCBlock = Convert-DSCStringParamToVariable -DSCBlock $currentDSCBlock -ParameterName "ServiceConfigurationRecords"
        }
        if ($Results.VerificationDnsRecords)
        {
            $currentDSCBlock = Convert-DSCStringParamToVariable -DSCBlock $currentDSCBlock -ParameterName "VerificationDnsRecords"
        }

            $dscContent += $currentDSCBlock
            Save-M365DSCPartialExport -Content $currentDSCBlock `
                -FileName $Global:PartialExportFileName
            $i++
            Write-Host $Global:M365DSCEmojiGreenCheckMark
        }
        return $dscContent
    }
    catch
    {
        Write-Host $Global:M365DSCEmojiGreenCheckMark
        try
        {
            Write-Verbose -Message $_
            $tenantIdValue = ""
            if (-not [System.String]::IsNullOrEmpty($TenantId))
            {
                $tenantIdValue = $TenantId
            }
            elseif ($null -ne $Credential)
            {
                $tenantIdValue = $Credential.UserName.Split('@')[1]
            }
            Add-M365DSCEvent -Message $_ -EntryType 'Error' `
                -EventID 1 -Source $($MyInvocation.MyCommand.Source) `
                -TenantId $tenantIdValue
        }
        catch
        {
            Write-Verbose -Message $_
        }
        return ""
    }
}


function Get-M365DSCDRGComplexTypeToHashtable
{
    [CmdletBinding()]
    [OutputType([System.Collections.Hashtable])]
    param(
        [Parameter(Mandatory = 'true')]
        [System.Object]
        $ComplexObject
    )

    $keys = $ComplexObject | Get-Member | Where-Object -FilterScript {$_.MemberType -eq 'Property' -and $_.Name -ne 'AdditionalProperties'}
    $results = @{}
    foreach ($key in $keys)
    {
        $results.Add($key.Name, $ComplexObject.$($key.Name))
    }
    return $results
}

function Get-M365DSCDRGComplexTypeToString
{
    [CmdletBinding()]
    [OutputType([System.String])]
    param(
        [Parameter(Mandatory = $true)]
        [System.Collections.Hashtable]
        $ComplexObject,

        [Parameter(Mandatory = $true)]
        [System.String]
        $CIMInstanceName
    )
    if ($null -eq $ComplexObject)
    {
        return $null
    }
    $currentProperty = "MSFT_$CIMInstanceName{`r`n"
    $keyNotNull = 0
    foreach ($key in $ComplexObject.Keys)
    {
        if ($ComplexObject[$key])
        {
            $keyNotNull++

            if ($ComplexObject[$key].GetType().Name -eq 'Boolean')
            {
                $currentProperty += "                " + $key + " = `$" + $ComplexObject[$key].ToString() + "`r`n"
            }
            else
            {
                $currentProperty += "                " + $key + " = '" + $ComplexObject[$key] + "'`r`n"
            }
        }
    }
    $currentProperty += "            }"

    if ($keyNotNull -eq 0)
    {
        $currentProperty = $null
    }
    return $currentProperty
}

function Get-M365DSCAdditionalProperties
{
    [CmdletBinding()]
    [OutputType([System.Collections.Hashtable])]
    param(
        [Parameter(Mandatory = 'true')]
        [System.Collections.Hashtable]
        $Properties
    )

    $results = @{"@odata.type" = "#microsoft.graph.domain" }
    foreach ($property in $properties.Keys)
    {
        if ($property -ne 'Verbose')
        {
            $propertyName = $property[0].ToString().ToLower() + $property.Substring(1, $property.Length - 1)
            $propertyValue = $properties.$property
            $results.Add($propertyName, $propertyValue)
        }
    }
    return $results
}

Export-ModuleMember -Function *-TargetResource
