Return-Path: <bot@kernelci.org>
ARC-Seal: i=1; a=rsa-sha256; t=1519714686; cv=none;
        d=google.com; s=arc-20160816;
        b=pc7tB3jfrE2PFVEcsR9zwTMCBgRMLZYlWP2vLNGvJLHn/6nV8iLY4HKrg4sfSHWZWp
         ukIv1wrLALehSiAkYr/4tKvgH7tJHrn6EQ6FnSiAh1j1oB0S3mOH3KR2W2A6v3nZfagF
         QDahODytdsSX0cu5GGS/4Qioj4I9Mt1GEOAJxdI8isusduahTuxD59u2m6qb40d6m6qd
         IJILuJdyzNJHeRG+qeKK8uAmEcshzatlO2OVAkhMJLVKdecDi8yaSQH6J7qzzhxEevhc
         n3AyR9O8YV8m5btBEy+yKnWhc6zT5V+NRr95gCUD6zab5WBiRbZyYvmzXAouqdLDgg4C
         pxjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:from:to:subject:references:in-reply-to:content-transfer-encoding
         :mime-version:date:message-id:arc-authentication-results;
        bh=YRlpIrjxMcQUImaRFsbI+Nr8kauxKB6H5l0YVf0AIZA=;
        b=oO/MeqU1LqGupBnjZg6J/S8wXM331kN5YFuiHAcyanuXY5b194iA9xumcsafKLP7at
         dA/IM9QQtbOrYw1GQHDEs+3ROTe8phnQE2pJGS/EMGV2oRkoI//Mqbetr+HQFD8Z8ymf
         ARhUkct/8hS3hS5PTzBvrvQzVaFsJlFaiGEoKUC2xPC5A8py8NDxt6umIqX/hx4BfcLx
         kWgE6pFcT2kKoBNUTVE39BTFDD+YgIbyJa4BJOdkNbMaeXEWCuaAe7NbjX7LQj/nEKtk
         hWBkmoJA2tp8JuGt9gDlzN/qBdJBThQtYODDTaJ127nnhJ0R7PCybHUJMnjzISc1aA3Z
         8Jxw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of bot@kernelci.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=bot@kernelci.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of bot@kernelci.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=bot@kernelci.org
X-Google-Smtp-Source: AH8x225e7Uf8cQnA01d1iRliQgPLgCVHZOcsJy+nNiQ5DcAeMlQSKgQqvOyH9pabxsI7TlChskiRdQ==
Message-ID: <5a95017d.ddd4500a.6e7f.1940@mx.google.com>
Date: Mon, 26 Feb 2018 22:58:05 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.14.y
X-Kernelci-Kernel: v4.14.22-55-g5e118d0b219c
X-Kernelci-Report-Type: boot
X-Kernelci-Tree: stable-rc
In-Reply-To: <20180226202144.375869933@linuxfoundation.org>
References: <20180226202144.375869933@linuxfoundation.org>
Subject: Re: [PATCH 4.14 00/54] 4.14.23-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org
From: kernelci.org bot <bot@kernelci.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net,
 shuahkh@osg.samsung.com, patches@kernelci.org, ben.hutchings@codethink.co.uk,
 lkft-triage@lists.linaro.org, stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593496512090917624?=
X-GMAIL-MSGID: =?utf-8?q?1593536346907025934?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

stable-rc/linux-4.14.y boot: 105 boots: 0 failed, 36 passed with 62 offline=
, 7 untried/unknown (v4.14.22-55-g5e118d0b219c)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.14.y/kernel/v4.14.22-55-g5e118d0b219c/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.14.=
y/kernel/v4.14.22-55-g5e118d0b219c/

Tree: stable-rc
Branch: linux-4.14.y
Git Describe: v4.14.22-55-g5e118d0b219c
Git Commit: 5e118d0b219c87128794e0734ec357f68d2846cb
Git URL: http://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git
Tested: 59 unique boards, 22 SoC families, 15 builds out of 185

Offline Platforms:

arm:

    sama5_defconfig:
        at91-sama5d4_xplained: 1 offline lab

    davinci_all_defconfig:
        da850-lcdk: 1 offline lab
        dm365evm,legacy: 1 offline lab

    sunxi_defconfig:
        sun4i-a10-cubieboard: 1 offline lab
        sun7i-a20-bananapi: 1 offline lab
        sun7i-a20-cubietruck: 1 offline lab

    qcom_defconfig:
        qcom-apq8064-cm-qs600: 1 offline lab
        qcom-apq8064-ifc6410: 1 offline lab

    multi_v7_defconfig:
        alpine-db: 1 offline lab
        am335x-boneblack: 1 offline lab
        armada-xp-openblocks-ax3-4: 1 offline lab
        at91-sama5d4_xplained: 1 offline lab
        exynos5250-arndale: 1 offline lab
        exynos5410-odroidxu: 1 offline lab
        exynos5420-arndale-octa: 1 offline lab
        exynos5422-odroidxu3: 1 offline lab
        imx6dl-wandboard_dual: 1 offline lab
        imx6dl-wandboard_solo: 1 offline lab
        meson8b-odroidc1: 1 offline lab
        mt7623n-bananapi-bpi-r2: 1 offline lab
        omap3-beagle: 1 offline lab
        omap3-beagle-xm: 1 offline lab
        omap4-panda: 1 offline lab
        qcom-apq8064-cm-qs600: 1 offline lab
        qcom-apq8064-ifc6410: 1 offline lab
        socfpga_cyclone5_de0_sockit: 1 offline lab
        stih410-b2120: 1 offline lab
        stih410-b2120_rootfs:nfs: 1 offline lab
        sun4i-a10-cubieboard: 1 offline lab
        sun7i-a20-bananapi: 1 offline lab
        sun7i-a20-cubietruck: 1 offline lab
        tegra124-jetson-tk1: 1 offline lab
        tegra20-iris-512: 1 offline lab
        tegra30-beaver: 1 offline lab
        vf610-colibri-eval-v3: 1 offline lab
        zynq-zc702: 1 offline lab

    imx_v6_v7_defconfig:
        imx6dl-wandboard_dual: 1 offline lab
        imx6dl-wandboard_solo: 1 offline lab
        vf610-colibri-eval-v3: 1 offline lab

    mvebu_v7_defconfig:
        armada-xp-openblocks-ax3-4: 1 offline lab

    exynos_defconfig:
        exynos5250-arndale: 1 offline lab
        exynos5410-odroidxu: 1 offline lab
        exynos5420-arndale-octa: 1 offline lab
        exynos5422-odroidxu3: 1 offline lab

    bcm2835_defconfig:
        bcm2835-rpi-b: 1 offline lab

    omap2plus_defconfig:
        am335x-boneblack: 1 offline lab
        omap3-beagle: 1 offline lab
        omap3-beagle-xm: 1 offline lab
        omap4-panda: 1 offline lab

    tegra_defconfig:
        tegra124-jetson-tk1: 1 offline lab
        tegra20-iris-512: 1 offline lab
        tegra30-beaver: 1 offline lab

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
        rk3399-firefly: 1 offline lab
        sun50i-a64-pine64-plus: 1 offline lab

---
For more info write to <info@kernelci.org>
