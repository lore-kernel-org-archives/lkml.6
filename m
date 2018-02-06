Return-Path: <bot@kernelci.org>
ARC-Seal: i=1; a=rsa-sha256; t=1517877370; cv=none;
        d=google.com; s=arc-20160816;
        b=wSH+qCAr3wSYL3221Lf6GSN3jeNJu4/TWzHsK4ZJzgdHqdZPvidTWYx88dGEpeM9zw
         ifw3oRtkuNWs8yIJibcRUwMMgzJeVCT9ny244KOBXAwCb/8+ILCMeCu19QCcaOLTgBM5
         cVh2zaFfdfLppkqqSlzcu0UmKsHIRWU0z8mGUOvHojeYghlC12b+KWLYPyuCDQomJfYQ
         12Zx130R/jtlGmIs99lWUYbcnbqHR0BLm2RpL/B9+R7fKzgNVIfntgWjAAyEstAofzPB
         C75GBXYXUNRbTXJZ1ewjBM8kcK2Ha2IxqERJqgXBjul6pFWb/bLy9GeMp4bCRa1tGUru
         fs5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:from:to:subject:references:in-reply-to:content-transfer-encoding
         :mime-version:date:message-id:arc-authentication-results;
        bh=xpDdGuNUWpgNzz7ws1ja8rKLTa7nimVLYyjVg+yEmXs=;
        b=RuBichgwcQhu9L95UGqEcqfG0z+g6+YWKsWfXbv6d7CFIauzWtNmJ0OGYUTnY2nKOc
         kt6E1lPM6/NKFI7vls+ui0iC2qVhJjAGD2+i/8Ds0vHnK9e7un/m7PneUCwgOZjVo4EL
         aOOTa+PwUrLpUCZfXhESMebnCLvOLSJc1xMTDo0CKcafBxOvqdnYAk6OULxM/bWTD3pU
         vpq+2y3jNJbq0DQmjUMjtpNoNR2kQKV5diBARqaq1ehEsqVDXk/l18gWVWuX/rKEEKF9
         Trs3hOHqmrE76N1Y2uIyFnE8T2BU5ROFdIujZYC++S66V2pHDs4CVitXN4uEouev0Zb0
         jmoA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of bot@kernelci.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=bot@kernelci.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of bot@kernelci.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=bot@kernelci.org
X-Google-Smtp-Source: AH8x226dTqilybzgz2C5mqcwUpOCa+p7gkxV1YdFFYmpFcPY+HTv22FI3rs8NTzZvYhEq/LCVZ3xSw==
Message-ID: <5a78f878.15741c0a.d60f0.5c51@mx.google.com>
Date: Mon, 05 Feb 2018 16:36:08 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.14.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v4.14.17-65-g161cd48d7ece
X-Kernelci-Report-Type: boot
In-Reply-To: <20180205182138.571333346@linuxfoundation.org>
References: <20180205182138.571333346@linuxfoundation.org>
Subject: Re: [PATCH 4.14 00/64] 4.14.18-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org
From: kernelci.org bot <bot@kernelci.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net,
 shuahkh@osg.samsung.com, patches@kernelci.org, ben.hutchings@codethink.co.uk,
 lkft-triage@lists.linaro.org, stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591586331636527491?=
X-GMAIL-MSGID: =?utf-8?q?1591609781142901996?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

stable-rc/linux-4.14.y boot: 110 boots: 1 failed, 47 passed with 62 offline=
 (v4.14.17-65-g161cd48d7ece)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.14.y/kernel/v4.14.17-65-g161cd48d7ece/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.14.=
y/kernel/v4.14.17-65-g161cd48d7ece/

Tree: stable-rc
Branch: linux-4.14.y
Git Describe: v4.14.17-65-g161cd48d7ece
Git Commit: 161cd48d7ece18d8e7256f58ea7b48a417e7eade
Git URL: http://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git
Tested: 62 unique boards, 22 SoC families, 16 builds out of 185

Boot Regressions Detected:

