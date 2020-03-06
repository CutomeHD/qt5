#############################################################################
##
## Copyright (C) 2019 The Qt Company Ltd.
## Contact: http://www.qt.io/licensing/
##
## This file is part of the provisioning scripts of the Qt Toolkit.
##
## $QT_BEGIN_LICENSE:LGPL21$
## Commercial License Usage
## Licensees holding valid commercial Qt licenses may use this file in
## accordance with the commercial license agreement provided with the
## Software or, alternatively, in accordance with the terms contained in
## a written agreement between you and The Qt Company. For licensing terms
## and conditions see http://www.qt.io/terms-conditions. For further
## information use the contact form at http://www.qt.io/contact-us.
##
## GNU Lesser General Public License Usage
## Alternatively, this file may be used under the terms of the GNU Lesser
## General Public License version 2.1 or version 3 as published by the Free
## Software Foundation and appearing in the file LICENSE.LGPLv21 and
## LICENSE.LGPLv3 included in the packaging of this file. Please review the
## following information to ensure the GNU Lesser General Public License
## requirements will be met: https://www.gnu.org/licenses/lgpl.html and
## http://www.gnu.org/licenses/old-licenses/lgpl-2.1.html.
##
## As a special exception, The Qt Company gives you certain additional
## rights. These rights are described in The Qt Company LGPL Exception
## version 1.1, included in the file LGPL_EXCEPTION.txt in this package.
##
## $QT_END_LICENSE$
##
#############################################################################

. "$PSScriptRoot\helpers.ps1"

$majorminorversion = "3.17"
$version = "3.17.0-rc2"

$zip = Get-DownloadLocation ("cmake-" + $version + "-win32-x86.zip")
$officialurl = "https://cmake.org/files/v" + $majorminorversion + "/cmake-" + $version + "-win32-x86.zip"
$cachedurl = "\\ci-files01-hki.intra.qt.io\provisioning\cmake\cmake-" + $version + "-win32-x86.zip"

Write-Host "Removing old cmake"
Remove-Item "C:\CMake" -Force -Recurse -ErrorAction SilentlyContinue

Download $officialurl $cachedurl $zip
Verify-Checksum $zip "db10f03227b978a51c76453283f3280fc63c157d"

Extract-7Zip $zip C:
$defaultinstallfolder = "C:\cmake-" + $version + "-win32-x86"
Rename-Item $defaultinstallfolder C:\CMake

Add-Path "C:\CMake\bin"

Write-Output "CMake = $version" >> ~\versions.txt

