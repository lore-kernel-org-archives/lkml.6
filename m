Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="B7lUBwjd"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D5F4B606DD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751904AbeFFLS0 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 07:18:26 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:44120 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751018AbeFFLSY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 07:18:24 -0400
X-Google-Smtp-Source: ADUXVKJINIb8RViTIvnYbD+ENwApkvF4nw7sFkl/m9e3rpg7drv3CURiYaxaMN30ztzzGrRSkher8pjBKrRvglwf0E4=
MIME-Version: 1.0
In-Reply-To: <20180605170108.884872354@linuxfoundation.org>
References: <20180605170108.884872354@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 6 Jun 2018 16:48:21 +0530
Message-ID: <CA+G9fYsVEn_v+BxVc-SOnDJB4GYHmhzJzeYgJ2bZ+hKkwxJcwA@mail.gmail.com>
Subject: Re: [PATCH 4.4 00/37] 4.4.136-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: open list <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Shuah Khan <shuah@kernel.org>, patches@kernelci.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        lkft-triage@lists.linaro.org,
        linux- stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5 June 2018 at 22:31, Greg Kroah-Hartman <gregkh@linuxfoundation.org> wr=
ote:
> This is the start of the stable review cycle for the 4.4.136 release.
> There are 37 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu Jun  7 17:00:49 UTC 2018.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.4.136-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.4.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm and x86_64.

Summary
------------------------------------------------------------------------

kernel: 4.4.136-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.4.y
git commit: 76660a93b7c1d7bec53de456989adb274f87eceb
git describe: v4.4.135-38-g76660a93b7c1
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.4-oe/bui=
ld/v4.4.135-38-g76660a93b7c1


No regressions (compared to build v4.4.134)


Ran 5471 total tests in the following environments and test suites.

Environments
--------------
- juno-r2 - arm64
- qemu_arm
- qemu_x86_64
- x15
- x86_64

Test Suites
-----------
* boot
* kselftest
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
* libhugetlbfs
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none
Summary
------------------------------------------------------------------------

kernel: 4.4.136-rc1
git repo: https://git.linaro.org/lkft/arm64-stable-rc.git
git branch: 4.4.136-rc1-hikey-20180605-211
git commit: bb7d86744ed254b725010f58f6a0f5f884284111
git describe: 4.4.136-rc1-hikey-20180605-211
Test details: https://qa-reports.linaro.org/lkft/linaro-hikey-stable-rc-4.4=
-oe/build/4.4.136-rc1-hikey-20180605-211


No regressions (compared to build 4.4.136-rc1-hikey-20180604-209)


Ran 2593 total tests in the following environments and test suites.

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
* ltp-fs_bind-tests
* ltp-fs_perms_simple-tests
* ltp-fsx-tests
* ltp-hugetlb-tests
* ltp-io-tests
* ltp-ipc-tests
* ltp-math-tests
* ltp-nptl-tests
* ltp-pty-tests
* ltp-securebits-tests
* ltp-syscalls-tests
* ltp-timers-tests
* ltp-fs-tests
* ltp-sched-tests

--=20
Linaro LKFT
https://lkft.linaro.org
