Return-Path: <bot@kernelci.org>
ARC-Seal: i=1; a=rsa-sha256; t=1525143860; cv=none;
        d=google.com; s=arc-20160816;
        b=EZxPH1abyixcBVz0JXKeBKiEoSaAWDjdyC68rM9mFMExjJejRV54m8krNkGfSYg1tS
         D6a8hOxGFG8tNI/70t3p3KMt9tHpCC4f4np4rXssPqPJ5KTRQ5d50/CUKdRz7KUggzWw
         /Mplge+Ie8Bryx8qRCjmaPlU1NEbkP+GfoD+IePuFAc40zzq7ZIPALCC8ztLcbN/Xj3/
         tks6fPqitVor/cgLaEEkxyDTl7KnOxGPiL33FTNUsCGD8xmZuw8yBSLqEg+4WxnYrghp
         XPI/ei2wRGkrIgbO77xpqurH/636/Gi2futXDL/WuS1OhHknPBdJWvRgjHb6vxLIskep
         qhmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:from:to:subject:references:in-reply-to:content-transfer-encoding
         :mime-version:date:message-id:arc-authentication-results;
        bh=oEvDgNj20miGz1srOjOZjQ4yhITyThAb6Rm29RlaCf0=;
        b=FMEg8LGeOiK7q0HS4CNqgr0lr26ehnFuKcjNIqVnwwScyrMtsPSck3F/79mEf+y0JH
         A2Y2jJLIdFP/oTbF00iQna46fslH7utLDI3bglEiSI0gzlR2Fbutz5g6ZyvQRedseg+V
         kxbXVe1EqcSe+vQoxByQKpM3/ekevPfZAP2eG3GYO8IJPhMajUPdq0M+MHeNof3B0dN6
         QPCbGZnWL7SnAXQsMmwLzjr6zAbyjh+sUnhHQYHgK4S7Qe2OWOBh0qogFVChIOOuh3rH
         s7AiNXqTn06ZYoA/8uikco0Ky6Pe+3ZVv6cT3VQdlxst6bwI/c1uJSz/MoDU/D0WT53+
         gI6A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of bot@kernelci.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=bot@kernelci.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of bot@kernelci.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=bot@kernelci.org
X-Google-Smtp-Source: AB8JxZq2inS0d1F3en6rxKaSwSeGHnlnSrAVAkUHrzykKJZwRSgyVpnIERIuZMkB4Xk1CDXj1nDddA==
Message-ID: <5ae7d933.1c69fb81.dfe2.9198@mx.google.com>
Date: Mon, 30 Apr 2018 20:04:19 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.16.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: boot
X-Kernelci-Kernel: v4.16.6-114-g2556b63fc617
In-Reply-To: <20180430184015.043892819@linuxfoundation.org>
References: <20180430184015.043892819@linuxfoundation.org>
Subject: Re: [PATCH 4.16 000/113] 4.16.7-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org
From: kernelci.org bot <bot@kernelci.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net,
 shuah@kernel.org, patches@kernelci.org, ben.hutchings@codethink.co.uk,
 lkft-triage@lists.linaro.org, stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599200552563125993?=
X-GMAIL-MSGID: =?utf-8?q?1599229248710825519?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

stable-rc/linux-4.16.y boot: 141 boots: 2 failed, 77 passed with 62 offline=
 (v4.16.6-114-g2556b63fc617)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.16.y/kernel/v4.16.6-114-g2556b63fc617/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.16.=
y/kernel/v4.16.6-114-g2556b63fc617/

Tree: stable-rc
Branch: linux-4.16.y
Git Describe: v4.16.6-114-g2556b63fc617
Git Commit: 2556b63fc6172dd60f9d95749b5b8cfa6378cf78
Git URL: http://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git
Tested: 77 unique boards, 23 SoC families, 17 builds out of 186

Boot Regressions Detected:

arm:

    multi_v7_defconfig:
        at91-sama5d4_xplained:
            lab-free-electrons: new failure (last pass: v4.16.6)
        sun8i-a83t-allwinner-h8homlet-v2:
            lab-free-electrons: new failure (last pass: v4.16.6)

Boot Failures Detected:

arm:

    multi_v7_defconfig
        at91-sama5d4_xplained: 1 failed lab
        sun8i-a83t-allwinner-h8homlet-v2: 1 failed lab

Offline Platforms:

arm:

    sunxi_defconfig:
        sun4i-a10-cubieboard: 1 offline lab
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
        exynos5420-arndale-octa: 1 offline lab
        exynos5422-odroidxu3: 1 offline lab
        exynos5800-peach-pi: 1 offline lab
        imx6dl-wandboard_dual: 1 offline lab
        imx7s-warp: 1 offline lab
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
        imx7s-warp: 1 offline lab
        vf610-colibri-eval-v3: 1 offline lab

    exynos_defconfig:
        exynos5250-arndale: 1 offline lab
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
        juno-r2: 1 offline lab
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
