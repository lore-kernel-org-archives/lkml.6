Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752983AbeE2FZk (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 01:25:40 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:39299 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750880AbeE2FZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 01:25:36 -0400
X-Google-Smtp-Source: AB8JxZovYW0oGcXfZ8QBF2dJZwikACVJR1wYT/YIrh6aWhxTm+AumHe7YOLwAUSelw+sPgkNanBm6YXe2vVQVwhYXQc=
MIME-Version: 1.0
In-Reply-To: <20180528100240.256525891@linuxfoundation.org>
References: <20180528100240.256525891@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 29 May 2018 10:55:34 +0530
Message-ID: <CA+G9fYu1NuW6vB+bHEsYSmyJAB27kw8vP=0uwhVR962Yq4C43g@mail.gmail.com>
Subject: Re: [PATCH 4.16 000/272] 4.16.13-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: open list <linux-kernel@vger.kernel.org>,
        Shuah Khan <shuah@kernel.org>, patches@kernelci.org,
        lkft-triage@lists.linaro.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        linux- stable <stable@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>, dave@stgolabs.net
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4T5Plpd026966

On 28 May 2018 at 15:30, Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> This is the start of the stable review cycle for the 4.16.13 release.
> There are 272 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed May 30 10:01:02 UTC 2018.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.16.13-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.16.y
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

kernel: 4.16.13-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
git branch: linux-4.16.y
git commit: ca67f014e67013cd3d8312e68d2967332dae8654
git describe: v4.16.12-273-gca67f014e670
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.16-oe/build/v4.16.12-273-gca67f014e670


No regressions (compared to build v4.16.12-271-g2cb370dedebb)


Ran 10312 total tests in the following environments and test suites.

Environments
--------------
- dragonboard-410c - arm64
- hi6220-hikey - arm64
- juno-r2 - arm64
- qemu_arm
- qemu_arm64
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
* ltp-fcntl-locktests-tests
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
* ltp-timers-tests
* ltp-cve-tests
* ltp-filecaps-tests
* ltp-syscalls-tests
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none

-- 
Linaro LKFT
https://lkft.linaro.org
