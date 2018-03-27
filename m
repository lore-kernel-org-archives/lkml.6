Return-Path: <bot@kernelci.org>
ARC-Seal: i=1; a=rsa-sha256; t=1522194069; cv=none;
        d=google.com; s=arc-20160816;
        b=bT2Y+UjfcJ/4BFRfhy6PbDps1f87aA26Ng8ob/5X9ivCNN+QjHd1Ne5L6+MW6jJTFB
         he7LE+yE0yIWtHeH+SVYHlt/qSxVnJUrzPGOW3KTKqqaQHWTHv4MECTI7/H7H4XKklxH
         78dF7uYscG0Fk6hIEOY2JAjWiJ8YzoiRHYN/HKCc7v2KKEBcyaXlQpswQPQS0opBNLKF
         FI+/IgBIjgjKtx7lq1rpwa3MGuGOK72r0Sw4C0mUKiWsYmODcSK7iQ5XdlHpxgTd9+fU
         6EwyXAGi49kr0RFiP3gpgvKYgzwpx/qdrtdfeYAWfL6H8n2Rr/Duh9vN99niy1Jvowbt
         R4XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:from:to:subject:references:in-reply-to:content-transfer-encoding
         :mime-version:date:message-id:arc-authentication-results;
        bh=3NnohdWLqRunW5Af4cRBJ4+5rR14zdKQwl6xLKjLiXg=;
        b=zuAvlRrox4IY+et/0JoVt5ef/o0nAKdPBacXZO7SEBedknU+GH8ZK/In91ONfYULfu
         EYH/YrFe0NF+sXLbKZWOMKvXyqidaHHu4mHZ4qWJNaDMTJ4M1YdbPP+1Iv2obGJV+Z5T
         4FYeDUp1SjZc4fCAxGODAQumrI592jBgNJ10dbKJse91z0RJHl/U1URHcAZx++M0fHsI
         8t5Kg788vJiKn2yFeaujp3wFa7y1W52mFGyZqI7Yo62KG0LZAnskTwybp5wbookmqhmY
         eeiVwzd7PyMMUH+Vx+gxnhrvRMRoK0J8vaxfrywNH9Dfrfc8rpqufnBz5xg5XKhDkA2q
         PICg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of bot@kernelci.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=bot@kernelci.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of bot@kernelci.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=bot@kernelci.org
X-Google-Smtp-Source: AIpwx48uXcgVSXkbBjHDmgpAy6765GLoQIbyKJq2iHMSWvsG99QFqHHdJ2/P6Q+CpWSaEvmolYu8gQ==
Message-ID: <5abad693.c7b3df0a.2af3a.f58b@mx.google.com>
Date: Tue, 27 Mar 2018 16:41:07 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.14.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: boot
X-Kernelci-Kernel: v4.14.30-102-g2d6120998a4c
In-Reply-To: <20180327162749.993880276@linuxfoundation.org>
References: <20180327162749.993880276@linuxfoundation.org>
Subject: Re: [PATCH 4.14 000/101] 4.14.31-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org
From: kernelci.org bot <bot@kernelci.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net,
 shuahkh@osg.samsung.com, patches@kernelci.org, ben.hutchings@codethink.co.uk,
 lkft-triage@lists.linaro.org, stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596109340773797446?=
X-GMAIL-MSGID: =?utf-8?q?1596136168143749248?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

stable-rc/linux-4.14.y boot: 126 boots: 0 failed, 60 passed with 63 offline=
, 3 untried/unknown (v4.14.30-102-g2d6120998a4c)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.14.y/kernel/v4.14.30-102-g2d6120998a4c/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.14.=
y/kernel/v4.14.30-102-g2d6120998a4c/

Tree: stable-rc
Branch: linux-4.14.y
Git Describe: v4.14.30-102-g2d6120998a4c
Git Commit: 2d6120998a4cef5d352e931b1c85f1e3d79081d5
Git URL: http://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git
Tested: 68 unique boards, 23 SoC families, 17 builds out of 185

