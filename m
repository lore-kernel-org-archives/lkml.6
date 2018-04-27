Return-Path: <bot@kernelci.org>
ARC-Seal: i=1; a=rsa-sha256; t=1524857041; cv=none;
        d=google.com; s=arc-20160816;
        b=WheL24lIB2P4g0xz0aMiYjv71TjWJhQWcPbDACuBO9lrW2U3mtSlh4p1goTfKSO6SA
         56mjZXKMnxlM6NBLunTEkrnNg+EZ/ajxKUyvPgl4X6/TgCJgeQqLIeTu0CcELwlCF+e9
         /BpiRLRzi8WDQcC3iwDLgIMXbahbl4AnT5FWD8zChr4G7uX8+B4QAWbMTqJEbt/BWZZw
         pIK3B4dxQIxWrmXa/WM3/qiYQKNAQZ9dlqqsg/szcbusMLkzxTv13aZceEOvrsRuHbvK
         ameGYLexhUojqFlLjhj992Pl//3qNkm/+7rZGeXQgWlA9eSPyYYdRh5/5Yq8IXy49NuS
         Amzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:from:to:subject:references:in-reply-to:content-transfer-encoding
         :mime-version:date:message-id:arc-authentication-results;
        bh=3HbJuV2v8HZ7/vubYc2O4F/xHtdQ2NXwB2C36coUzgY=;
        b=bfqWIJSD0kljYA35LysoJ6kF/tCL6H+bO/56BLIHkLLcnmoK4gbX3K+5Iu0zuezxqT
         IULeBcikYiRV1tEJS6SSLiBi1kRUiIKTOEf03QIHlF9bDytQuR5EtiusU1wg4M/eLUET
         WbpGwjV1mH7n4YUn4ZKr8WpF9xYZnt/YCnBU9CCB29oLThmLqADMeDhjlMuXEVhj66kd
         Vqa65UDu/SO8Y+4eV6ZDEmo+t6pq46FDFSP3PNcYgXD6TO9xxbbcF0h2vm2v7ij745+3
         svpEb6CxiZZci4ye8zmhHjRsz6WJKFXboyCjhFmHsAG1LKz11QpkA+8UMsYnqFruss0T
         ggHg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of bot@kernelci.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=bot@kernelci.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of bot@kernelci.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=bot@kernelci.org
X-Google-Smtp-Source: AB8JxZotn+w4NjUPoG0HWrR7INauY8hKPAAglHxIH7UWoMcczxyCImcKXRnKi2fE7wO/drPW1v0PTQ==
Message-ID: <5ae378d0.1c69fb81.1a8ab.e51d@mx.google.com>
Date: Fri, 27 Apr 2018 12:24:00 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.14.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: boot
X-Kernelci-Kernel: v4.14.37-81-ga0fef4b4352d
In-Reply-To: <20180427135732.928644313@linuxfoundation.org>
References: <20180427135732.928644313@linuxfoundation.org>
Subject: Re: [PATCH 4.14 00/80] 4.14.38-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org
From: kernelci.org bot <bot@kernelci.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net,
 shuah@kernel.org, patches@kernelci.org, ben.hutchings@codethink.co.uk,
 lkft-triage@lists.linaro.org, stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598908582132357459?=
X-GMAIL-MSGID: =?utf-8?q?1598928497087826388?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

stable-rc/linux-4.14.y boot: 153 boots: 2 failed, 88 passed with 61 offline=
, 1 untried/unknown, 1 conflict (v4.14.37-81-ga0fef4b4352d)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.14.y/kernel/v4.14.37-81-ga0fef4b4352d/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.14.=
y/kernel/v4.14.37-81-ga0fef4b4352d/

Tree: stable-rc
Branch: linux-4.14.y
Git Describe: v4.14.37-81-ga0fef4b4352d
Git Commit: a0fef4b4352d42e1d747f8c9dc2af45ea0b6b977
Git URL: http://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git
Tested: 79 unique boards, 24 SoC families, 17 builds out of 185

Boot Regressions Detected:

arm:

    bcm2835_defconfig:
        bcm2837-rpi-3-b:
            lab-baylibre: new failure (last pass: v4.14.37)

arm64:

    defconfig:
        bcm2837-rpi-3-b:
            lab-baylibre: new failure (last pass: v4.14.37)
        meson-gxl-s905x-khadas-vim:
            lab-baylibre: failing since 2 days (last pass: v4.14.26-140-g2a=
1700a4929f - first fail: v4.14.36-184-g3cd53e436ee2)

Boot Failures Detected:

arm:

    bcm2835_defconfig
        bcm2837-rpi-3-b: 1 failed lab

arm64:

    defconfig
        meson-gxl-s905x-khadas-vim: 1 failed lab

Offline Platforms:

arm:

    sunxi_defconfig:
        sun4i-a10-cubieboard: 1 offline lab
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
        exynos5420-arndale-octa: 1 offline lab
        exynos5422-odroidxu3: 1 offline lab
        exynos5800-peach-pi: 1 offline lab
        imx6dl-wandboard_dual: 1 offline lab
        imx7s-warp: 1 offline lab
        meson8b-odroidc1: 1 offline lab
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

Conflicting Boot Failure Detected: (These likely are not failures as other =
labs are reporting PASS. Needs review.)

arm64:

    defconfig:
        bcm2837-rpi-3-b:
            lab-mhart: PASS
            lab-baylibre: FAIL

---
For more info write to <info@kernelci.org>
