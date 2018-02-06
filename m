Return-Path: <bot@kernelci.org>
ARC-Seal: i=1; a=rsa-sha256; t=1517877369; cv=none;
        d=google.com; s=arc-20160816;
        b=IYvAQWpZS9RlV+F74MsiKjHbBoruv4n77yVM03IIqHhU8Kc/+wZt+HnVwtHZeXLiMA
         e61JcZEFBLQ9DMSHPz2AmdtovptLbbID7U/etZlSVqWQfhhommMs5Xy+sDARE/rfTTUC
         hkWI9nVR6dKm/0vxKtRkYCPQVnvMK30BfTAaR0wu8nD0hcw7SNkOtGk9Jq9lG4oD+4bM
         zajPVx22jkMGWB+YWeERIkaXpwTcCEwn983D1vhdQ7HTDm2DdDlQzEoYCqkwlzjWo0fk
         1P0M56IoXCHvAQwMKE0/4dgRG3jL8ZsgUBRoU97fVlToKRX7CkUrgDYYYZV/hkMcIbAu
         1oTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:from:to:subject:references:in-reply-to:content-transfer-encoding
         :mime-version:date:message-id:arc-authentication-results;
        bh=0bYIP7NEAkc5MzJrl27jYOfX4VxsLV6awHoA9Ek4zNE=;
        b=oPdovfkOxTODsQzDGGUjYtkB5JmvO+F+Jgw/NYwSIksEFf7EQ8OEtNq+2+3qWnL5w2
         okXtce3OtFaGYo4fV8W4ub7dstN5FMPH6sJW5gIViqxUcsFQw3N7/FcWNUcQ+JBceh2m
         OCKotl6wyan9DxT+I/mvaeF4VvbBxREOYhs9wTM7vCdLd6KP+xaeOupiD7lKaBhmBTyg
         gs0GCeun/aoq+Iyz57UN7SL71cp1EtF63xM5cCtHRQCfjNZVwYSbFEPJ+4+mLaaig7B8
         pvzFr/e6xtXjdTENX8qBKmzmYyXwkBFgCnMHrRHHUTPdpVg66moVKJZbAXAZd6j5FH8b
         jIDQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of bot@kernelci.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=bot@kernelci.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of bot@kernelci.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=bot@kernelci.org
X-Google-Smtp-Source: AH8x227ccfgSz8a2Wrt7qJ/xWpkaOHDOBkesMmDT0br0TCtjh40kuZdwmN+Lqsz54ZxO9iT3UUbRhQ==
Message-ID: <5a78f878.e3aedf0a.9d8c2.2dfa@mx.google.com>
Date: Mon, 05 Feb 2018 16:36:08 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.15.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v4.15.1-61-g7ab5513e4cbc
X-Kernelci-Report-Type: boot
In-Reply-To: <20180205182213.902626065@linuxfoundation.org>
References: <20180205182213.902626065@linuxfoundation.org>
Subject: Re: [PATCH 4.15 00/60] 4.15.2-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org
From: kernelci.org bot <bot@kernelci.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net,
 shuahkh@osg.samsung.com, patches@kernelci.org, ben.hutchings@codethink.co.uk,
 lkft-triage@lists.linaro.org, stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591586440278202912?=
X-GMAIL-MSGID: =?utf-8?q?1591609780956663451?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

stable-rc/linux-4.15.y boot: 110 boots: 0 failed, 48 passed with 62 offline=
 (v4.15.1-61-g7ab5513e4cbc)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.15.y/kernel/v4.15.1-61-g7ab5513e4cbc/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.15.=
y/kernel/v4.15.1-61-g7ab5513e4cbc/

Tree: stable-rc
Branch: linux-4.15.y
Git Describe: v4.15.1-61-g7ab5513e4cbc
Git Commit: 7ab5513e4cbc716221fa956decd2842373c54452
Git URL: http://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git
Tested: 62 unique boards, 22 SoC families, 16 builds out of 185

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
