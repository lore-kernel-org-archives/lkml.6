Return-Path: <bot@kernelci.org>
ARC-Seal: i=1; a=rsa-sha256; t=1522196483; cv=none;
        d=google.com; s=arc-20160816;
        b=p6cqlnso8rqxrE+dYU99ddWM5LiyPgau/jclDFRnHIRz5xjUGR5+Vt2l057zUFSnUA
         JIQUIMw/LOW8c1x6/cg31Rf4Buze7jtR7yAIBQ8VQNBbRwSj2x7SE2mMCgyZNJR16esC
         iU0e12hmq0FTKaguQSnb+rx5ZHXgx9nbVvFQ2y9gexmI4IM34sWyH+vNmCKfdU/ZkCmU
         qC3LqcpnSP/WDK1m5XOE3t5rLj6Ltc76V7/zAMuxGvbt5kgRbY9mMuksszTEE0Kvrf04
         wdXFB25PpOXCs1cZ1ckK9fdJMARpfMGZLPqkGPhlulFmym8WVHAZ5YZYO/szcT4ZLyPM
         +RtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:from:to:subject:references:in-reply-to:content-transfer-encoding
         :mime-version:date:message-id:arc-authentication-results;
        bh=pEMtghUtMYeRqBNIkN41KSKVtgVmKUaqTlDcggz/SSo=;
        b=LYUHUqKR+b9jEjlfN2lhTRN/PHGL/xQzEn7p7hipF/sGNQqIeK5ckpQ6GGL9TBJa8e
         Jj7GwiuDYF4X70McoQCw0SX9H+II4V8mqE+R/+Xyjz864B2bvyII/bXp7EkvrLaN9E10
         clKRlH6ATH0+iBLu/pBdbrXajidYCD4Zbwo9pKQiDJMRfQxunfadN9CI20YZ5zmVycRT
         6k7BTgxhGRxj2gSf8rl3Y7B+S1yaojrzsNan/+q8cAIeJorwk08QWFAOZHYY8O/6OkXC
         ISQjGdegQUTQ/zVw4QGEpRAELHJERTBK1CYFgM1+QBrS8gAY0zlcBVbln71nZB7YO8oz
         Awzw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of bot@kernelci.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=bot@kernelci.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of bot@kernelci.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=bot@kernelci.org
X-Google-Smtp-Source: AIpwx48ZBEVo989HlSzpu8/c1KSP1FJT/A94vCkWw5WLjXeaVUoC/2EPxfBTrsqIGYZ4yXFX9YUfmg==
Message-ID: <5abae002.12ed1c0a.739b4.cbfe@mx.google.com>
Date: Tue, 27 Mar 2018 17:21:22 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.4.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: boot
X-Kernelci-Kernel: v4.4.124-44-g9d0ab5d17182
In-Reply-To: <20180327162716.407986916@linuxfoundation.org>
References: <20180327162716.407986916@linuxfoundation.org>
Subject: Re: [PATCH 4.4 00/43] 4.4.125-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org
From: kernelci.org bot <bot@kernelci.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net,
 shuahkh@osg.samsung.com, patches@kernelci.org, ben.hutchings@codethink.co.uk,
 lkft-triage@lists.linaro.org, stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596108971471558440?=
X-GMAIL-MSGID: =?utf-8?q?1596138700488438021?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

stable-rc/linux-4.4.y boot: 98 boots: 2 failed, 37 passed with 56 offline, =
3 untried/unknown (v4.4.124-44-g9d0ab5d17182)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.4.y/kernel/v4.4.124-44-g9d0ab5d17182/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.4.y=
/kernel/v4.4.124-44-g9d0ab5d17182/

Tree: stable-rc
Branch: linux-4.4.y
Git Describe: v4.4.124-44-g9d0ab5d17182
Git Commit: 9d0ab5d17182f9bbe3a4c1d8412f387302bc82d0
Git URL: http://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git
Tested: 51 unique boards, 20 SoC families, 15 builds out of 174

Boot Regressions Detected:

arm:

    at91_dt_defconfig:
        at91sam9261ek:
            lab-free-electrons: failing since 5 days (last pass: v4.4.123 -=
 first fail: v4.4.123-97-g3054df73e9af)

    sama5_defconfig:
        sama5d36ek:
            lab-free-electrons: new failure (last pass: v4.4.124)

Boot Failures Detected:

arm:

    sama5_defconfig
        sama5d36ek: 1 failed lab

    at91_dt_defconfig
        at91sam9261ek: 1 failed lab

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
        bcm4708-smartrg-sr400ac: 1 offline lab
        bcm72521-bcm97252sffe: 1 offline lab
        bcm7445-bcm97445c: 1 offline lab
        exynos5250-arndale: 1 offline lab
        exynos5410-odroidxu: 1 offline lab
        exynos5420-arndale-octa: 1 offline lab
        exynos5422-odroidxu3: 1 offline lab
        exynos5800-peach-pi: 1 offline lab
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
        dm365evm,legacy: 1 offline lab

    mvebu_v7_defconfig:
        armada-xp-openblocks-ax3-4: 1 offline lab

---
For more info write to <info@kernelci.org>
