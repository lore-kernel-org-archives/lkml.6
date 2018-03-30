Return-Path: <naresh.kamboju@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1522424674; cv=none;
        d=google.com; s=arc-20160816;
        b=lyEQGyJ3XLPsUWi+FQcQcEPc9e3a4e/JTVYU+okOs5u51z8mpHQG3/n7aoPT7eP5Jz
         OeVgrcrITVnMQXh3PvdUXCRkKQ59clBSFMG6LlHTI7j1XS3LDI64H0tdTspJ1FLe27me
         V0OHRWPyyLbgFVwsk44QpSKiksHgne5WbnnzTFOnhQ08lTOZgSbNcXw0KyBGVfObO1r5
         yfLjcIcB8MKbaQPOf7nWPZT41JHAvgBkHJlCsu+pMuHDw90NnlvI0Et6YgZyzKNpMpkX
         eAAe7bMui/nMwEjwdGFK1N869qfiGni0FMYrf30v6u4nA1y29JtbxZgQFJKEnAQjbmCG
         /oHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :references:in-reply-to:mime-version:dkim-signature
         :arc-authentication-results;
        bh=vRQ2BTxk2XD3ItiAPPq67e/elm0KndhzkJ7c2GPcVvM=;
        b=OKZVFYDOziJVuQIRvQgzOFm2FgBN0k8coV3kElwQge2YmDkPkDIogQi6YTO4KhJjdg
         A1QpPCWyQbQuqEU9jraN+Sl0HKCpWZKIryYV4tUYzM5TCVral7cHGYanXNSBiHQ6u6BS
         THpIVKM8DMGV/3HoTnUKb0cqy2f+Udiv174TTpAugipFtJJAwfnLIqB6tWyZWWX3THJU
         XsyJLfcIJu5drcjgLuHgeQWlzXlVAi0aoc0YBavoJ8czMwTwHqClzHVya6y47+Ok191N
         CJar7/guDrwoNXLKlyY2UBgMrKSsy0dWja2vwviqjtG7PfuhJQSw7HNpFmyHuGB3P8On
         PZtQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=LjS4cVEg;
       spf=pass (google.com: domain of naresh.kamboju@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=naresh.kamboju@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=LjS4cVEg;
       spf=pass (google.com: domain of naresh.kamboju@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=naresh.kamboju@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AIpwx4+EaHQfFouClzU5zPAWrBHAtzofMSGzHH+UNg+HwjxN8cj5On7CyBoyRbzUdFGDrziQBR9wi+OAoRAmQHpi3d8=
MIME-Version: 1.0
In-Reply-To: <20180330085953.GB23620@kroah.com>
References: <20180329175741.886181131@linuxfoundation.org> <20180330085953.GB23620@kroah.com>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Fri, 30 Mar 2018 21:14:32 +0530
Message-ID: <CA+G9fYuO+jDmTi8fH+rTqe6EEM6zrVZt5eBXVTNWW+YAvu5nKQ@mail.gmail.com>
Subject: Re: [PATCH 4.4 00/20] 4.4.126-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: open list <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>,
	Guenter Roeck <linux@roeck-us.net>, Shuah Khan <shuahkh@osg.samsung.com>, patches@kernelci.org,
	Ben Hutchings <ben.hutchings@codethink.co.uk>, lkft-triage@lists.linaro.org,
	linux- stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596296410346468938?=
X-GMAIL-MSGID: =?utf-8?q?1596377974873172986?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 30 March 2018 at 14:29, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Thu, Mar 29, 2018 at 08:00:36PM +0200, Greg Kroah-Hartman wrote:
>> This is the start of the stable review cycle for the 4.4.126 release.
>> There are 20 patches in this series, all will be posted as a response
>> to this one.  If anyone has any issues with these being applied, please
>> let me know.
>>
>> Responses should be made by Sat Mar 31 17:57:30 UTC 2018.
>> Anything received after that time might be too late.
>>
>> The whole patch series can be found in one patch at:
>>       https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4=
.4.126-rc1.gz
>> or in the git tree and branch at:
>>       git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git linux-4.4.y
>> and the diffstat can be found below.
>
> There is a -rc2 out to fix a reported issue:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.4.126-rc2.gz
>

RC2 looks good to me :)

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm and x86_64.

Summary
------------------------------------------------------------------------

kernel: 4.4.126-rc2
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.4.y
git commit: cc5630ae66b26ccb8675849f0ce819db3cd2077f
git describe: v4.4.125-21-gcc5630ae66b2
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.4-oe/bui=
ld/v4.4.125-21-gcc5630ae66b2


No regressions (compared to build v4.4.125-21-g958176572b0c)

Boards, architectures and test suites:
-------------------------------------

juno-r2 - arm64
* boot - pass: 20
* kselftest - skip: 29, pass: 34
* libhugetlbfs - skip: 1, pass: 90
* ltp-cap_bounds-tests - pass: 2
* ltp-containers-tests - skip: 53, pass: 28
* ltp-fcntl-locktests-tests - pass: 2
* ltp-filecaps-tests - pass: 2
* ltp-fs-tests - skip: 2, pass: 61
* ltp-fs_bind-tests - pass: 2
* ltp-fs_perms_simple-tests - pass: 19
* ltp-fsx-tests - pass: 2
* ltp-hugetlb-tests - pass: 22
* ltp-io-tests - pass: 3
* ltp-ipc-tests - pass: 9
* ltp-math-tests - pass: 11
* ltp-nptl-tests - pass: 2
* ltp-pty-tests - pass: 4
* ltp-sched-tests - skip: 4, pass: 10
* ltp-securebits-tests - pass: 4
* ltp-syscalls-tests - skip: 152, pass: 998
* ltp-timers-tests - skip: 1, pass: 12

qemu_x86_64
* boot - pass: 22
* kselftest - skip: 33, pass: 47
* kselftest-vsyscall-mode-native - skip: 33, pass: 47
* kselftest-vsyscall-mode-none - skip: 33, pass: 47
* libhugetlbfs - skip: 1, pass: 90
* ltp-cap_bounds-tests - pass: 2
* ltp-containers-tests - skip: 17, pass: 64
* ltp-fcntl-locktests-tests - pass: 2
* ltp-filecaps-tests - pass: 2
* ltp-fs-tests - skip: 6, pass: 57
* ltp-fs_bind-tests - pass: 2
* ltp-fs_perms_simple-tests - pass: 19
* ltp-fsx-tests - pass: 2
* ltp-hugetlb-tests - pass: 22
* ltp-io-tests - pass: 3
* ltp-ipc-tests - pass: 9
* ltp-math-tests - pass: 11
* ltp-nptl-tests - pass: 2
* ltp-pty-tests - pass: 4
* ltp-sched-tests - skip: 1, pass: 13
* ltp-securebits-tests - pass: 4
* ltp-syscalls-tests - skip: 149, pass: 1001
* ltp-timers-tests - skip: 1, pass: 12

x15 - arm
* boot - pass: 20
* kselftest - skip: 29, pass: 33
* libhugetlbfs - skip: 1, pass: 87
* ltp-cap_bounds-tests - pass: 2
* ltp-containers-tests - skip: 17, pass: 64
* ltp-fcntl-locktests-tests - pass: 2
* ltp-filecaps-tests - pass: 2
* ltp-fs-tests - skip: 2, pass: 61
* ltp-fs_bind-tests - pass: 2
* ltp-fs_perms_simple-tests - pass: 19
* ltp-fsx-tests - pass: 2
* ltp-hugetlb-tests - skip: 2, pass: 20
* ltp-io-tests - pass: 3
* ltp-ipc-tests - pass: 9
* ltp-math-tests - pass: 11
* ltp-nptl-tests - pass: 2
* ltp-pty-tests - pass: 4
* ltp-sched-tests - skip: 1, pass: 13
* ltp-securebits-tests - pass: 4
* ltp-syscalls-tests - skip: 98, pass: 1052
* ltp-timers-tests - skip: 1, pass: 12

x86_64
* boot - pass: 22
* kselftest - skip: 31, fail: 1, pass: 48
* kselftest-vsyscall-mode-native - skip: 31, fail: 1, pass: 48
* kselftest-vsyscall-mode-none - skip: 31, fail: 2, pass: 46
* libhugetlbfs - skip: 1, pass: 90
* ltp-cap_bounds-tests - pass: 2
* ltp-containers-tests - skip: 17, pass: 64
* ltp-fcntl-locktests-tests - pass: 2
* ltp-filecaps-tests - pass: 2
* ltp-fs-tests - skip: 1, pass: 62
* ltp-fs_bind-tests - pass: 2
* ltp-fs_perms_simple-tests - pass: 19
* ltp-fsx-tests - pass: 2
* ltp-hugetlb-tests - pass: 22
* ltp-io-tests - pass: 3
* ltp-ipc-tests - pass: 9
* ltp-math-tests - pass: 11
* ltp-nptl-tests - pass: 2
* ltp-pty-tests - pass: 4
* ltp-sched-tests - skip: 5, pass: 9
* ltp-securebits-tests - pass: 4
* ltp-syscalls-tests - skip: 120, pass: 1030
* ltp-timers-tests - skip: 1, pass: 12

--
Linaro QA (beta)
https://qa-reports.linaro.org
