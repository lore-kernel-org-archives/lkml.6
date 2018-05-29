Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754529AbeE2GN0 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 02:13:26 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36159 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751800AbeE2GNX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 02:13:23 -0400
X-Google-Smtp-Source: ADUXVKIVMCYm0yQZONR/yid8lE5TvwEVH0chm1LXrmUWRusMvluDC8DVavcY+d3hSep9Y0n87z4+OKS0sWqXsYLp4Wk=
MIME-Version: 1.0
In-Reply-To: <20180528100202.045206534@linuxfoundation.org>
References: <20180528100202.045206534@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 29 May 2018 11:43:21 +0530
Message-ID: <CA+G9fYu1c7-Lvp33kMdkvbA-easRh8=qKuM-3ErDEdLUiwV8Aw@mail.gmail.com>
Subject: Re: [PATCH 4.4 000/268] 4.4.134-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: open list <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>, Shuah Khan <shuah@kernel.org>,
        patches@kernelci.org, Ben Hutchings <ben.hutchings@codethink.co.uk>,
        lkft-triage@lists.linaro.org, linux- stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4T6Dex5030487

On 28 May 2018 at 15:29, Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> This is the start of the stable review cycle for the 4.4.134 release.
> There are 268 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed May 30 10:00:40 UTC 2018.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.134-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.4.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro’s test farm.
No regressions on arm64, arm and x86_64.

NOTE:
The failed LTP test case "cve-2017-5669" is a waiver here.

Summary
------------------------------------------------------------------------

kernel: 4.4.134-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
git branch: linux-4.4.y
git commit: 186b201a52cb29a2970391841c16a97833fe7119
git describe: v4.4.133-269-g186b201a52cb
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.4-oe/build/v4.4.133-269-g186b201a52cb

No regressions (compared to build v4.4.133-270-gc7a377784d68)

Ran 7070 total tests in the following environments and test suites.

Environments
--------------
- juno-r2 - arm64
- qemu_arm
- qemu_x86_64
- x15 - arm
- x86_64

Test Suites
-----------
* boot
* kselftest
* libhugetlbfs
* ltp-cap_bounds-tests
* ltp-containers-tests
* ltp-cve-tests
* ltp-fcntl-locktests-tests
* ltp-filecaps-tests
* ltp-fs-tests
* ltp-fs_bind-tests
* ltp-fs_perms_simple-tests
* ltp-fsx-tests
* ltp-hugetlb-tests
* ltp-io-tests
* ltp-ipc-tests
* ltp-math-tests
* ltp-nptl-tests
* ltp-pty-tests
* ltp-sched-tests
* ltp-securebits-tests
* ltp-syscalls-tests
* ltp-timers-tests
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none

Hikey test results,
Summary
------------------------------------------------------------------------

kernel: 4.4.134-rc1
git repo: https://git.linaro.org/lkft/arm64-stable-rc.git
git branch: 4.4.134-rc1-hikey-20180528-206
git commit: c4a9948ea47675e12c3f2a5ff009b2d0cb6c7517
git describe: 4.4.134-rc1-hikey-20180528-206
Test details: https://qa-reports.linaro.org/lkft/linaro-hikey-stable-rc-4.4-oe/build/4.4.134-rc1-hikey-20180528-206

No regressions (compared to build 4.4.134-rc1-hikey-20180528-205)

Ran 2655 total tests in the following environments and test suites.

Environments
--------------
- hi6220-hikey - arm64
- qemu_arm64

Test Suites
-----------
* boot
* kselftest
* libhugetlbfs
* ltp-cap_bounds-tests
* ltp-containers-tests
* ltp-cve-tests
* ltp-fcntl-locktests-tests
* ltp-filecaps-tests
* ltp-fs-tests
* ltp-fs_bind-tests
* ltp-fs_perms_simple-tests
* ltp-fsx-tests
* ltp-hugetlb-tests
* ltp-io-tests
* ltp-ipc-tests
* ltp-math-tests
* ltp-nptl-tests
* ltp-pty-tests
* ltp-sched-tests
* ltp-securebits-tests
* ltp-syscalls-tests
* ltp-timers-tests

-- 
Linaro LKFT
https://lkft.linaro.org
