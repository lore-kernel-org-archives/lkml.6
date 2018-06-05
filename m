Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751544AbeFEGUG (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 02:20:06 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:34195 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751023AbeFEGUD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 02:20:03 -0400
X-Google-Smtp-Source: ADUXVKJcRNufhL50Lag79JR5Zxhu8cY9/5g5D8NcYJjaiiWCifqSWem7qhHyqfx+pWNRLti1IbpAwa9iN1tvGW5TwT0=
MIME-Version: 1.0
In-Reply-To: <20180604065606.532044490@linuxfoundation.org>
References: <20180604065606.532044490@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 5 Jun 2018 11:50:01 +0530
Message-ID: <CA+G9fYvnzMT7c-uPej9GDnJhJ=Ak5ZxSmYH7xZqRL_4vs-uJ9g@mail.gmail.com>
Subject: Re: [PATCH 4.14 00/52] 4.14.48-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: open list <linux-kernel@vger.kernel.org>,
        Shuah Khan <shuah@kernel.org>, patches@kernelci.org,
        lkft-triage@lists.linaro.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        linux- stable <stable@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w556KBtL016982

On 4 June 2018 at 12:27, Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> This is the start of the stable review cycle for the 4.14.48 release.
> There are 52 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed Jun  6 06:55:52 UTC 2018.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.48-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.14.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro’s test farm.
No regressions on arm64, arm and x86_64.

NOTE: Short summary report generator will resume soon.
This time we are using old and long report.

Summary
------------------------------------------------------------------------

kernel: 4.14.48-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
git branch: linux-4.14.y
git commit: 721adf61fde28b9a87a95e45ecf3f5a325e7c76f
git describe: v4.14.47-53-g721adf61fde2
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.14-oe/build/v4.14.47-53-g721adf61fde2


No regressions (compared to build v4.14.47)


Boards, architectures and test suites:
-------------------------------------

hi6220-hikey - arm64
* boot - pass: 21,
* kselftest - skip: 23, pass: 43, fail: 1
* libhugetlbfs - skip: 1, pass: 90,
* ltp-cap_bounds-tests - pass: 2,
* ltp-containers-tests - skip: 17, pass: 64,
* ltp-cve-tests - skip: 8, pass: 25, fail: 2
* ltp-fcntl-locktests-tests - pass: 2,
* ltp-filecaps-tests - pass: 2,
* ltp-fs-tests - skip: 6, pass: 60,
* ltp-fs_bind-tests - pass: 2,
* ltp-fs_perms_simple-tests - pass: 19,
* ltp-fsx-tests - pass: 2,
* ltp-hugetlb-tests - skip: 1, pass: 21,
* ltp-io-tests - pass: 3,
* ltp-ipc-tests - pass: 9,
* ltp-math-tests - pass: 11,
* ltp-nptl-tests - pass: 2,
* ltp-pty-tests - pass: 4,
* ltp-sched-tests - skip: 4, pass: 10,
* ltp-securebits-tests - pass: 4,
* ltp-syscalls-tests - skip: 133, pass: 1013, fail: 3
* ltp-timers-tests - pass: 13,

juno-r2 - arm64
* boot - pass: 9,
* kselftest - skip: 25, pass: 42, fail: 1
* libhugetlbfs - skip: 1, pass: 90,
* ltp-cap_bounds-tests - pass: 2,
* ltp-containers-tests - skip: 17, pass: 64,
* ltp-cve-tests - skip: 8, pass: 24, fail: 3
* ltp-fcntl-locktests-tests - pass: 2,
* ltp-filecaps-tests - pass: 2,
* ltp-fs_bind-tests - pass: 2,
* ltp-fs_perms_simple-tests - pass: 19,

qemu_arm
* boot - pass: 21,
* kselftest - skip: 29, pass: 36, fail: 3
* libhugetlbfs - skip: 1, pass: 87,
* ltp-cap_bounds-tests - pass: 2,
* ltp-containers-tests - skip: 18, pass: 63,
* ltp-cve-tests - skip: 8, pass: 22, fail: 5
* ltp-fcntl-locktests-tests - pass: 2,
* ltp-filecaps-tests - pass: 2,
* ltp-fs-tests - skip: 5, pass: 61,
* ltp-fs_bind-tests - pass: 2,
* ltp-fs_perms_simple-tests - pass: 19,
* ltp-fsx-tests - pass: 2,
* ltp-hugetlb-tests - skip: 1, pass: 21,
* ltp-io-tests - pass: 3,
* ltp-ipc-tests - pass: 9,
* ltp-math-tests - pass: 11,
* ltp-nptl-tests - pass: 2,
* ltp-pty-tests - pass: 4,
* ltp-sched-tests - skip: 7, pass: 7,
* ltp-securebits-tests - pass: 4,
* ltp-syscalls-tests - skip: 93, pass: 1053, fail: 3
* ltp-timers-tests - pass: 13,

qemu_arm64
* boot - pass: 21,
* kselftest - skip: 29, pass: 40, fail: 1
* libhugetlbfs - skip: 1, pass: 90,
* ltp-cap_bounds-tests - pass: 2,
* ltp-containers-tests - skip: 17, pass: 64,
* ltp-cve-tests - skip: 8, pass: 23, fail: 4
* ltp-fcntl-locktests-tests - pass: 2,
* ltp-filecaps-tests - pass: 2,
* ltp-fs-tests - skip: 6, pass: 60,
* ltp-fs_bind-tests - pass: 2,
* ltp-fs_perms_simple-tests - pass: 19,
* ltp-fsx-tests - pass: 2,
* ltp-hugetlb-tests - pass: 22,
* ltp-io-tests - pass: 3,
* ltp-ipc-tests - pass: 9,
* ltp-math-tests - pass: 11,
* ltp-nptl-tests - pass: 2,
* ltp-pty-tests - pass: 4,
* ltp-sched-tests - skip: 6, pass: 8,
* ltp-securebits-tests - pass: 4,
* ltp-syscalls-tests - skip: 154, pass: 991, fail: 4
* ltp-timers-tests - pass: 13,

qemu_x86_64
* boot - pass: 21,
* kselftest - skip: 29, pass: 52, fail: 1
* libhugetlbfs - skip: 1, pass: 90,
* ltp-cap_bounds-tests - pass: 2,
* ltp-containers-tests - skip: 17, pass: 64,
* ltp-cve-tests - skip: 3, pass: 29, fail: 3
* ltp-fcntl-locktests-tests - pass: 2,
* ltp-filecaps-tests - pass: 2,
* ltp-fs-tests - skip: 6, pass: 60,
* ltp-fs_bind-tests - pass: 2,
* ltp-fs_perms_simple-tests - pass: 19,
* ltp-fsx-tests - pass: 2,
* ltp-hugetlb-tests - pass: 22,
* ltp-io-tests - pass: 3,
* ltp-ipc-tests - pass: 9,
* ltp-math-tests - pass: 11,
* ltp-nptl-tests - pass: 2,
* ltp-pty-tests - pass: 4,
* ltp-sched-tests - skip: 1, pass: 13,
* ltp-securebits-tests - pass: 4,
* ltp-syscalls-tests - skip: 153, pass: 994, fail: 2
* ltp-timers-tests - pass: 13,

x15 - arm
* boot - pass: 19,
* kselftest - skip: 26, pass: 38, fail: 3
* libhugetlbfs - skip: 1, pass: 87,
* ltp-cap_bounds-tests - pass: 2,
* ltp-containers-tests - skip: 18, pass: 63,
* ltp-cve-tests - skip: 8, pass: 24, fail: 3
* ltp-fcntl-locktests-tests - pass: 2,
* ltp-fs-tests - skip: 5, pass: 61,
* ltp-fs_perms_simple-tests - pass: 19,
* ltp-fsx-tests - pass: 2,
* ltp-hugetlb-tests - skip: 2, pass: 20,
* ltp-io-tests - pass: 3,
* ltp-ipc-tests - pass: 9,
* ltp-math-tests - pass: 11,
* ltp-nptl-tests - pass: 2,
* ltp-pty-tests - pass: 4,
* ltp-sched-tests - skip: 1, pass: 13,
* ltp-securebits-tests - pass: 4,
* ltp-syscalls-tests - skip: 76, pass: 1073,
* ltp-timers-tests - pass: 13,

x86_64
* boot - pass: 23,
* kselftest - skip: 24, pass: 54, fail: 1
* kselftest-vsyscall-mode-native - skip: 24, pass: 52, fail: 2
* kselftest-vsyscall-mode-none - skip: 21, pass: 55, fail: 1
* libhugetlbfs - skip: 1, pass: 90,
* ltp-cap_bounds-tests - pass: 2,
* ltp-containers-tests - skip: 17, pass: 64,
* ltp-cve-tests - skip: 3, pass: 29, fail: 3
* ltp-fcntl-locktests-tests - pass: 2,
* ltp-filecaps-tests - pass: 2,
* ltp-fs-tests - skip: 5, pass: 61,
* ltp-fs_bind-tests - pass: 2,
* ltp-fs_perms_simple-tests - pass: 19,
* ltp-fsx-tests - pass: 2,
* ltp-hugetlb-tests - pass: 22,
* ltp-io-tests - pass: 3,
* ltp-ipc-tests - pass: 9,
* ltp-math-tests - pass: 11,
* ltp-nptl-tests - pass: 2,
* ltp-pty-tests - pass: 4,
* ltp-sched-tests - skip: 5, pass: 9,
* ltp-securebits-tests - pass: 4,
* ltp-syscalls-tests - skip: 116, pass: 1031, fail: 2
* ltp-timers-tests - pass: 13,

-- 
Linaro QA (BETA)
https://qa-reports.linaro.org