Offline Platforms:

arm:

    sunxi_defconfig:
        sun4i-a10-cubieboard: 1 offline lab
        sun5i-r8-chip: 1 offline lab
        sun7i-a20-bananapi: 1 offline lab
        sun7i-a20-cubietruck: 1 offline lab

    bcm2835_defconfig:
        bcm2835-rpi-b: 1 offline lab

    sama5_defconfig:
        at91-sama5d4_xplained: 1 offline lab

    multi_v7_defconfig:
        alpine-db: 1 offline lab
        am335x-boneblack: 1 offline lab
        armada-xp-openblocks-ax3-4: 1 offline lab
        at91-sama5d4_xplained: 1 offline lab
        exynos5250-arndale: 1 offline lab
        exynos5410-odroidxu: 1 offline lab
        exynos5420-arndale-octa: 1 offline lab
        exynos5800-peach-pi: 1 offline lab
        imx6dl-wandboard_dual: 1 offline lab
        meson8b-odroidc1: 1 offline lab
        mt7623n-bananapi-bpi-r2: 1 offline lab
        omap3-beagle: 1 offline lab
        omap3-beagle-xm: 1 offline lab
        omap4-panda: 1 offline lab
        qcom-apq8064-cm-qs600: 1 offline lab
        qcom-apq8064-ifc6410: 1 offline lab
        socfpga_cyclone5_de0_sockit: 1 offline lab
        stih410-b2120: 1 offline lab
        sun4i-a10-cubieboard: 1 offline lab
        sun5i-r8-chip: 1 offline lab
        sun7i-a20-bananapi: 1 offline lab
        sun7i-a20-cubietruck: 1 offline lab
        tegra124-jetson-tk1: 1 offline lab
        tegra20-iris-512: 1 offline lab
        tegra30-beaver: 1 offline lab
        vf610-colibri-eval-v3: 1 offline lab
        zynq-zc702: 1 offline lab

    tegra_defconfig:
        tegra124-jetson-tk1: 1 offline lab
        tegra20-iris-512: 1 offline lab
        tegra30-beaver: 1 offline lab

    imx_v6_v7_defconfig:
        imx6dl-wandboard_dual: 1 offline lab
        imx6dl-wandboard_solo: 1 offline lab
        vf610-colibri-eval-v3: 1 offline lab

    exynos_defconfig:
        exynos5250-arndale: 1 offline lab
        exynos5410-odroidxu: 1 offline lab
        exynos5420-arndale-octa: 1 offline lab
        exynos5422-odroidxu3: 1 offline lab
        exynos5800-peach-pi: 1 offline lab

    qcom_defconfig:
        qcom-apq8064-cm-qs600: 1 offline lab
        qcom-apq8064-ifc6410: 1 offline lab

    omap2plus_defconfig:
        am335x-boneblack: 1 offline lab
        omap3-beagle: 1 offline lab
        omap3-beagle-xm: 1 offline lab
        omap4-panda: 1 offline lab

    davinci_all_defconfig:
        da850-lcdk: 1 offline lab
        dm365evm,legacy: 1 offline lab

    mvebu_v7_defconfig:
        armada-xp-openblocks-ax3-4: 1 offline lab

arm64:

    defconfig:
        apq8016-sbc: 1 offline lab
        meson-gxbb-odroidc2: 1 offline lab
        meson-gxbb-p200: 1 offline lab
        meson-gxl-s905d-p230: 1 offline lab
        meson-gxl-s905x-khadas-vim: 1 offline lab
        meson-gxl-s905x-nexbox-a95x: 1 offline lab
        meson-gxl-s905x-p212: 1 offline lab
        mt7622-rfb1: 1 offline lab
        rk3399-firefly: 1 offline lab
        sun50i-a64-pine64-plus: 1 offline lab

---
For more info write to <info@kernelci.org>
