Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932364AbeCNS1F (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 14:27:05 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:45048 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932327AbeCNS07 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 14:26:59 -0400
X-Google-Smtp-Source: AG47ELuY+bWTB6/WbSqaO+xFoR/XWbLwC86hlAkCVhCTvDnhhhwPdMjL3+B7ArZlLfQSbE6tmiXsVluPWFiH3hc1aa0=
MIME-Version: 1.0
In-Reply-To: <20180314105535.GF32615@kroah.com>
References: <20180313152458.201155692@linuxfoundation.org> <20180314105535.GF32615@kroah.com>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 14 Mar 2018 23:56:56 +0530
Message-ID: <CA+G9fYsULq=7sX_-aYtTru+1OXQ4V+1L1GJr2EjFGQiz5kmw1A@mail.gmail.com>
Subject: Re: [PATCH 4.14 000/140] 4.14.27-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: open list <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Shuah Khan <shuahkh@osg.samsung.com>, patches@kernelci.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        lkft-triage@lists.linaro.org, linux- stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w2EIR9tw031648

On 14 March 2018 at 16:25, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Tue, Mar 13, 2018 at 04:23:23PM +0100, Greg Kroah-Hartman wrote:
>> This is the start of the stable review cycle for the 4.14.27 release.
>> There are 140 patches in this series, all will be posted as a response
>> to this one.  If anyone has any issues with these being applied, please
>> let me know.
>>
>> Responses should be made by Thu Mar 15 15:24:23 UTC 2018.
>> Anything received after that time might be too late.
>>
>> The whole patch series can be found in one patch at:
>>       https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.27-rc1.gz
>> or in the git tree and branch at:
>>       git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.14.y
>
> -rc2 is out, to fix a boot issue on some ARM boards:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.27-rc2.gz
>
> thanks,
>
> greg k-h

Results from Linaro’s test farm.
No regressions on arm64, arm, qemu_x86_64 and x86_64.

Summary
------------------------------------------------------------------------

kernel: 4.14.27-rc2
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
git branch: linux-4.14.y
git commit: 2a1700a4929fe8b01325db52327d4038406814fd
git describe: v4.14.26-140-g2a1700a4929f
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.14-oe/build/v4.14.26-140-g2a1700a4929f


No regressions (compared to build v4.14.26-141-g7ba3c4cdde59)

Boards, architectures and test suites:
-------------------------------------

dragonboard-410c - arm64
* boot - pass: 20,
* kselftest - pass: 45, skip: 20,
* libhugetlbfs - pass: 90, skip: 1,
* ltp-cap_bounds-tests - pass: 2,
* ltp-containers-tests - pass: 64, skip: 17,
* ltp-fcntl-locktests-tests - pass: 2,
* ltp-filecaps-tests - pass: 2,
* ltp-fs-tests - pass: 61, skip: 2,
* ltp-fs_bind-tests - pass: 2,
* ltp-fs_perms_simple-tests - pass: 19,
* ltp-fsx-tests - pass: 2,
* ltp-hugetlb-tests - pass: 21, skip: 1,
* ltp-io-tests - pass: 3,
* ltp-ipc-tests - pass: 9,
* ltp-math-tests - pass: 11,
* ltp-nptl-tests - pass: 2,
* ltp-pty-tests - pass: 4,
* ltp-sched-tests - pass: 14,
* ltp-securebits-tests - pass: 4,
* ltp-syscalls-tests - pass: 1002, skip: 148,
* ltp-timers-tests - pass: 12, skip: 1,

hi6220-hikey - arm64
* boot - pass: 20,
* kselftest - pass: 48, skip: 17,
* libhugetlbfs - pass: 90, skip: 1,
* ltp-cap_bounds-tests - pass: 2,
* ltp-containers-tests - pass: 64, skip: 17,
* ltp-fcntl-locktests-tests - pass: 2,
* ltp-filecaps-tests - pass: 2,
* ltp-fs-tests - pass: 61, skip: 2,
* ltp-fs_bind-tests - pass: 2,
* ltp-fs_perms_simple-tests - pass: 19,
* ltp-fsx-tests - pass: 2,
* ltp-hugetlb-tests - pass: 21, skip: 1,
* ltp-io-tests - pass: 3,
* ltp-ipc-tests - pass: 9,
* ltp-math-tests - pass: 11,
* ltp-nptl-tests - pass: 2,
* ltp-pty-tests - pass: 4,
* ltp-sched-tests - pass: 10, skip: 4,
* ltp-securebits-tests - pass: 4,
* ltp-syscalls-tests - pass: 999, skip: 151,
* ltp-timers-tests - pass: 12, skip: 1,

juno-r2 - arm64
* boot - pass: 20,
* kselftest - pass: 48, skip: 17,
* libhugetlbfs - pass: 90, skip: 1,
* ltp-cap_bounds-tests - pass: 2,
* ltp-containers-tests - pass: 64, skip: 17,
* ltp-fcntl-locktests-tests - pass: 2,
* ltp-filecaps-tests - pass: 2,
* ltp-fs-tests - pass: 61, skip: 2,
* ltp-fs_bind-tests - pass: 2,
* ltp-fs_perms_simple-tests - pass: 19,
* ltp-fsx-tests - pass: 2,
* ltp-hugetlb-tests - pass: 22,
* ltp-io-tests - pass: 3,
* ltp-ipc-tests - pass: 9,
* ltp-math-tests - pass: 11,
* ltp-nptl-tests - pass: 2,
* ltp-pty-tests - pass: 4,
* ltp-sched-tests - pass: 10, skip: 4,
* ltp-securebits-tests - pass: 4,
* ltp-syscalls-tests - pass: 1001, skip: 149,
* ltp-timers-tests - pass: 12, skip: 1,

qemu_x86_64
* boot - pass: 20,
* kselftest - pass: 62, skip: 20,
* libhugetlbfs - pass: 90, skip: 1,
* ltp-cap_bounds-tests - pass: 2,
* ltp-containers-tests - pass: 64, skip: 17,
* ltp-fcntl-locktests-tests - pass: 2,
* ltp-filecaps-tests - pass: 2,
* ltp-fs-tests - pass: 57, skip: 6,
* ltp-fs_bind-tests - pass: 2,
* ltp-fs_perms_simple-tests - pass: 19,
* ltp-fsx-tests - pass: 2,
* ltp-hugetlb-tests - pass: 22,
* ltp-io-tests - pass: 3,
* ltp-ipc-tests - pass: 9,
* ltp-math-tests - pass: 11,
* ltp-nptl-tests - pass: 2,
* ltp-pty-tests - pass: 4,
* ltp-sched-tests - pass: 13, skip: 1,
* ltp-securebits-tests - pass: 4,
* ltp-syscalls-tests - pass: 1001, skip: 149,
* ltp-timers-tests - pass: 12, skip: 1,

x15 - arm
* boot - pass: 20,
* kselftest - pass: 41, skip: 19, fail: 2
* libhugetlbfs - pass: 87, skip: 1,
* ltp-cap_bounds-tests - pass: 2,
* ltp-containers-tests - pass: 62, skip: 17, fail: 2
* ltp-fcntl-locktests-tests - pass: 2,
* ltp-filecaps-tests - pass: 2,
* ltp-fs-tests - pass: 61, skip: 2,
* ltp-fs_bind-tests - pass: 2,
* ltp-fs_perms_simple-tests - pass: 19,
* ltp-fsx-tests - pass: 2,
* ltp-hugetlb-tests - pass: 20, skip: 2,
* ltp-io-tests - pass: 3,
* ltp-ipc-tests - pass: 9,
* ltp-math-tests - pass: 11,
* ltp-nptl-tests - pass: 2,
* ltp-pty-tests - pass: 4,
* ltp-sched-tests - pass: 13, skip: 1,
* ltp-securebits-tests - pass: 4,
* ltp-syscalls-tests - pass: 1053, skip: 97,
* ltp-timers-tests - pass: 12, skip: 1,

x86_64
* boot - pass: 20,
* kselftest - pass: 61, skip: 19,
* libhugetlbfs - pass: 90, skip: 1,
* ltp-cap_bounds-tests - pass: 2,
* ltp-containers-tests - pass: 64, skip: 17,
* ltp-fcntl-locktests-tests - pass: 2,
* ltp-filecaps-tests - pass: 2,
* ltp-fs-tests - pass: 62, skip: 1,
* ltp-fs_bind-tests - pass: 2,
* ltp-fs_perms_simple-tests - pass: 19,
* ltp-fsx-tests - pass: 2,
* ltp-hugetlb-tests - pass: 21,
* ltp-io-tests - pass: 3,
* ltp-ipc-tests - pass: 9,
* ltp-math-tests - pass: 11,
* ltp-nptl-tests - pass: 2,
* ltp-pty-tests - pass: 4,
* ltp-sched-tests - pass: 9, skip: 5,
* ltp-securebits-tests - pass: 4,
* ltp-syscalls-tests - pass: 1031, skip: 119,
* ltp-timers-tests - pass: 12, skip: 1,

--
Linaro QA (beta)
https://qa-reports.linaro.org
