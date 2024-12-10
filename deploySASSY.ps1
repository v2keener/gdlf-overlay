# Must have sass available to CLI

# Note that all the following is using PowerShell (pwsh) on Windows 10/11

# directory of $dot_obsidian_folder should be `your-vault/.obsidian`
#  It's the first parameter (e.g. `.\deploySASSY.ps1 'C:\your-vault\.obsidian' `)

#  (The .obsidian folder)

$dot_obsidian_folder = $args[0]

# Don't do this if the folder isn't a folder
if(!(Test-Path $dot_obsidian_folder))
{
  # (Note that Test-Path didn't care if the 
  # folder is really a vault's .obsidian folder)
  
  Write-Host (".obsidian folder of '" + $dot_obsidian_folder + "' not found")
  Exit
}

# # The pwsh commands I use to administer these `sass` Jobs are typically:
# Get-Job # see what's running
# Get-Job | Receive-Job # look at output
# Get-Job | Stop-Job ; Get-Job | Remove-Job # Stop and remove jobs

Write-Output @'
This will run some jobs to create:

- snippets/gdlf-overlay.css
- snippets/gdlf-for-me.css
- snippets/gdlf-full-overlay.css
- themes/Overlay/theme.css

- (optional, uncomment the lines)
  - snippets/plugin-reminders.css
  - snippets/plugin-grandfather.css 
  - snippets/plugin-todo-list.css

  Of the optional ones, the grandfather.css CSS is most current

'@
Write-Output ("CSS for the dot_obsidian_folder will be written to " + $dot_obsidian_folder)

# Print settings (settings for PDF, printing)
sass -w .\mixins\gdlf-media-print.scss "$dot_obsidian_folder\snippets\gdlf-media-print.css" --no-source-map &
sass -w .\mixins\gdlf-media-print.scss ".\gdlf-media-print.css" --no-source-map &

# The SCSS files that combine all the mixins to be useful while 
# containing all the Style Settings for each mixin in each of 
# the two following files
sass -w ".\gdlf-overlay.scss" "$dot_obsidian_folder\snippets\gdlf-overlay.css" --no-source-map &
# ...and one for the project folder
sass -w ".\gdlf-overlay.scss" ".\gdlf-overlay.css" --no-source-map &

sass -w ".\gdlf-for-me-wrapper.scss" "$dot_obsidian_folder\snippets\gdlf-for-me.css" --no-source-map &
# ...and one for the project folder
sass -w ".\gdlf-for-me-wrapper.scss" ".\gdlf-for-me.css" --no-source-map &

# Overlay with stuff for me included
sass -w ".\gdlf-overlay-combined.scss" "$dot_obsidian_folder\snippets\gdlf-full-overlay.css" --no-source-map &
# ...and one for the project folder
sass -w ".\gdlf-overlay-combined.scss" ".\gdlf-full-overlay.css" --no-source-map &

# For the next command to work, you need an "Overlay" 
# folder under your "themes" directory...

$overlay_path = $( Join-Path $dot_obsidian_folder "/themes/Overlay" )
If(!(Test-Path -Path $overlay_path))
{
  Write-Host "Creating Overlay theme folder..."
  # adapted from https://stackoverflow.com/questions/16906170/create-directory-if-it-does-not-exist#46714857 
  New-Item -ItemType Directory -Path $overlay_path -Force | Out-Null
  Copy-Item .\manifest.json $overlay_path -Force | Out-Null
}

# Render the actual theme.css
sass -w ".\gdlf-overlay-theme.scss" "$dot_obsidian_folder\themes\Overlay\theme.css" --no-source-map &
# ...and one for the project folder
sass -w ".\gdlf-overlay-theme.scss" ".\theme.css" --no-source-map &

