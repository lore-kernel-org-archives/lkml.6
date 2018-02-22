Return-Path: <bot@kernelci.org>
ARC-Seal: i=1; a=rsa-sha256; t=1519270654; cv=none;
        d=google.com; s=arc-20160816;
        b=DCFE2Idyx/Ug72Bq3KfVOfNp7UG2HHu4Gv5xeVYesLCk+fOaLqJyRMt38YxHPc11QL
         AtG35hrLrTxjYfYHeylENkvazftt0nZ8sXrLXttctSLVdDVZ8M1GdaHawSJfeyqH3Xcy
         2cWM9GCAiaHyb6bEN/G65e28wCK4eGcEVabw3YAhtA1KBlCGCV0wAf1x6qGFfEwgnRkL
         SoE1VfVkDJM1vtGKhQLG8u4ldqveh+UAy6OcZjIjyS5XRiVos0+4kl0V9mEl/FdrvSOv
         wwP2QEhAddhPe78EXzfKRKmqoxWj/1GwN5xOzBYzBL8YSSLZ56MeidUIiJnmj5ESrzog
         D5Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:from:to:subject:references:in-reply-to:content-transfer-encoding
         :mime-version:date:message-id:arc-authentication-results;
        bh=QPKK4+8bwsRhtHztIL20rW97jfY+Z7edc6Z2YmOYoew=;
        b=pMR5Qh+f92KMCXqxGbA0ih2ilEYhkERPuxLwKgwnzPSzlK8yDAPURPSMhLLl3Ljrpr
         2I7YcBwsaqQ7RIbZeFhY0b56sME1I8MOla6x5sGcUdWXe/fvCoxp+m8uD4PHdPEYibB3
         3ZonrlLnzZ3/sj+2r1OznkFD4B+BHpO+aFhXclujk6q/WiMBp5+rHDP8NQBsq8pgZYaO
         bg3uVsrITtWPRBxoziC7f/zOAkb1RoiK067YeW5YKckAhFc9FSYkS2qDD+Bi9QfXoYFh
         v99ZPQ+waEo0hBPka4fkMKDzQOBOIld6InVJYdIl13OsNQlJ05ek9Qrb0OWWCcoqon4/
         w+GQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of bot@kernelci.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=bot@kernelci.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of bot@kernelci.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=bot@kernelci.org
X-Google-Smtp-Source: AH8x2240zo4Fc74v70tEg81sqGK9rTNd1Q1/OHLJvWiN1BjGzV3g0OgtZCWtNcvDpTzt9iYr3cu8iA==
Message-ID: <5a8e3afd.42121c0a.99fb5.c74f@mx.google.com>
Date: Wed, 21 Feb 2018 19:37:33 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.15.y
X-Kernelci-Kernel: v4.15.4-164-g0cbdf962c728
X-Kernelci-Report-Type: boot
X-Kernelci-Tree: stable-rc
In-Reply-To: <20180221124529.931834518@linuxfoundation.org>
References: <20180221124529.931834518@linuxfoundation.org>
Subject: Re: [PATCH 4.15 000/163] 4.15.5-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org
From: kernelci.org bot <bot@kernelci.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net,
 shuahkh@osg.samsung.com, patches@kernelci.org, ben.hutchings@codethink.co.uk,
 lkft-triage@lists.linaro.org, stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593015952642093599?=
X-GMAIL-MSGID: =?utf-8?q?1593070746118552264?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

stable-rc/linux-4.15.y boot: 80 boots: 1 failed, 63 passed with 16 offline =
(v4.15.4-164-g0cbdf962c728)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.15.y/kernel/v4.15.4-164-g0cbdf962c728/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.15.=
y/kernel/v4.15.4-164-g0cbdf962c728/

Tree: stable-rc
Branch: linux-4.15.y
Git Describe: v4.15.4-164-g0cbdf962c728
Git Commit: 0cbdf962c7289c66ffad7c1fd8fda5dabaafd306
Git URL: http://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git
Tested: 51 unique boards, 21 SoC families, 14 builds out of 185

Boot Regressions Detected:

arm64:

    defconfig:
        meson-gxbb-p200:
            lab-baylibre-seattle: failing since 4 days (last pass: v4.15.3-=
204-g01be67fd216d - first fail: v4.15.4)

Boot Failure Detected:

arm64:

    defconfig
        meson-gxbb-p200: 1 failed lab

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
        juno-r2: 1 offline lab
        meson-gxbb-odroidc2: 1 offline lab

---
For more info write to <info@kernelci.org>
