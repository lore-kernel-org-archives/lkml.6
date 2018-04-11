Return-Path: <bot@kernelci.org>
ARC-Seal: i=1; a=rsa-sha256; t=1523486549; cv=none;
        d=google.com; s=arc-20160816;
        b=xs1JUqgW6/BYaSa1UF+CySJPhp9OUw1Mh2Hc8S7FFW9nhmjlNKlUDQkY6/CQQiZ3Rv
         AVNDEYzxNpMF/gMMn3HDGzSb4cxTdEvw8rRKE/a0XHfrSOp+9akIyh21//55Cf7gFG93
         rGuUUHSqlOasTdEpKDanlR2hBRtsDWEh+sFvBDnQo7z4aa9Yb1ZblTEdtyndSJpwBNBC
         qRtF3Lgexn99MiX94U/VuKXfc2znaKrLPy2E6CvgQmL/Pp+HyKmYIKk2frU7ycDydJOg
         gPOP6PROtIReJzKv8arKsOOgQiG/wVEo6q/iuqpKeFSE/UwA1at41Ckxw5mGu5JVJ3NV
         ZhrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:from:to:subject:references:in-reply-to:content-transfer-encoding
         :mime-version:date:message-id:arc-authentication-results;
        bh=6FkSzhOVaeFve+OVmv2OU4VRSWePEr92gx88gGnVcIk=;
        b=nZ7xGYgHNs/mXeZIZlRmrm0G1o+3Xiy/ugBqugJouS0rkqytAtGUXmw7pNAKREjXsC
         UUwUFlJgV0SyMBp1YD0biSVev8YKGlONh/M8adrxflOgxqz52ftq46fTY3iNsCGmMt3B
         +hrcMVjKnnvez7WnMwnI/uB2nWEQEQUAjOFJ8Vkvw8mc5XceAOBorqVf/2sCDctQ6Q/a
         9eMotyWQujm+/OtLXP9fD2sOugJeG8+2zYBz5yOlqTG+4eeu0elNCgXv6vPdQeLu+6bf
         NM7a42rBvK2DQSTXKuekQYA7WPuAj2CAHttFZw15bk/NXpZeEFw0y/jUCA5ZKrsjxWnL
         Xz+w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of bot@kernelci.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=bot@kernelci.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of bot@kernelci.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=bot@kernelci.org
X-Google-Smtp-Source: AIpwx4+6HsDO58c/b9+t3m6eB8/lH2ZhERiNaxWr7ZfWhcuc/00gjE6xdZUYMdpuW71pB1KatRpgXQ==
Message-ID: <5ace8f54.14721c0a.b43fd.c02e@mx.google.com>
Date: Wed, 11 Apr 2018 15:42:28 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.9.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: boot
X-Kernelci-Kernel: v4.9.93-310-g55a22280f3f9
In-Reply-To: <20180411183622.305902791@linuxfoundation.org>
References: <20180411183622.305902791@linuxfoundation.org>
Subject: Re: [PATCH 4.9 000/310] 4.9.94-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org
From: kernelci.org bot <bot@kernelci.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net,
 shuahkh@osg.samsung.com, patches@kernelci.org, ben.hutchings@codethink.co.uk,
 lkft-triage@lists.linaro.org, stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597477060823737120?=
X-GMAIL-MSGID: =?utf-8?q?1597491432253224936?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

stable-rc/linux-4.9.y boot: 80 boots: 5 failed, 70 passed with 5 untried/un=
known (v4.9.93-310-g55a22280f3f9)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.9.y/kernel/v4.9.93-310-g55a22280f3f9/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.9.y=
/kernel/v4.9.93-310-g55a22280f3f9/

Tree: stable-rc
Branch: linux-4.9.y
Git Describe: v4.9.93-310-g55a22280f3f9
Git Commit: 55a22280f3f9ade4c3a6bce638db0dc129a9da7c
Git URL: http://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git
Tested: 39 unique boards, 15 SoC families, 17 builds out of 183

Boot Regressions Detected:

arm:

    multi_v7_defconfig:
        at91-sama5d3_xplained:
            lab-free-electrons: failing since 1 day (last pass: v4.9.93 - f=
irst fail: v4.9.93-276-gebae58704fed)
        sun8i-a33-sinlinx-sina33:
            lab-free-electrons: new failure (last pass: v4.9.93-276-gebae58=
704fed)

    sama5_defconfig:
        at91-sama5d3_xplained:
            lab-free-electrons: failing since 1 day (last pass: v4.9.93 - f=
irst fail: v4.9.93-276-gebae58704fed)

    sunxi_defconfig:
        sun8i-a83t-allwinner-h8homlet-v2:
            lab-free-electrons: failing since 1 day (last pass: v4.9.93 - f=
irst fail: v4.9.93-276-gebae58704fed)

arm64:

    defconfig:
        r8a7795-salvator-x:
            lab-baylibre: failing since 1 day (last pass: v4.9.93 - first f=
ail: v4.9.93-278-g1614c07609f0)

Boot Failures Detected:

arm:

    sama5_defconfig
        at91-sama5d3_xplained: 1 failed lab

    multi_v7_defconfig
        at91-sama5d3_xplained: 1 failed lab
        sun8i-a33-sinlinx-sina33: 1 failed lab

    sunxi_defconfig
        sun8i-a83t-allwinner-h8homlet-v2: 1 failed lab

arm64:

    defconfig
        r8a7795-salvator-x: 1 failed lab

---
For more info write to <info@kernelci.org>
