Return-Path: <dan.rue@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1521448185; cv=none;
        d=google.com; s=arc-20160816;
        b=PzMHbJJoWDgsI8CMCJ5ZryoKrkDYIvbvjMZyy/rGLEJrMd1hh8Y/Cc08IcfOlY1ID1
         oOKXmvZqrrm+RZqU7aCm7+CzByXagfkKf9+tqHfXb8YA5pN5YFgLHw8f2AS64Ko+ClR4
         lnWJb+lyc9xJxS61KbBrdSsqVuBhs4XQGwiZg1vrLHPqT9mtzKQJYe5QZjbUfMj/UZO5
         2D2VnE12dRErRttB4vzRi5gvhWl31KsY3IviwkOWsBty8ofW56miY/Ie7Su9kEsrbKQ1
         3Qu2NDSebk2JXHaTBVmxL4rY00KyOdoggHsgqM5nSXqkW/N3BPkCKXkaQyTfTBgLAA8S
         ti7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=lJtkpuq4EwsN9prk2fdo/Qeg/TsIzjKYTg1270JOYCw=;
        b=B5CDzKTEOXXNlMl155NrhH4BcUD5RBWbzCGRj8ecxj8A1bZn5etc78jmbWfuke/yeF
         IICX/zWUuDAM1uDLLzYhHfC0yyouMpcGMnxEwDTqPzrBD36kWAVFfG7Luz9jyZTjWw2n
         oOzB9EVaAxd8sDt7VxHoAV0RiyZu4EJRPH+8F5l5v8yYzjkWhRh09jBOIzEyLCRgzAMz
         BGnXWuWBNb7FncBOgwanlwccyfb68tT5Sfqb4CeOvUFeiGQHIGtoENXR1ytB1S+UrA9t
         vlYdADnuJwocW/CxLEEwCgmQ/cjOGjLyI4xHKKvgxw622Xvu3NF75I1ltwFhdENhgqJr
         YEwQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=M3NCFGsF;
       spf=pass (google.com: domain of dan.rue@linaro.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=dan.rue@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=M3NCFGsF;
       spf=pass (google.com: domain of dan.rue@linaro.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=dan.rue@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AG47ELtW/Tk39jXx8hPzvS+nv0wVWPpC37WcxDnLS7pjoBp22BKazzsi0dZ3655+OiSW+EiGo6MrDg==
Date: Mon, 19 Mar 2018 16:29:42 +0800
From: Dan Rue <dan.rue@linaro.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net,
	shuahkh@osg.samsung.com, patches@kernelci.org,
	ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 4.15 000/128] 4.15.11-stable review
Message-ID: <20180319082942.xye3p4bwd7ddeb2a@xps>
Mail-Followup-To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net,
	shuahkh@osg.samsung.com, patches@kernelci.org,
	ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
	stable@vger.kernel.org
References: <20180316152336.199007505@linuxfoundation.org>
 <20180318102526.GC30164@kroah.com>
 <20180318111523.GB4607@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180318111523.GB4607@kroah.com>
User-Agent: NeoMutt/20180223
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595109395590505536?=
X-GMAIL-MSGID: =?utf-8?q?1595354052757163614?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sun, Mar 18, 2018 at 12:15:23PM +0100, Greg Kroah-Hartman wrote:
> On Sun, Mar 18, 2018 at 11:25:26AM +0100, Greg Kroah-Hartman wrote:
> > On Fri, Mar 16, 2018 at 04:22:21PM +0100, Greg Kroah-Hartman wrote:
> > > This is the start of the stable review cycle for the 4.15.11 release.
> > > There are 128 patches in this series, all will be posted as a response
> > > to this one.  If anyone has any issues with these being applied, please
> > > let me know.
> > > 
> > > Responses should be made by Sun Mar 18 15:22:57 UTC 2018.
> > > Anything received after that time might be too late.
> > > 
> > > The whole patch series can be found in one patch at:
> > > 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.15.11-rc1.gz
> > 
> > -rc2 is out to fix a build error on some configs:
> >  	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.15.11-rc2.gz
> 
> And -rc3 is out that at least builds properly:
>   	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.15.11-rc3.gz

As reported, arm32 build failed and so tests did not run. No regressions on
arm64 or x86_64.

The 'regressions' listed below are related to running under qemu. They work
fine on real hardware.

Summary
------------------------------------------------------------------------

kernel: 4.15.11-rc3
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
git branch: linux-4.15.y
git commit: 19c3db0eb031575ed19b50a75282cea8c9df9b0b
git describe: v4.15.10-127-g19c3db0eb031
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.15-oe/build/v4.15.10-127-g19c3db0eb031

Regressions (compared to build v4.15.10-129-gadfb64c5bcd2)
------------------------------------------------------------------------

qemu_x86_64:
  kselftest-vsyscall-mode-native:
    * sigreturn_64

    * test src: not informed
  ltp-sched-tests:
    * runltp_sched

    * test src: git://github.com/linux-test-project/ltp.git


Boards, architectures and test suites:
-------------------------------------

dragonboard-410c
* boot - fail: 3, pass: 20
* kselftest - skip: 20, pass: 45
* libhugetlbfs - skip: 1, pass: 90
* ltp-cap_bounds-tests - pass: 2
* ltp-containers-tests - skip: 17, pass: 64
* ltp-fcntl-locktests-tests - pass: 2
* ltp-filecaps-tests - pass: 2
* ltp-fs-tests - skip: 2, pass: 61
* ltp-fs_bind-tests - pass: 2
* ltp-fs_perms_simple-tests - pass: 19
* ltp-fsx-tests - pass: 2
* ltp-hugetlb-tests - skip: 1, pass: 21
* ltp-io-tests - pass: 3
* ltp-ipc-tests - pass: 9
* ltp-math-tests - pass: 11
* ltp-nptl-tests - pass: 2
* ltp-pty-tests - pass: 4
* ltp-sched-tests - pass: 14
* ltp-securebits-tests - pass: 4
* ltp-syscalls-tests - skip: 148, pass: 1002
* ltp-timers-tests - skip: 1, pass: 12

hi6220-hikey - arm64
* boot - pass: 20
* kselftest - skip: 17, pass: 48
* libhugetlbfs - skip: 1, pass: 90
* ltp-cap_bounds-tests - pass: 2
* ltp-containers-tests - skip: 17, pass: 64
* ltp-fcntl-locktests-tests - pass: 2
* ltp-filecaps-tests - pass: 2
* ltp-fs-tests - skip: 2, pass: 61
* ltp-fs_bind-tests - pass: 2
* ltp-fs_perms_simple-tests - pass: 19
* ltp-fsx-tests - pass: 2
* ltp-hugetlb-tests - skip: 1, pass: 21
* ltp-io-tests - pass: 3
* ltp-ipc-tests - pass: 9
* ltp-math-tests - pass: 11
* ltp-nptl-tests - pass: 2
* ltp-pty-tests - pass: 4
* ltp-sched-tests - skip: 4, pass: 10
* ltp-securebits-tests - pass: 4
* ltp-syscalls-tests - skip: 151, pass: 999
* ltp-timers-tests - skip: 1, pass: 12

juno-r2 - arm64
* boot - pass: 20
* kselftest - skip: 17, pass: 48
* libhugetlbfs - skip: 1, pass: 90
* ltp-cap_bounds-tests - pass: 2
* ltp-containers-tests - skip: 17, pass: 64
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
* ltp-syscalls-tests - skip: 149, pass: 1001
* ltp-timers-tests - skip: 1, pass: 12

qemu_x86_64
* boot - pass: 23
* kselftest - skip: 21, pass: 61
* kselftest-vsyscall-mode-native - skip: 21, fail: 1, pass: 60
* kselftest-vsyscall-mode-none - skip: 21, pass: 61
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
* ltp-sched-tests - skip: 1, fail: 1, pass: 21
* ltp-securebits-tests - pass: 4
* ltp-syscalls-tests - skip: 148, pass: 1002
* ltp-timers-tests - skip: 1, pass: 12

x86_64
* boot - pass: 22
* kselftest - skip: 19, pass: 61
* kselftest-vsyscall-mode-native - skip: 19, pass: 61
* kselftest-vsyscall-mode-none - skip: 19, fail: 1, pass: 60
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
* ltp-syscalls-tests - skip: 119, pass: 1031
* ltp-timers-tests - skip: 1, pass: 12

--
Linaro QA (beta)
https://qa-reports.linaro.org
_______________________________________________
Kernel-build-reports mailing list
Kernel-build-reports@lists.linaro.org
https://lists.linaro.org/mailman/listinfo/kernel-build-reports
