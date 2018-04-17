Return-Path: <bot@kernelci.org>
ARC-Seal: i=1; a=rsa-sha256; t=1523998983; cv=none;
        d=google.com; s=arc-20160816;
        b=SyTE4uAazEJ8uoWv860CC5moYXxbSrKWy48jFQYUrJ09KKSJMOAv7lR9666jxIu6pU
         cs/c0Z3j2nuzONXTk/SRIYZnPrWrvikG9D/mq78VNVjdclzQrw0en9G2JlW9SpUCRLLM
         Cu2oksmlAx9SvaMjamy/OOeIzn7vjrqXk92G3WtmgaNczt5NzIxwQzCxPCJPS+38VIBR
         dTFuxdnTI/WKSbFeTSk9EmklTs+EaZpiEDkaxRW8ARF7vsuKa1kSUWQFp/nPqJP6UTsP
         ed1zfZLzgJlljJ7DX3kgQh7POAeXVJvJm7AWNJfL4oG4u4+X4Kh+TQZSej7ZZCbBL9Oq
         Nr0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:from:to:subject:references:in-reply-to:content-transfer-encoding
         :mime-version:date:message-id:arc-authentication-results;
        bh=cJn6sXBTXEXnVz6MKBtoIv2mkp3t/xkEbCX+QA35WDo=;
        b=I/fd/jB7SWN5PsoNTMf0GUkt07Y4YA95lS3urnT/oUsXr8/D/a0WnNbwOBAlGRO2Zl
         rr2+a5DgtQPRhbKO47xM8qH7d9BzUMYRm5ghwIjb8lGCDHk8TQl63fSXgKVTRL9xyy3F
         PB7kprm9oTHnDyTbc4/17nG1p9hLJyRXoo7Z12/cx+pySzGpm3uOQhNcCzyB/Ol9euKG
         BrT10mLjqNriyyNQSbKEKOA3Y/HyWWlrTS7Sk/dZo9b8NxvoqDyVHjIrGDYnVmaO/uwZ
         wYlRO5ANO8/PmFYk4Z8QNYFA+kIqJDTep406LElKe5mxxA3n5HWtDzIxXNX2uQXeHaEU
         9ngw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of bot@kernelci.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=bot@kernelci.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of bot@kernelci.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=bot@kernelci.org
X-Google-Smtp-Source: AIpwx49qgb8ms6J3s1SGikrZP02Es5GpW80Z0HXhawNJAxhqt3n3HL9DfD5mVmoiXZ7mGZTn9n12OA==
Message-ID: <5ad66106.8a1f1c0a.eba47.b41d@mx.google.com>
Date: Tue, 17 Apr 2018 14:03:02 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.15.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: boot
X-Kernelci-Kernel: v4.15.17-54-gae8929dc5a7d
In-Reply-To: <20180417155723.091120060@linuxfoundation.org>
References: <20180417155723.091120060@linuxfoundation.org>
Subject: Re: [PATCH 4.15 00/53] 4.15.18-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org
From: kernelci.org bot <bot@kernelci.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net,
 shuahkh@osg.samsung.com, patches@kernelci.org, ben.hutchings@codethink.co.uk,
 lkft-triage@lists.linaro.org, stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598009896263734013?=
X-GMAIL-MSGID: =?utf-8?q?1598028758157112558?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

stable-rc/linux-4.15.y boot: 69 boots: 2 failed, 65 passed with 2 untried/u=
nknown (v4.15.17-54-gae8929dc5a7d)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.15.y/kernel/v4.15.17-54-gae8929dc5a7d/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.15.=
y/kernel/v4.15.17-54-gae8929dc5a7d/

Tree: stable-rc
Branch: linux-4.15.y
Git Describe: v4.15.17-54-gae8929dc5a7d
Git Commit: ae8929dc5a7d09feab66e3131a04a1ed88d8d284
Git URL: http://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git
Tested: 36 unique boards, 12 SoC families, 13 builds out of 185

Boot Regressions Detected:

arm:

    at91_dt_defconfig:
        at91sam9m10g45ek:
            lab-free-electrons: new failure (last pass: v4.15.17)

    multi_v7_defconfig:
        sun8i-a83t-allwinner-h8homlet-v2:
            lab-free-electrons: new failure (last pass: v4.15.17)

Boot Failures Detected:

arm:

    at91_dt_defconfig
        at91sam9m10g45ek: 1 failed lab

    multi_v7_defconfig
        sun8i-a83t-allwinner-h8homlet-v2: 1 failed lab

---
For more info write to <info@kernelci.org>
