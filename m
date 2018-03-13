Return-Path: <bot@kernelci.org>
ARC-Seal: i=1; a=rsa-sha256; t=1520972390; cv=none;
        d=google.com; s=arc-20160816;
        b=CDQT6lvVUcClwUMPLK5b0cjQcBxfWXZZZIaupXkidQsIUDi4wZNjEnQYTkmah2JMfv
         yn0FHjG0i+JdQhDfngLyR5JrEljWgrI7zBcwQIya3Q1R2jwkmv3xpbIxoJVGMG+yhdAe
         7LlQRqsBfdV51QTbrMXFscE6b6a4LJ8utucOGnmOH6o0/NorndtfOPTJi0gaJIzQdFIj
         pqb8TiuSX239VEHMs+9rU8oZT6SsAO+O2QXi2kN7ujKuv+iE3cvh2qscKY3uklhgm0CA
         nwjVUHXjjHxOIbTdYUDPDhJJ1J+naXi+EFN5bmm5XToPAdc/WAEdR3YOs+7HbdqMB0v7
         wB9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:from:to:subject:references:in-reply-to:content-transfer-encoding
         :mime-version:date:message-id:arc-authentication-results;
        bh=5t46UAWgA4Vp/TWRvDDatuVqtFkHO4iIncHFboQk5kI=;
        b=xrY8zySYwi/s6hzDA5Kp4lPh25pgD/ChFS9Mq0q6c4wFDcNXqhkG8+kIX1v+kvuowW
         ju9Yosm52MjGhhUxMYcLCZxayP7AJddeOLp21HlpZxG/5XtgQP0EY+m5r1rS42KyrEGz
         Wrgcvl6dCC4drGrzYy8q1AhJbZOfHopFerhfFGLdg5XiMefw2AJu3uIAqkbRjADqbdPr
         jqffrXHfd75AnVNXpBMsUCTVlZlnv2oCTeUSW3eLfHcFT2aJzH9WMxz/oEirHznXWore
         l8JPM5KnsgpmPljkJOxVEdxaZxBys+GyEg0PLP/0Yh1qf6GxVyYYnUL5AtTz6Qb+gHSC
         4Gmg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of bot@kernelci.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=bot@kernelci.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of bot@kernelci.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=bot@kernelci.org
X-Google-Smtp-Source: AG47ELsmIH9Qs51zi5OnY+HrEVANLJ9my6Z8GZqlpkA/Z7KHszfSwHoCbqGySxjOsZIrxjCZ66rneA==
Message-ID: <5aa83265.2990df0a.e592d.4135@mx.google.com>
Date: Tue, 13 Mar 2018 13:19:49 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.15.y
X-Kernelci-Kernel: v4.15.9-147-g478762923754
X-Kernelci-Report-Type: boot
X-Kernelci-Tree: stable-rc
In-Reply-To: <20180313152320.439085687@linuxfoundation.org>
References: <20180313152320.439085687@linuxfoundation.org>
Subject: Re: [PATCH 4.15 000/146] 4.15.10-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org
From: kernelci.org bot <bot@kernelci.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net,
 shuahkh@osg.samsung.com, patches@kernelci.org, ben.hutchings@codethink.co.uk,
 lkft-triage@lists.linaro.org, stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594836801301255765?=
X-GMAIL-MSGID: =?utf-8?q?1594855145992294791?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

stable-rc/linux-4.15.y boot: 144 boots: 8 failed, 112 passed with 21 offlin=
e, 2 untried/unknown, 1 conflict (v4.15.9-147-g478762923754)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.15.y/kernel/v4.15.9-147-g478762923754/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.15.=
y/kernel/v4.15.9-147-g478762923754/

Tree: stable-rc
Branch: linux-4.15.y
Git Describe: v4.15.9-147-g478762923754
Git Commit: 47876292375471e74934c42b819483362073feb2
Git URL: http://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git
Tested: 77 unique boards, 22 SoC families, 17 builds out of 185

Boot Regressions Detected:

arm:

    exynos_defconfig:
        exynos5800-peach-pi:
            lab-baylibre-seattle: failing since 1 day (last pass: v4.15.8-1=
2-g212dd4bb587d - first fail: v4.15.9)

    multi_v7_defconfig:
        meson8b-odroidc1:
            lab-baylibre-seattle: new failure (last pass: v4.15.8)
        sun8i-a33-sinlinx-sina33:
            lab-free-electrons: new failure (last pass: v4.15.9)

    mvebu_v7_defconfig:
        armada-375-db:
            lab-free-electrons: new failure (last pass: v4.15.9)

arm64:

    defconfig:
        apq8016-sbc:
            lab-mhart: new failure (last pass: v4.15.9)
        meson-gxbb-p200:
            lab-baylibre-seattle: failing since 1 day (last pass: v4.15.8 -=
 first fail: v4.15.9)
        meson-gxl-s905d-p230:
            lab-baylibre-seattle: new failure (last pass: v4.15.9)
        meson-gxl-s905x-khadas-vim:
            lab-baylibre: new failure (last pass: v4.15.9)
        meson-gxl-s905x-p212:
            lab-baylibre-seattle: new failure (last pass: v4.15.9)

Boot Failures Detected:

arm:

    mvebu_v7_defconfig
        armada-375-db: 1 failed lab

    multi_v7_defconfig
        meson8b-odroidc1: 1 failed lab
        sun8i-a33-sinlinx-sina33: 1 failed lab

arm64:

    defconfig
        apq8016-sbc: 1 failed lab
        meson-gxbb-p200: 1 failed lab
        meson-gxl-s905d-p230: 1 failed lab
        meson-gxl-s905x-khadas-vim: 1 failed lab
        meson-gxl-s905x-p212: 1 failed lab

Offline Platforms:

arm:

    tegra_defconfig:
        tegra124-jetson-tk1: 1 offline lab

    multi_v7_defconfig:
        alpine-db: 1 offline lab
        am335x-boneblack: 1 offline lab
        at91-sama5d4_xplained: 1 offline lab
        exynos5410-odroidxu: 1 offline lab
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
        juno-r2: 1 offline lab
        meson-gxbb-odroidc2: 1 offline lab
        meson-gxl-s905x-khadas-vim: 1 offline lab
        meson-gxl-s905x-nexbox-a95x: 1 offline lab
        mt7622-rfb1: 1 offline lab

Conflicting Boot Failure Detected: (These likely are not failures as other =
labs are reporting PASS. Needs review.)

arm:

    exynos_defconfig:
        exynos5800-peach-pi:
            lab-collabora: PASS
            lab-baylibre-seattle: FAIL

---
For more info write to <info@kernelci.org>
