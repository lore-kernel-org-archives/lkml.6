Return-Path: <bot@kernelci.org>
ARC-Seal: i=1; a=rsa-sha256; t=1521231607; cv=none;
        d=google.com; s=arc-20160816;
        b=efXP7mep5xp2gHHCI/La8VdjW/GIytlssmjqh3jFUuet7OwNsX1Kh3xPqCCoWfu3uH
         0n04UYKUhJi6VQF6Rz4KNxbzwUny69e3/ijnaiYvPc/7we95PUj8UI3l96haf23hg8Lc
         U3tozJnTmCNru38WBAlfDoD9MnRvItNR/GQsol/6Fy0GILSTec/agmIXg8BXyQ2X0h0o
         3nJVcUQ6NThJnfkwnwqBAAO9KO1YzQe6IYiqRaIHKiRLbHMB4+NwBmOE9F9Bd/P3vzpW
         Yf/P9umTz6OfThBIW0EXUBqTtZO7/9Ny74yb5XTZqOeN5xkY3v9anFOsqwrHVZD3s9xo
         0MkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:from:to:subject:references:in-reply-to:content-transfer-encoding
         :mime-version:date:message-id:arc-authentication-results;
        bh=0zFeQ8z6d8QTfP861ZacDqAXuhY01bRbrR6GSDYn4Mo=;
        b=N2XAQKK6FbPSkdt0T6xl1MYn6mo8BxsxMROw7KoURqw3XTtekSxNMA1HLoaysqt8dX
         E4M8Aek/TEbZ/g8W6WJ2LHDrPN2MZkp/P5U+PUO3Vc3uyvQI/kN5Wbvmgm8on+3+JMqT
         qTX+450pn/g/UB71p2hz2QZ39RtT2T2BTimqFq4og+oERwy1DGm7pcKx8mJNprvOjPGC
         D5Zia7LxQmg9O2RMibk0ETus0/xjeR2Cf7Qs7CfDrUKorDE4TqNssZZfphO8S8UU33DO
         prH1zCv7xgmHK2r3g9IAr5jhZT7SrAEszCHK6BWdaIkgN+cr2AeF9xoUlpLLlCIdLgpP
         aQtA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of bot@kernelci.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=bot@kernelci.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of bot@kernelci.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=bot@kernelci.org
X-Google-Smtp-Source: AG47ELuklNHHrslaCKi1cyGLSrG1Z24U+6EQyu7ydspRC805K9LYq5RJVDDtkWp6Bz5pDggc6q3hSQ==
Message-ID: <5aac26f6.89981c0a.32845.a10e@mx.google.com>
Date: Fri, 16 Mar 2018 13:20:06 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.15.y
X-Kernelci-Kernel: v4.15.10-129-gadfb64c5bcd2
X-Kernelci-Report-Type: boot
X-Kernelci-Tree: stable-rc
In-Reply-To: <20180316152336.199007505@linuxfoundation.org>
References: <20180316152336.199007505@linuxfoundation.org>
Subject: Re: [PATCH 4.15 000/128] 4.15.11-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org
From: kernelci.org bot <bot@kernelci.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net,
 shuahkh@osg.samsung.com, patches@kernelci.org, ben.hutchings@codethink.co.uk,
 lkft-triage@lists.linaro.org, stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595109395590505536?=
X-GMAIL-MSGID: =?utf-8?q?1595126954487854486?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

stable-rc/linux-4.15.y boot: 45 boots: 0 failed, 38 passed with 5 offline, =
1 untried/unknown, 1 conflict (v4.15.10-129-gadfb64c5bcd2)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.15.y/kernel/v4.15.10-129-gadfb64c5bcd2/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.15.=
y/kernel/v4.15.10-129-gadfb64c5bcd2/

Tree: stable-rc
Branch: linux-4.15.y
Git Describe: v4.15.10-129-gadfb64c5bcd2
Git Commit: adfb64c5bcd2c15abb5e2a114550e454e5d95268
Git URL: http://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git
Tested: 37 unique boards, 11 SoC families, 13 builds out of 185

Boot Regressions Detected:

arm:

    exynos_defconfig:
        exynos5800-peach-pi:
            lab-baylibre-seattle: failing since 1 day (last pass: v4.15.9-1=
46-g2ad27e8a3cad - first fail: v4.15.10)

Offline Platforms:

arm:

    tegra_defconfig:
        tegra124-jetson-tk1: 1 offline lab

    sunxi_defconfig:
        sun5i-r8-chip: 1 offline lab

    exynos_defconfig:
        exynos5410-odroidxu: 1 offline lab

    imx_v6_v7_defconfig:
        vf610-colibri-eval-v3: 1 offline lab

    sama5_defconfig:
        at91-sama5d4_xplained: 1 offline lab

Conflicting Boot Failure Detected: (These likely are not failures as other =
labs are reporting PASS. Needs review.)

arm:

    exynos_defconfig:
        exynos5800-peach-pi:
            lab-collabora: PASS
            lab-baylibre-seattle: FAIL

---
For more info write to <info@kernelci.org>
