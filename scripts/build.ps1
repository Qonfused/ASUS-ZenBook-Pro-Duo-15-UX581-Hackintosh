## @file
# EFI build script for the UX581GV/UX581LV
#
# Copyright (c) 2023, Cory Bennett. All rights reserved.
# SPDX-License-Identifier: BSD-3-Clause
##

[CmdletBinding(PositionalBinding=$false)]
param (
  [string]$pwd = "$((Get-Item "$PSScriptRoot\..").FullName)",
  # Script arguments
  [parameter(ValueFromRemainingArguments)][string[]]$arguments
)

function HasFlag {
  param ([string]$flag)

  if ($arguments -eq $flag) {
    $arguments = $arguments -ne $flag
    return $true
  }

  return $false
}


# Switches for additional '--UX581GV' patches
$patches = @('-p config.yml')
if (HasFlag '--UX581GV') { $patches += @('-p patch.UX581GV.yml') }

icm `
  -ScriptBlock $([Scriptblock]::Create($(iwr 'https://raw.githubusercontent.com/Qonfused/OCE-Build/main/ci/bootstrap.ps1'))) `
  -ArgumentList (@("build -c $pwd $patches") + $arguments)
