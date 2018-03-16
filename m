Return-Path: <bot@kernelci.org>
ARC-Seal: i=1; a=rsa-sha256; t=1521234008; cv=none;
        d=google.com; s=arc-20160816;
        b=iYUI4NUrb8ymW0bvTJWIpJCPKaS97NWLK2/KwZc1RfjxcIg1B8piieSr/jpjLE8a75
         9hY78GjYfgjFM7ALYLXyqZniRLJNyxtb3qxZmlHsAqhZZp0lb4fgA3of2kEWhJCXnT19
         E0Ds/pTCHVpbPGo1mwAv2WfVzBxvEq8jKX8yPUXMF/AutdH4Pib047Vf6Hch722eRhbw
         5dDcE8DEA8200BXp/nX6NJoGjOFArHLo0iUFl457ZdcP76w6K9ObReG957zqr0jJ9MGx
         ygXUaNo3QRI+yB+n1AWBEZMloEZV7X13xddDzwZr1bT89ys7nZDMqyik2XFtorkuTaFF
         o6FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:from:to:subject:references:in-reply-to:content-transfer-encoding
         :mime-version:date:message-id:arc-authentication-results;
        bh=lrqYO2JW9kGtklcSD+765RaibltLiGl9vsQCpB93Pt4=;
        b=CTd2m+PlzFC/xuoq8A6OiXujV8/p1EwiP/VFXChCxk+sz8ZIXGOi/TNsmSCUC0I4U3
         ZYtpXeTPC9i5ORoR7SCPuUAMZvrqoXsdpOz8kFYa00ErdEIfJ7dV9DCnDlyUvFbkp708
         6qnoCMdnCZyfqmRpDyP4/biz1OncQNizu4RDm7SoC17QjQimsq6ZpRGE68iln4npOAcX
         jXUwiJ9jtduJYJ86vS7tO3NOyNFofADu/VL/JtXT8j/tWa9bpeXD4PkLl33g3p9j3XFX
         +eqZCQrU99wvABUqw8Mh3P2CGogsa5PJFfkysqPN3hZ2mLgB0q8Up8RVghWyT5iDtQ4e
         UOQQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of bot@kernelci.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=bot@kernelci.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of bot@kernelci.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=bot@kernelci.org
X-Google-Smtp-Source: AG47ELsOfsZMdZ+wGp/3R+E1duNjt/FvV399HydCgygkUs4gCmmgmvmRGi6OMvrkGGY01vUzrj0V8w==
Message-ID: <5aac3057.c1a31c0a.4eeff.5272@mx.google.com>
Date: Fri, 16 Mar 2018 14:00:07 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-3.18.y
X-Kernelci-Kernel: v3.18.99-26-g3074344a1906
X-Kernelci-Report-Type: boot
X-Kernelci-Tree: stable-rc
In-Reply-To: <20180316152232.750180431@linuxfoundation.org>
References: <20180316152232.750180431@linuxfoundation.org>
Subject: Re: [PATCH 3.18 00/25] 3.18.100-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org
From: kernelci.org bot <bot@kernelci.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net,
 shuahkh@osg.samsung.com, patches@kernelci.org, ben.hutchings@codethink.co.uk,
 lkft-triage@lists.linaro.org, stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595108276054795320?=
X-GMAIL-MSGID: =?utf-8?q?1595129471308167095?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

stable-rc/linux-3.18.y boot: 62 boots: 2 failed, 52 passed with 8 offline (=
v3.18.99-26-g3074344a1906)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-3.18.y/kernel/v3.18.99-26-g3074344a1906/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-3.18.=
y/kernel/v3.18.99-26-g3074344a1906/

Tree: stable-rc
Branch: linux-3.18.y
Git Describe: v3.18.99-26-g3074344a1906
Git Commit: 3074344a190695d392821dec4555e5ceacd2e22f
Git URL: http://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git
Tested: 32 unique boards, 13 SoC families, 14 builds out of 167

Boot Regressions Detected:

arm:

    exynos_defconfig:
        exynos5420-arndale-octa:
            lab-baylibre-seattle: failing since 10 days (last pass: v3.18.9=
6-14-g9fdaa6623e85 - first fail: v3.18.98)

    multi_v7_defconfig:
        tegra124-nyan-big:
            lab-collabora: new failure (last pass: v3.18.99)

Boot Failures Detected:

arm:

    multi_v7_defconfig
        tegra124-nyan-big: 1 failed lab

    exynos_defconfig
        exynos5420-arndale-octa: 1 failed lab

Offline Platforms:

arm:

    exynos_defconfig:
        exynos5410-odroidxu: 1 offline lab

    multi_v7_defconfig:
        am335x-boneblack: 1 offline lab
        exynos5410-odroidxu: 1 offline lab
        tegra124-jetson-tk1: 1 offline lab

    sama5_defconfig:
        at91-sama5d4ek: 1 offline lab

    tegra_defconfig:
        tegra124-jetson-tk1: 1 offline lab

    bcm2835_defconfig:
        bcm2835-rpi-b: 1 offline lab

    omap2plus_defconfig:
        am335x-boneblack: 1 offline lab

---
For more info write to <info@kernelci.org>
