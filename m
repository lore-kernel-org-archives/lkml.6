Return-Path: <dan.rue@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1525184683; cv=none;
        d=google.com; s=arc-20160816;
        b=jTCUjH8oViFxFHPBh/yGYnliMl8qbuAc6Is6wZie+CLQCRBRCXw7XoorX0lvHeF07g
         oq4uEH2FxqgQNwmKF/viyjXl6D+/zWeFj5tJvNGCp1f5nPBdlsl8Rz10jRvjLsIhSWaO
         zOu8Ys3LizuAXA1mBK9zhcX66rZsnP+fPWRG0L732F6G6vlMRdUXQDbzMd9C1WxJuGSw
         DKha15RITuKnPkS6Et+IAmHBXCKjdm8U8LJDBY/imh6KxOo1AQuFPYztX3k81GKVDj+U
         GTJjA0gFYv3z87kXqp2cABFKmKlNrgzPJa5H0ULJIZXtBRLdbFGH9r7qpzdTDbZFNMRo
         l9OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:mail-followup-to
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=JT0RozCtcfYzNFTu9nPJJHu54kbx185n6+0dsVwLu+8=;
        b=aumTjc/NZix+8iu/g9Cug/Bc6LMOjpyQCq83c0ynx8y8L4UJQc2CNWOrGMOeLYSJlX
         rA1FkNzxceAgKyvGnsYpvWen9mQ1YnWGeVvAtYzP9DxKt4wa7VVPgZaqq3/dBnK13D/k
         YVBCrl+SL/DL2HQwmb3rfP26oJo8QoSAZ2KuXZEwng2H6uVQ7c28ge37dxvYRCzrIauE
         xPT2s5xlmA+1153nQ04oEaunjTOiYnnoMEapUltt5Ei3AYNaabnzACpgPct+VSrLEchB
         I9EIBIcaNDw4NsnI1VYpiqhwuod8AKgqomeFpnqXhV1YVC2+0K3VIFyy13+vpRGl4rst
         pGHA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=T5+OPoWU;
       spf=pass (google.com: domain of dan.rue@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=dan.rue@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=T5+OPoWU;
       spf=pass (google.com: domain of dan.rue@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=dan.rue@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AB8JxZqOX1843HVx1Wkpx2oSe77jLvwpLlO3Glx4O2+cZrUGIbi1qeI0Q6FKoODcLWSxYZ9XOBUO9A==
Date: Tue, 1 May 2018 09:24:41 -0500
From: Dan Rue <dan.rue@linaro.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org, ben.hutchings@codethink.co.uk,
	stable@vger.kernel.org, akpm@linux-foundation.org,
	torvalds@linux-foundation.org, linux@roeck-us.net
Subject: Re: [PATCH 4.9 00/61] 4.9.98-stable review
Message-ID: <20180501142441.me4hbdbve4v53ue4@xps>
Mail-Followup-To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org,
	ben.hutchings@codethink.co.uk, stable@vger.kernel.org,
	akpm@linux-foundation.org, torvalds@linux-foundation.org,
	linux@roeck-us.net
References: <20180430183951.312721450@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180430183951.312721450@linuxfoundation.org>
User-Agent: NeoMutt/20180323
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599200428921963582?=
X-GMAIL-MSGID: =?utf-8?q?1599272054299730430?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Apr 30, 2018 at 12:24:03PM -0700, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.98 release.
> There are 61 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed May  2 18:39:31 UTC 2018.
> Anything received after that time might be too late.

Results from Linaro’s test farm.
No regressions on arm64, arm and x86_64.

Summary
------------------------------------------------------------------------

kernel: 4.9.98-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
git branch: linux-4.9.y
git commit: dfbcc7b09b85cb3ef0a6253f94c245e6ddbf3a80
git describe: v4.9.97-62-gdfbcc7b09b85
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.9-oe/build/v4.9.97-62-gdfbcc7b09b85


No regressions (compared to build v4.9.97)

Boards, architectures and test suites:
-------------------------------------

dragonboard-410c
* boot - pass: 20,
* kselftest - skip: 32, pass: 34,
* libhugetlbfs - skip: 1, pass: 90,
* ltp-cap_bounds-tests - pass: 2,
* ltp-containers-tests - skip: 17, pass: 64,
* ltp-fcntl-locktests-tests - pass: 2,
* ltp-filecaps-tests - pass: 2,
* ltp-fs-tests - skip: 6, pass: 57,
* ltp-fs_bind-tests - pass: 2,
* ltp-fs_perms_simple-tests - pass: 19,
* ltp-fsx-tests - pass: 2,
* ltp-hugetlb-tests - skip: 1, pass: 21,
* ltp-io-tests - pass: 3,
* ltp-ipc-tests - pass: 9,
* ltp-math-tests - pass: 11,
* ltp-nptl-tests - pass: 2,
* ltp-pty-tests - pass: 4,
* ltp-sched-tests - pass: 14,
* ltp-securebits-tests - pass: 4,
* ltp-syscalls-tests - skip: 135, pass: 1015,
* ltp-timers-tests - pass: 13,

hi6220-hikey - arm64
* boot - pass: 20,
* kselftest - skip: 29, pass: 37,
* libhugetlbfs - skip: 1, pass: 90,
* ltp-cap_bounds-tests - pass: 2,
* ltp-containers-tests - skip: 17, pass: 64,
* ltp-fcntl-locktests-tests - pass: 2,
* ltp-filecaps-tests - pass: 2,
* ltp-fs-tests - skip: 6, pass: 57,
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
* ltp-syscalls-tests - skip: 136, pass: 1014,
* ltp-timers-tests - pass: 13,

juno-r2 - arm64
* boot - pass: 20,
* kselftest - skip: 29, pass: 37,
* libhugetlbfs - skip: 1, pass: 90,
* ltp-cap_bounds-tests - pass: 2,
* ltp-containers-tests - skip: 17, pass: 64,
* ltp-fcntl-locktests-tests - pass: 2,
* ltp-filecaps-tests - pass: 2,
* ltp-fs-tests - skip: 6, pass: 57,
* ltp-fs_bind-tests - pass: 2,
* ltp-fs_perms_simple-tests - pass: 19,
* ltp-fsx-tests - pass: 2,
* ltp-hugetlb-tests - pass: 22,
* ltp-io-tests - pass: 3,
* ltp-ipc-tests - pass: 9,
* ltp-math-tests - pass: 11,
* ltp-nptl-tests - pass: 2,
* ltp-pty-tests - pass: 4,
* ltp-sched-tests - skip: 4, pass: 10,
* ltp-securebits-tests - pass: 4,
* ltp-syscalls-tests - skip: 135, pass: 1015,
* ltp-timers-tests - pass: 13,

qemu_arm
* boot - pass: 7, fail: 13
* kselftest - skip: 32, pass: 34,
* libhugetlbfs - pass: 1,
* ltp-cap_bounds-tests - pass: 2,
* ltp-fsx-tests - pass: 2,
* ltp-ipc-tests - pass: 9,
* ltp-pty-tests - pass: 4,
* ltp-timers-tests - pass: 13,

qemu_arm64
* boot - pass: 20,
* kselftest - skip: 33, pass: 35,
* libhugetlbfs - skip: 1, pass: 90,
* ltp-cap_bounds-tests - pass: 2,
* ltp-containers-tests - skip: 17, pass: 64,
* ltp-fcntl-locktests-tests - pass: 2,
* ltp-filecaps-tests - pass: 2,
* ltp-fs-tests - skip: 6, pass: 57,
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
* ltp-syscalls-tests - skip: 157, pass: 991, fail: 2
* ltp-timers-tests - pass: 13,

qemu_x86_64
* boot - pass: 22,
* kselftest - skip: 33, pass: 47,
* kselftest-vsyscall-mode-native - skip: 33, pass: 47,
* kselftest-vsyscall-mode-none - skip: 33, pass: 47,
* libhugetlbfs - skip: 1, pass: 90,
* ltp-cap_bounds-tests - pass: 2,
* ltp-containers-tests - skip: 17, pass: 64,
* ltp-fcntl-locktests-tests - pass: 2,
* ltp-filecaps-tests - pass: 2,
* ltp-fs-tests - skip: 6, pass: 57,
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
* ltp-syscalls-tests - skip: 152, pass: 998,
* ltp-timers-tests - pass: 13,

x15 - arm
* boot - pass: 20,
* kselftest - skip: 29, pass: 36,
* libhugetlbfs - skip: 1, pass: 87,
* ltp-cap_bounds-tests - pass: 2,
* ltp-containers-tests - skip: 18, pass: 63,
* ltp-fcntl-locktests-tests - pass: 2,
* ltp-filecaps-tests - pass: 2,
* ltp-fs-tests - skip: 5, pass: 58,
* ltp-fs_bind-tests - pass: 2,
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
* ltp-syscalls-tests - skip: 75, pass: 1075,
* ltp-timers-tests - pass: 13,

x86_64
* boot - pass: 19,
* kselftest - skip: 30, pass: 50,
* kselftest-vsyscall-mode-native - skip: 30, pass: 49, fail: 1
* kselftest-vsyscall-mode-none - skip: 30, pass: 50,
* libhugetlbfs - skip: 1, pass: 90,
* ltp-cap_bounds-tests - pass: 2,
* ltp-containers-tests - skip: 17, pass: 64,
* ltp-fcntl-locktests-tests - pass: 2,
* ltp-fs-tests - skip: 5, pass: 58,
* ltp-fsx-tests - pass: 2,
* ltp-hugetlb-tests - pass: 22,
* ltp-io-tests - pass: 3,
* ltp-ipc-tests - pass: 9,
* ltp-math-tests - pass: 11,
* ltp-nptl-tests - pass: 2,
* ltp-pty-tests - pass: 4,
* ltp-sched-tests - skip: 5, pass: 9,
* ltp-securebits-tests - pass: 4,
* ltp-syscalls-tests - skip: 116, pass: 1034,
* ltp-timers-tests - pass: 13,

-- 
Linaro QA (BETA)
https://qa-reports.linaro.org
