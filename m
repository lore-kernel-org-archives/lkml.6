Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751696AbeFEGOt (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 02:14:49 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:38535 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751606AbeFEGOr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 02:14:47 -0400
X-Google-Smtp-Source: ADUXVKJ7Yxgjs5DNji4aWHVzDe6xx03SarM33LVvMcJ0LgYcohXpr8UpNUlZTC9Rkw9iF+e58+cQHGqQDxNmiQQEgdY=
MIME-Version: 1.0
In-Reply-To: <20180604065802.157744637@linuxfoundation.org>
References: <20180604065802.157744637@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 5 Jun 2018 11:44:45 +0530
Message-ID: <CA+G9fYsjd00toa+mmF9vsKnxtZ9fz5Rk0SHh=DZ0=otTyONjxA@mail.gmail.com>
Subject: Re: [PATCH 4.9 00/29] 4.9.106-stable review
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
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w556Esg1016886

On 4 June 2018 at 12:27, Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> This is the start of the stable review cycle for the 4.9.106 release.
> There are 29 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed Jun  6 06:57:52 UTC 2018.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.106-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.9.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro’s test farm.
No regressions on arm64, arm and x86_64.

NOTE: LTP fs "read_all_sys" broken on hikey and this is always reproducible.
But test PASS on qemu_arm64.
"read_all_sys" is not a real failure consider this as waiver and will
investigate.

Test log:
------------
read_all -d /sys -q -r 10
incrementing stop
tst_test.c:1015: INFO: Timeout per run is 0h 15m 00s
read_all.c:317: BROK: queue_push(workers[j].q, path) timed out

Summary
------------------------------------------------------------------------

kernel: 4.9.106-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
git branch: linux-4.9.y
git commit: b0a024051e17ad3bdd5f6b1e52f5c67fb6087cb9
git describe: v4.9.105-31-gb0a024051e17
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.9-oe/build/v4.9.105-31-gb0a024051e17

No regressions (compared to build v4.9.105)

<Full report not generated due to infrastructure issues>
<end of report>
