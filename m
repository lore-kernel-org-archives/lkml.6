Return-Path: <bot@kernelci.org>
ARC-Seal: i=1; a=rsa-sha256; t=1521242408; cv=none;
        d=google.com; s=arc-20160816;
        b=KGBSXJ31olksYWl1a21rgJCu4py8jxrTzggrLsuuJrt28S7NLFsY6CwNqiXKmyfDuI
         JNoB3XvABIb8uxifKrJQdeYZp4t86YqwVH/A7fYUTR1njjztQz5kPVFDsGbFnktraYVq
         QU/Uv5y3zx4PMZL66SyMg8xFrAmdrcuCXw8ep9OCgBbHuFFtk4+zEMZtMb74IZ0EfuYp
         oU0yDWN62SKjGaGlM9j7rmMp33p2dHuJNRNKAf16n0fkTQQVY1HAfDufJTCF9RDYa/FB
         DdrVBgUt/JwINCLbzPbLyZqJh1ugAaw2aDxjOpt7xbqkwCaYhq0558Ka+NqGx3Hu6JwM
         mMtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:from:to:subject:references:in-reply-to:content-transfer-encoding
         :mime-version:date:message-id:arc-authentication-results;
        bh=93lMHNwuHhly4AqHgwatF5shgWfeWzbLyegldNFK7/I=;
        b=KLXzIogurFQaBmz21IUwj9207iveVcLdFBzhpXipdb+vvSlDcfyf1735/VUHJDp7xP
         Z7CQ7E3s4LeXj6oxCMNPnCWRObR8p483phqjWng6NsTngZynSjC93jeYQt2UDMwnY3pP
         +bM/bjt/itHb6BLsjnAOQ3Gfg64BNrid+auUA7YqczobA5EjW6KSJdZYZlbSF9YS/+mX
         MyPdaBUYoFEX97aJEdXV538jtNRL1AF+P7LNrsa0uOdJLF10nhd5St6NHVl0mw0MEF2p
         tJ+rhg7yWSJcQu6sQWg9ifrhamSdSFATAgWkfWX8Y4MUwc+gxCEqMrr8Bgujtc7DSJPc
         P3iw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of bot@kernelci.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=bot@kernelci.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of bot@kernelci.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=bot@kernelci.org
X-Google-Smtp-Source: AG47ELsbiRrt+JT3vvTJ1PULZVrTDYf2XPTtbj4+40wVB5i/GXoRjuUr1yxtGHhILCEaG/nBHIiQ2Q==
Message-ID: <5aac5127.10afdf0a.54669.fe7b@mx.google.com>
Date: Fri, 16 Mar 2018 16:20:07 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.4.y
X-Kernelci-Kernel: v4.4.121-64-gd7facaec9c1e
X-Kernelci-Report-Type: boot
X-Kernelci-Tree: stable-rc
In-Reply-To: <20180316152259.964532775@linuxfoundation.org>
References: <20180316152259.964532775@linuxfoundation.org>
Subject: Re: [PATCH 4.4 00/63] 4.4.122-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org
From: kernelci.org bot <bot@kernelci.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net,
 shuahkh@osg.samsung.com, patches@kernelci.org, ben.hutchings@codethink.co.uk,
 lkft-triage@lists.linaro.org, stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595108525093354259?=
X-GMAIL-MSGID: =?utf-8?q?1595138279987929980?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

stable-rc/linux-4.4.y boot: 101 boots: 2 failed, 79 passed with 17 offline,=
 3 untried/unknown (v4.4.121-64-gd7facaec9c1e)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.4.y/kernel/v4.4.121-64-gd7facaec9c1e/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.4.y=
/kernel/v4.4.121-64-gd7facaec9c1e/

Tree: stable-rc
Branch: linux-4.4.y
Git Describe: v4.4.121-64-gd7facaec9c1e
Git Commit: d7facaec9c1eb3d2703ce89b2ab81207eb7a4e6c
Git URL: http://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git
Tested: 54 unique boards, 20 SoC families, 16 builds out of 178

Boot Regressions Detected:

arm:

    multi_v7_defconfig:
        tegra124-nyan-big:
            lab-collabora: new failure (last pass: v4.4.121)

    tegra_defconfig:
        tegra124-nyan-big:
            lab-collabora: new failure (last pass: v4.4.121)

Boot Failures Detected:

arm:

    multi_v7_defconfig
        tegra124-nyan-big: 1 failed lab

    tegra_defconfig
        tegra124-nyan-big: 1 failed lab

Offline Platforms:

arm:

    tegra_defconfig:
        tegra124-jetson-tk1: 1 offline lab

    multi_v7_defconfig:
        alpine-db: 1 offline lab
        am335x-boneblack: 1 offline lab
        at91-sama5d4_xplained: 1 offline lab
        exynos5410-odroidxu: 1 offline lab
        meson8b-odroidc1: 1 offline lab
        socfpga_cyclone5_de0_sockit: 1 offline lab
        sun5i-r8-chip: 1 offline lab
        tegra124-jetson-tk1: 1 offline lab
        vf610-colibri-eval-v3: 1 offline lab

    sunxi_defconfig:
        sun5i-r8-chip: 1 offline lab

    imx_v6_v7_defconfig:
        vf610-colibri-eval-v3: 1 offline lab

    sama5_defconfig:
        at91-sama5d4_xplained: 1 offline lab

    exynos_defconfig:
        exynos5410-odroidxu: 1 offline lab

    bcm2835_defconfig:
        bcm2835-rpi-b: 1 offline lab

    omap2plus_defconfig:
        am335x-boneblack: 1 offline lab

arm64:

    defconfig:
        apq8016-sbc: 1 offline lab

---
For more info write to <info@kernelci.org>