# # Now do plugins last
# sass -w ".\mixins\plugin-reminders.scss" "$dot_obsidian_folder\snippets\plugin-reminders.css" --no-source-map &
# sass -w ".\mixins\plugin-reminders.scss" ".\plugin-reminders.css" --no-source-map &
sass -w ".\mixins\plugin-grandfather.scss" "$dot_obsidian_folder\snippets\plugin-grandfather.css" --no-source-map &
sass -w ".\mixins\plugin-grandfather.scss" ".\plugin-grandfather.css" --no-source-map &
# sass -w ".\mixins\plugin-todo-list.scss" "$dot_obsidian_folder\snippets\plugin-todo-list.css" --no-source-map &
# sass -w ".\mixins\plugin-todo-list.scss" ".\plugin-todo-list.css" --no-source-map &

# SIG # Begin signature block
# MIIb9QYJKoZIhvcNAQcCoIIb5jCCG+ICAQExDzANBglghkgBZQMEAgEFADB5Bgor
# BgEEAYI3AgEEoGswaTA0BgorBgEEAYI3AgEeMCYCAwEAAAQQH8w7YFlLCE63JNLG
# KX7zUQIBAAIBAAIBAAIBAAIBADAxMA0GCWCGSAFlAwQCAQUABCBJHi1t5OqVJVBD
# Jk/D2pwtvgmv/AiMThNXy0ailNUhF6CCFjMwggMsMIICFKADAgECAhAmY8q3eDla
# lkPEemb7ee0xMA0GCSqGSIb3DQEBCwUAMC4xLDAqBgNVBAMMI1Bvd2VyU2hlbGwg
# Q29kZSBTaWduaW5nIENlcnQgLSBHRExGMB4XDTI0MDYxNzE0MzQzMFoXDTI1MDYx
# NzE0NTQzMFowLjEsMCoGA1UEAwwjUG93ZXJTaGVsbCBDb2RlIFNpZ25pbmcgQ2Vy
# dCAtIEdETEYwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCfJkHLvZ8m
# +Z5PkvhRFYH6WsNgtwWKxE0YUzuDEr/l8y1OmQVdOXfK5H34bz27f6hF8aVb6DWw
# niX7ivDcxFoNLfVDD3bgonNngfnF+xiRJS7f3CO5uT3/8Rfuq0DEHrNjIHlDjoWa
# zYJYCoTcnqBdikwYcYCsA7fcrSEw27BcTxGklAP0hQSrAnilBT11qLt98A1P+8KI
# 9P0PlBFlI1JhtT1C85gWPVIlA/szIXIm503QBAVES9V/tM/1fVtaWEsgCXlQjM1h
# RhIFCdEv+0HRog754Y3HebNduf9iKJysWpKuHqPfzfGBDHZ4gLwHrayAkn13tbEp
# 1RCV4oN9bfAhAgMBAAGjRjBEMA4GA1UdDwEB/wQEAwIHgDATBgNVHSUEDDAKBggr
# BgEFBQcDAzAdBgNVHQ4EFgQUQ99s9IwqmVM4X7VxlYA1+uv/qJkwDQYJKoZIhvcN
# AQELBQADggEBAFC4K3tIJkcwb3wOEKlfT7WG4bCFyu+0AQsXGMn8Ap1v5y5M2XlI
# G9S6ZJQ+AYJAe+NMyoz6LoKAFwVzM3HujRPaowFtjcefvOPAVDBhVp96CQe10iG6
# kUMYxfvTlh0QbRdOgWvgArFsOGm7KMrPbp2UErFucjze+xgKX43m3EsrG9DAo69V
# 77OAy4tsrnKKt1jPpeMcC/ivcxj1aiCB1mHrJlMuy8xGsokx1vAKLz9FA4D0gFlI
# JBMhhphGPGa1iEkCBL37CTa0FxQktTfnV72EauYt+v2gW1m67Fe1Pzc0RnMpElYb
# k3JiWtvAQB60HW9Eqmm+f9BP5vn2cyIUcu0wggWNMIIEdaADAgECAhAOmxiO+dAt
# 5+/bUOIIQBhaMA0GCSqGSIb3DQEBDAUAMGUxCzAJBgNVBAYTAlVTMRUwEwYDVQQK
# EwxEaWdpQ2VydCBJbmMxGTAXBgNVBAsTEHd3dy5kaWdpY2VydC5jb20xJDAiBgNV
# BAMTG0RpZ2lDZXJ0IEFzc3VyZWQgSUQgUm9vdCBDQTAeFw0yMjA4MDEwMDAwMDBa
# Fw0zMTExMDkyMzU5NTlaMGIxCzAJBgNVBAYTAlVTMRUwEwYDVQQKEwxEaWdpQ2Vy
# dCBJbmMxGTAXBgNVBAsTEHd3dy5kaWdpY2VydC5jb20xITAfBgNVBAMTGERpZ2lD
# ZXJ0IFRydXN0ZWQgUm9vdCBHNDCCAiIwDQYJKoZIhvcNAQEBBQADggIPADCCAgoC
# ggIBAL/mkHNo3rvkXUo8MCIwaTPswqclLskhPfKK2FnC4SmnPVirdprNrnsbhA3E
# MB/zG6Q4FutWxpdtHauyefLKEdLkX9YFPFIPUh/GnhWlfr6fqVcWWVVyr2iTcMKy
# unWZanMylNEQRBAu34LzB4TmdDttceItDBvuINXJIB1jKS3O7F5OyJP4IWGbNOsF
# xl7sWxq868nPzaw0QF+xembud8hIqGZXV59UWI4MK7dPpzDZVu7Ke13jrclPXuU1
# 5zHL2pNe3I6PgNq2kZhAkHnDeMe2scS1ahg4AxCN2NQ3pC4FfYj1gj4QkXCrVYJB
# MtfbBHMqbpEBfCFM1LyuGwN1XXhm2ToxRJozQL8I11pJpMLmqaBn3aQnvKFPObUR
# WBf3JFxGj2T3wWmIdph2PVldQnaHiZdpekjw4KISG2aadMreSx7nDmOu5tTvkpI6
# nj3cAORFJYm2mkQZK37AlLTSYW3rM9nF30sEAMx9HJXDj/chsrIRt7t/8tWMcCxB
# YKqxYxhElRp2Yn72gLD76GSmM9GJB+G9t+ZDpBi4pncB4Q+UDCEdslQpJYls5Q5S
# UUd0viastkF13nqsX40/ybzTQRESW+UQUOsxxcpyFiIJ33xMdT9j7CFfxCBRa2+x
# q4aLT8LWRV+dIPyhHsXAj6KxfgommfXkaS+YHS312amyHeUbAgMBAAGjggE6MIIB
# NjAPBgNVHRMBAf8EBTADAQH/MB0GA1UdDgQWBBTs1+OC0nFdZEzfLmc/57qYrhwP
# TzAfBgNVHSMEGDAWgBRF66Kv9JLLgjEtUYunpyGd823IDzAOBgNVHQ8BAf8EBAMC
# AYYweQYIKwYBBQUHAQEEbTBrMCQGCCsGAQUFBzABhhhodHRwOi8vb2NzcC5kaWdp
# Y2VydC5jb20wQwYIKwYBBQUHMAKGN2h0dHA6Ly9jYWNlcnRzLmRpZ2ljZXJ0LmNv
# bS9EaWdpQ2VydEFzc3VyZWRJRFJvb3RDQS5jcnQwRQYDVR0fBD4wPDA6oDigNoY0
# aHR0cDovL2NybDMuZGlnaWNlcnQuY29tL0RpZ2lDZXJ0QXNzdXJlZElEUm9vdENB
# LmNybDARBgNVHSAECjAIMAYGBFUdIAAwDQYJKoZIhvcNAQEMBQADggEBAHCgv0Nc
# Vec4X6CjdBs9thbX979XB72arKGHLOyFXqkauyL4hxppVCLtpIh3bb0aFPQTSnov
# Lbc47/T/gLn4offyct4kvFIDyE7QKt76LVbP+fT3rDB6mouyXtTP0UNEm0Mh65Zy
# oUi0mcudT6cGAxN3J0TU53/oWajwvy8LpunyNDzs9wPHh6jSTEAZNUZqaVSwuKFW
# juyk1T3osdz9HNj0d1pcVIxv76FQPfx2CWiEn2/K2yCNNWAcAgPLILCsWKAOQGPF
# mCLBsln1VWvPJ6tsds5vIy30fnFqI2si/xK4VC0nftg62fC2h5b9W9FcrBjDTZ9z
# twGpn1eqXijiuZQwggauMIIElqADAgECAhAHNje3JFR82Ees/ShmKl5bMA0GCSqG
# SIb3DQEBCwUAMGIxCzAJBgNVBAYTAlVTMRUwEwYDVQQKEwxEaWdpQ2VydCBJbmMx
# GTAXBgNVBAsTEHd3dy5kaWdpY2VydC5jb20xITAfBgNVBAMTGERpZ2lDZXJ0IFRy
# dXN0ZWQgUm9vdCBHNDAeFw0yMjAzMjMwMDAwMDBaFw0zNzAzMjIyMzU5NTlaMGMx
# CzAJBgNVBAYTAlVTMRcwFQYDVQQKEw5EaWdpQ2VydCwgSW5jLjE7MDkGA1UEAxMy
# RGlnaUNlcnQgVHJ1c3RlZCBHNCBSU0E0MDk2IFNIQTI1NiBUaW1lU3RhbXBpbmcg
# Q0EwggIiMA0GCSqGSIb3DQEBAQUAA4ICDwAwggIKAoICAQDGhjUGSbPBPXJJUVXH
# JQPE8pE3qZdRodbSg9GeTKJtoLDMg/la9hGhRBVCX6SI82j6ffOciQt/nR+eDzMf
# UBMLJnOWbfhXqAJ9/UO0hNoR8XOxs+4rgISKIhjf69o9xBd/qxkrPkLcZ47qUT3w
# 1lbU5ygt69OxtXXnHwZljZQp09nsad/ZkIdGAHvbREGJ3HxqV3rwN3mfXazL6IRk
# tFLydkf3YYMZ3V+0VAshaG43IbtArF+y3kp9zvU5EmfvDqVjbOSmxR3NNg1c1eYb
# qMFkdECnwHLFuk4fsbVYTXn+149zk6wsOeKlSNbwsDETqVcplicu9Yemj052FVUm
# cJgmf6AaRyBD40NjgHt1biclkJg6OBGz9vae5jtb7IHeIhTZgirHkr+g3uM+onP6
# 5x9abJTyUpURK1h0QCirc0PO30qhHGs4xSnzyqqWc0Jon7ZGs506o9UD4L/wojzK
# QtwYSH8UNM/STKvvmz3+DrhkKvp1KCRB7UK/BZxmSVJQ9FHzNklNiyDSLFc1eSuo
# 80VgvCONWPfcYd6T/jnA+bIwpUzX6ZhKWD7TA4j+s4/TXkt2ElGTyYwMO1uKIqjB
# Jgj5FBASA31fI7tk42PgpuE+9sJ0sj8eCXbsq11GdeJgo1gJASgADoRU7s7pXche
# MBK9Rp6103a50g5rmQzSM7TNsQIDAQABo4IBXTCCAVkwEgYDVR0TAQH/BAgwBgEB
# /wIBADAdBgNVHQ4EFgQUuhbZbU2FL3MpdpovdYxqII+eyG8wHwYDVR0jBBgwFoAU
# 7NfjgtJxXWRM3y5nP+e6mK4cD08wDgYDVR0PAQH/BAQDAgGGMBMGA1UdJQQMMAoG
# CCsGAQUFBwMIMHcGCCsGAQUFBwEBBGswaTAkBggrBgEFBQcwAYYYaHR0cDovL29j
# c3AuZGlnaWNlcnQuY29tMEEGCCsGAQUFBzAChjVodHRwOi8vY2FjZXJ0cy5kaWdp
# Y2VydC5jb20vRGlnaUNlcnRUcnVzdGVkUm9vdEc0LmNydDBDBgNVHR8EPDA6MDig
# NqA0hjJodHRwOi8vY3JsMy5kaWdpY2VydC5jb20vRGlnaUNlcnRUcnVzdGVkUm9v
# dEc0LmNybDAgBgNVHSAEGTAXMAgGBmeBDAEEAjALBglghkgBhv1sBwEwDQYJKoZI
# hvcNAQELBQADggIBAH1ZjsCTtm+YqUQiAX5m1tghQuGwGC4QTRPPMFPOvxj7x1Bd
# 4ksp+3CKDaopafxpwc8dB+k+YMjYC+VcW9dth/qEICU0MWfNthKWb8RQTGIdDAiC
# qBa9qVbPFXONASIlzpVpP0d3+3J0FNf/q0+KLHqrhc1DX+1gtqpPkWaeLJ7giqzl
# /Yy8ZCaHbJK9nXzQcAp876i8dU+6WvepELJd6f8oVInw1YpxdmXazPByoyP6wCeC
# RK6ZJxurJB4mwbfeKuv2nrF5mYGjVoarCkXJ38SNoOeY+/umnXKvxMfBwWpx2cYT
# gAnEtp/Nh4cku0+jSbl3ZpHxcpzpSwJSpzd+k1OsOx0ISQ+UzTl63f8lY5knLD0/
# a6fxZsNBzU+2QJshIUDQtxMkzdwdeDrknq3lNHGS1yZr5Dhzq6YBT70/O3itTK37
# xJV77QpfMzmHQXh6OOmc4d0j/R0o08f56PGYX/sr2H7yRp11LB4nLCbbbxV7HhmL
# NriT1ObyF5lZynDwN7+YAN8gFk8n+2BnFqFmut1VwDophrCYoCvtlUG3OtUVmDG0
# YgkPCr2B2RP+v6TR81fZvAT6gt4y3wSJ8ADNXcL50CN/AAvkdgIm2fBldkKmKYcJ
# RyvmfxqkhQ/8mJb2VVQrH4D6wPIOK+XW+6kvRBVK5xMOHds3OBqhK/bt1nz8MIIG
# vDCCBKSgAwIBAgIQC65mvFq6f5WHxvnpBOMzBDANBgkqhkiG9w0BAQsFADBjMQsw
# CQYDVQQGEwJVUzEXMBUGA1UEChMORGlnaUNlcnQsIEluYy4xOzA5BgNVBAMTMkRp
# Z2lDZXJ0IFRydXN0ZWQgRzQgUlNBNDA5NiBTSEEyNTYgVGltZVN0YW1waW5nIENB
# MB4XDTI0MDkyNjAwMDAwMFoXDTM1MTEyNTIzNTk1OVowQjELMAkGA1UEBhMCVVMx
# ETAPBgNVBAoTCERpZ2lDZXJ0MSAwHgYDVQQDExdEaWdpQ2VydCBUaW1lc3RhbXAg
# MjAyNDCCAiIwDQYJKoZIhvcNAQEBBQADggIPADCCAgoCggIBAL5qc5/2lSGrljC6
# W23mWaO16P2RHxjEiDtqmeOlwf0KMCBDEr4IxHRGd7+L660x5XltSVhhK64zi9Ce
# C9B6lUdXM0s71EOcRe8+CEJp+3R2O8oo76EO7o5tLuslxdr9Qq82aKcpA9O//X6Q
# E+AcaU/byaCagLD/GLoUb35SfWHh43rOH3bpLEx7pZ7avVnpUVmPvkxT8c2a2yC0
# WMp8hMu60tZR0ChaV76Nhnj37DEYTX9ReNZ8hIOYe4jl7/r419CvEYVIrH6sN00y
# x49boUuumF9i2T8UuKGn9966fR5X6kgXj3o5WHhHVO+NBikDO0mlUh902wS/Eeh8
# F/UFaRp1z5SnROHwSJ+QQRZ1fisD8UTVDSupWJNstVkiqLq+ISTdEjJKGjVfIcsg
# A4l9cbk8Smlzddh4EfvFrpVNnes4c16Jidj5XiPVdsn5n10jxmGpxoMc6iPkoaDh
# i6JjHd5ibfdp5uzIXp4P0wXkgNs+CO/CacBqU0R4k+8h6gYldp4FCMgrXdKWfM4N
# 0u25OEAuEa3JyidxW48jwBqIJqImd93NRxvd1aepSeNeREXAu2xUDEW8aqzFQDYm
# r9ZONuc2MhTMizchNULpUEoA6Vva7b1XCB+1rxvbKmLqfY/M/SdV6mwWTyeVy5Z/
# JkvMFpnQy5wR14GJcv6dQ4aEKOX5AgMBAAGjggGLMIIBhzAOBgNVHQ8BAf8EBAMC
# B4AwDAYDVR0TAQH/BAIwADAWBgNVHSUBAf8EDDAKBggrBgEFBQcDCDAgBgNVHSAE
# GTAXMAgGBmeBDAEEAjALBglghkgBhv1sBwEwHwYDVR0jBBgwFoAUuhbZbU2FL3Mp
# dpovdYxqII+eyG8wHQYDVR0OBBYEFJ9XLAN3DigVkGalY17uT5IfdqBbMFoGA1Ud
# HwRTMFEwT6BNoEuGSWh0dHA6Ly9jcmwzLmRpZ2ljZXJ0LmNvbS9EaWdpQ2VydFRy
# dXN0ZWRHNFJTQTQwOTZTSEEyNTZUaW1lU3RhbXBpbmdDQS5jcmwwgZAGCCsGAQUF
# BwEBBIGDMIGAMCQGCCsGAQUFBzABhhhodHRwOi8vb2NzcC5kaWdpY2VydC5jb20w
# WAYIKwYBBQUHMAKGTGh0dHA6Ly9jYWNlcnRzLmRpZ2ljZXJ0LmNvbS9EaWdpQ2Vy
# dFRydXN0ZWRHNFJTQTQwOTZTSEEyNTZUaW1lU3RhbXBpbmdDQS5jcnQwDQYJKoZI
# hvcNAQELBQADggIBAD2tHh92mVvjOIQSR9lDkfYR25tOCB3RKE/P09x7gUsmXqt4
# 0ouRl3lj+8QioVYq3igpwrPvBmZdrlWBb0HvqT00nFSXgmUrDKNSQqGTdpjHsPy+
# LaalTW0qVjvUBhcHzBMutB6HzeledbDCzFzUy34VarPnvIWrqVogK0qM8gJhh/+q
# DEAIdO/KkYesLyTVOoJ4eTq7gj9UFAL1UruJKlTnCVaM2UeUUW/8z3fvjxhN6hdT
# 98Vr2FYlCS7Mbb4Hv5swO+aAXxWUm3WpByXtgVQxiBlTVYzqfLDbe9PpBKDBfk+r
# abTFDZXoUke7zPgtd7/fvWTlCs30VAGEsshJmLbJ6ZbQ/xll/HjO9JbNVekBv2Tg
# em+mLptR7yIrpaidRJXrI+UzB6vAlk/8a1u7cIqV0yef4uaZFORNekUgQHTqddms
# PCEIYQP7xGxZBIhdmm4bhYsVA6G2WgNFYagLDBzpmk9104WQzYuVNsxyoVLObhx3
# RugaEGru+SojW4dHPoWrUhftNpFC5H7QEY7MhKRyrBe7ucykW7eaCuWBsBb4HOKR
# FVDcrZgdwaSIqMDiCLg4D+TPVgKx2EgEdeoHNHT9l3ZDBD+XgbF+23/zBjeCtxz+
# dL/9NWR6P2eZRi7zcEO1xwcdcqJsyz/JceENc2Sg8h3KeFUCS7tpFk7CrDqkMYIF
# GDCCBRQCAQEwQjAuMSwwKgYDVQQDDCNQb3dlclNoZWxsIENvZGUgU2lnbmluZyBD
# ZXJ0IC0gR0RMRgIQJmPKt3g5WpZDxHpm+3ntMTANBglghkgBZQMEAgEFAKCBhDAY
# BgorBgEEAYI3AgEMMQowCKACgAChAoAAMBkGCSqGSIb3DQEJAzEMBgorBgEEAYI3
# AgEEMBwGCisGAQQBgjcCAQsxDjAMBgorBgEEAYI3AgEVMC8GCSqGSIb3DQEJBDEi
# BCAq/M3JBec+QOY9g9u3u3iZWbX6Vx+xZeQ3GZzRoy9pMjANBgkqhkiG9w0BAQEF
# AASCAQAjsw2rYR3A2OjXYR8+2FOK1nkSBWLgWSyd8EK/qz6IQ4ysaZj2cgRNHvcO
# 1nvzyiBJCPTyL54arjmHdAzm2WsAYPYnKRwq7vdZ6S90Ofpa1/MYjCEtmjqFkUGF
# v2H6gmbIZHCOWpbjSPof8CvGbXzzPAzUYwrw9RcWt/SnB4nQoKgN7QwAYn271wDx
# o94ORur3iaEqqhwUiWtIznwUfN/j1oFWe2/99YaWEVTdpZvgfvOzIW2ofcs8lMdO
# G9C8s6tdvWZHcHIZiqc3xTTQCx6Vex5MzWVuFl/8Anxs0FO3ndw/th6C3TXaaKVZ
# GRt+PrLEpLK/0lCQQS47GIJ+0TeeoYIDIDCCAxwGCSqGSIb3DQEJBjGCAw0wggMJ
# AgEBMHcwYzELMAkGA1UEBhMCVVMxFzAVBgNVBAoTDkRpZ2lDZXJ0LCBJbmMuMTsw
# OQYDVQQDEzJEaWdpQ2VydCBUcnVzdGVkIEc0IFJTQTQwOTYgU0hBMjU2IFRpbWVT
# dGFtcGluZyBDQQIQC65mvFq6f5WHxvnpBOMzBDANBglghkgBZQMEAgEFAKBpMBgG
# CSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MTIxMDE1
# MjI1NFowLwYJKoZIhvcNAQkEMSIEIPCYiTjqg4bgyR13Mv3IEylsHC6qkEFSVUDE
# bSyOHkGRMA0GCSqGSIb3DQEBAQUABIICAKCBuxWdRsRSziAXGOJCHntfwfpmMAMV
# O6Z4LsytADC1toDG4gYXp3BDzemyXTznxtkKtx08YJG7oTI+zx597H2Fl+hWxKpZ
# NET7HIKV52f/cklCb3smKXSBHa8QzVhy3BQy9GG0R5rffvLYrdxKoKhLyVEskPHx
# ecwvSzkyi2KwcKfBvrolBBoKhNNtNGFcG1X7u9KUFm++d8E8TsOmdfhXa8OxoJEA
# +Xg/zB5pWVacMocMK5V+eE+fytIsXTpCRhyKhXTQBiC8nNCurlgbLyOJbB95b0Tm
# Q+sWo5KPUJrrAkuZzOdSsqFwtLqZtOb4W2raO2CEmP2hmoZqc548gLvwbrhufUvf
# W3JgIrW7qVJdH+ZFadgT96LvCMDgVAKPhvSjK/vwgHs++WNUtv81ftlrCJNrohXg
# wmrUfQyvKvxNe1Yz8bZGSZVGIK5UZtLqtu6y5jWU7pjJ9iB9iVV/dfCTial12pND
# fDFz0YaCa62n4EkCVXPecjAG4F1+tlgKmjctr0Hb4n07+akFYL9LUJ9aeCP8nDrQ
# MwyfrD+anLeU7HmUoMg4KgIQ1gLCfzkGrMtyZDLg4kt/+/KqictsNLjhMqt7kZBc
# 79qtsn59SZPEfru8+PtTiVygnJEs2V5Pm2hXtmLOTEJtjz9hDfOCrX3gCdDUlM8X
# ks5cQGwpmHEc
# SIG # End signature block
