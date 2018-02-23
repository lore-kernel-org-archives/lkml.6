Return-Path: <bot@kernelci.org>
ARC-Seal: i=1; a=rsa-sha256; t=1519425468; cv=none;
        d=google.com; s=arc-20160816;
        b=GZi1hIXlsmi/3078fAn5GXD4Wb9FlmC+NvF4uFs/D93MoxgFU7guklQo7XYNAHKSgz
         D8LGCaZCOw8M/lsq4zrg22fesnAecfKKAwKTuzi4CDS4zj1PUA1xBVkN/J1jLmN6+oXV
         7oRT7sXO+wav5yVBrLNPENh0bHLz05/dPqUOtlx7LXzqRWAG+xjHI9IjlbPtkgsqY3nQ
         Lspsqp1JGv8ckCBHGMVXJ6Ovik3WHdjn/anPxZiQE+wA06GtmNUeyT5CbRtpLnthuWmb
         d8OT0uDQ51XYlRaNLWO5tUIFK1vW6mQgsXfJkOW3EZpsIHMHPX06Kj7BOVn5HLTfbYV7
         7kNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:from:to:subject:references:in-reply-to:content-transfer-encoding
         :mime-version:date:message-id:arc-authentication-results;
        bh=u0CJeCxCcgZ4VWgRbKbbkVRmevaj/KPtAFNs7/fSTxk=;
        b=AjyqIQ2b17Iny55GTNEnzNm0eYN7VqIwrIvlE7DlIEt3Y2xdhxpYg/kBfB4dw6M8d9
         nAn6KBRopECsRBlmyfm15y8AlZ3vmN6d1Dsv8F9Pp9OpJw2oGMoJhaIFoglmZ86oYFzz
         vctb0xNN22e5XtUX2ef5XsSnf/5j8gbpUftIon59C4UsoIgHAYvcbYw7goTlvyXANg1u
         z2Qvt0jDVpbm26xSb2UKTNtulcWDq5rKRuiYMxXPNi5ht+v1p1JWxJpnUAK4wG8olp0L
         698PpFPTiyPi2pbluvcAYatlTBroJoERyQ32W4WgF1iplYa8Mshmu+fI32wGRgmUPX/6
         HvNg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of bot@kernelci.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=bot@kernelci.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of bot@kernelci.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=bot@kernelci.org
X-Google-Smtp-Source: AG47ELuRGhOfBJJqXA6o42Ve143lr0k21JkfxUIEXfaRNbk52FOzjZschVkuPvlhTZjlGaSCYtdFpA==
Message-ID: <5a9097ba.c8c7df0a.f0996.53cc@mx.google.com>
Date: Fri, 23 Feb 2018 14:37:46 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.4.y
X-Kernelci-Kernel: v4.4.117-194-g5468668278fb
X-Kernelci-Report-Type: boot
X-Kernelci-Tree: stable-rc
In-Reply-To: <20180223170325.997716448@linuxfoundation.org>
References: <20180223170325.997716448@linuxfoundation.org>
Subject: Re: [PATCH 4.4 000/193] 4.4.118-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org
From: kernelci.org bot <bot@kernelci.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net,
 shuahkh@osg.samsung.com, patches@kernelci.org, ben.hutchings@codethink.co.uk,
 lkft-triage@lists.linaro.org, stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593217769867343564?=
X-GMAIL-MSGID: =?utf-8?q?1593233080411573517?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

stable-rc/linux-4.4.y boot: 86 boots: 2 failed, 70 passed with 14 offline (=
v4.4.117-194-g5468668278fb)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.4.y/kernel/v4.4.117-194-g5468668278fb/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.4.y=
/kernel/v4.4.117-194-g5468668278fb/

Tree: stable-rc
Branch: linux-4.4.y
Git Describe: v4.4.117-194-g5468668278fb
Git Commit: 5468668278fb027d3101294c021c57bb000f7962
Git URL: http://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git
Tested: 44 unique boards, 18 SoC families, 15 builds out of 176

Boot Regressions Detected:

arm:

    exynos_defconfig:
        exynos5422-odroidxu3:
            lab-collabora: new failure (last pass: v4.4.116)

    multi_v7_defconfig:
        exynos5422-odroidxu3:
            lab-collabora: new failure (last pass: v4.4.116)

Boot Failures Detected:

arm:

    multi_v7_defconfig
        exynos5422-odroidxu3: 1 failed lab

    exynos_defconfig
        exynos5422-odroidxu3: 1 failed lab

Offline Platforms:

arm:

    exynos_defconfig:
        exynos5410-odroidxu: 1 offline lab
        exynos5422-odroidxu3: 1 offline lab

    multi_v7_defconfig:
        alpine-db: 1 offline lab
        am335x-boneblack: 1 offline lab
        at91-sama5d4_xplained: 1 offline lab
        exynos5410-odroidxu: 1 offline lab
        exynos5422-odroidxu3: 1 offline lab
        socfpga_cyclone5_de0_sockit: 1 offline lab
        tegra124-jetson-tk1: 1 offline lab

    sama5_defconfig:
        at91-sama5d4_xplained: 1 offline lab

    tegra_defconfig:
        tegra124-jetson-tk1: 1 offline lab

    bcm2835_defconfig:
        bcm2835-rpi-b: 1 offline lab

    omap2plus_defconfig:
        am335x-boneblack: 1 offline lab

arm64:

    defconfig:
        apq8016-sbc: 1 offline lab

---
For more info write to <info@kernelci.org>