arm:

    exynos_defconfig:
        exynos5250-snow:
            lab-collabora: new failure (last pass: v4.14.17)

Boot Failure Detected:

arm:

    exynos_defconfig
        exynos5250-snow: 1 failed lab

Offline Platforms:

arm:

    sunxi_defconfig:
        sun4i-a10-cubieboard: 1 offline lab
        sun5i-r8-chip: 1 offline lab
        sun7i-a20-bananapi: 1 offline lab
        sun7i-a20-cubietruck: 1 offline lab

    bcm2835_defconfig:
        bcm2835-rpi-b: 1 offline lab

    tegra_defconfig:
        tegra124-jetson-tk1: 1 offline lab
        tegra20-iris-512: 1 offline lab
        tegra30-beaver: 1 offline lab

    mvebu_v7_defconfig:
        armada-xp-openblocks-ax3-4: 1 offline lab

    multi_v7_defconfig:
        alpine-db: 1 offline lab
        armada-xp-openblocks-ax3-4: 1 offline lab
        at91-sama5d4_xplained: 1 offline lab
        exynos5250-arndale: 1 offline lab
        exynos5410-odroidxu: 1 offline lab
        exynos5420-arndale-octa: 1 offline lab
        exynos5422-odroidxu3: 1 offline lab
        imx6dl-wandboard_dual: 1 offline lab
        imx6dl-wandboard_solo: 1 offline lab
        meson8b-odroidc1: 1 offline lab
        omap3-beagle: 1 offline lab
        omap3-beagle-xm: 1 offline lab
        omap4-panda: 1 offline lab
        qcom-apq8064-cm-qs600: 1 offline lab
        qcom-apq8064-ifc6410: 1 offline lab
        socfpga_cyclone5_de0_sockit: 1 offline lab
        stih410-b2120: 1 offline lab
        stih410-b2120_rootfs:nfs: 1 offline lab
        sun4i-a10-cubieboard: 1 offline lab
        sun5i-r8-chip: 1 offline lab
        sun7i-a20-bananapi: 1 offline lab
        sun7i-a20-cubietruck: 1 offline lab
        tegra124-jetson-tk1: 1 offline lab
        tegra20-iris-512: 1 offline lab
        tegra30-beaver: 1 offline lab
        vf610-colibri-eval-v3: 1 offline lab
        zynq-zc702: 1 offline lab

    omap2plus_defconfig:
        omap3-beagle: 1 offline lab
        omap3-beagle-xm: 1 offline lab
        omap4-panda: 1 offline lab

    imx_v6_v7_defconfig:
        imx6dl-wandboard_dual: 1 offline lab
        imx6dl-wandboard_solo: 1 offline lab
        vf610-colibri-eval-v3: 1 offline lab

    davinci_all_defconfig:
        da850-lcdk: 1 offline lab
        dm365evm,legacy: 1 offline lab

    exynos_defconfig:
        exynos5250-arndale: 1 offline lab
        exynos5410-odroidxu: 1 offline lab
        exynos5420-arndale-octa: 1 offline lab
        exynos5422-odroidxu3: 1 offline lab

    qcom_defconfig:
        qcom-apq8064-cm-qs600: 1 offline lab
        qcom-apq8064-ifc6410: 1 offline lab

    sama5_defconfig:
        at91-sama5d4_xplained: 1 offline lab

arm64:

    defconfig:
        apq8016-sbc: 1 offline lab
        bcm2837-rpi-3-b: 1 offline lab
        juno-r2: 1 offline lab
        meson-gxbb-odroidc2: 1 offline lab
        meson-gxbb-p200: 1 offline lab
        meson-gxl-s905d-p230: 1 offline lab
        meson-gxl-s905x-khadas-vim: 1 offline lab
        meson-gxl-s905x-nexbox-a95x: 1 offline lab
        meson-gxl-s905x-p212: 1 offline lab
        rk3399-firefly: 1 offline lab
        sun50i-a64-pine64-plus: 1 offline lab

---
For more info write to <info@kernelci.org>
