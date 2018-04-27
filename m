Return-Path: <bot@kernelci.org>
ARC-Seal: i=1; a=rsa-sha256; t=1524858241; cv=none;
        d=google.com; s=arc-20160816;
        b=nDp6yjO6nQiVt+aPD+TpMeoAIVwxfoNYspCjS5a3WhUw1/oTJkExwjUAi6/l1o9HNn
         csKjdiLGrLTezi6zo/Ykwchz0ttf/4heQSZKaIljaYZRZ5izR37ZwB7sfnVraSz3xm+8
         KnH4CzOnDYGEfmU9KU4f4JWqmVuy7ld5hkH+iKf2GnG19gdYBI+QiWwJ1d/2PeV17mhs
         xjt9XaueN9pcfBwjooP734s7fztAmsiNjOF79n0sv1R4L8SYGIP6zRYJkkcv7rifIi1G
         LgsRF+D5ArpM1Z6ERInX6K48ZhFir0qvFcRuk16lXC/YykCL6gBen+CSnDSgSC3kWPsa
         wnOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:from:to:subject:references:in-reply-to:content-transfer-encoding
         :mime-version:date:message-id:arc-authentication-results;
        bh=DlPohf3NFTEJUqj99SqUWKyRr4gd4Xs1C6LgZ9z1Lbc=;
        b=RisR0dHQXILKPgx6RFISighnIdVTZRjYtni0IDyRj50HQjtqAtJHjWdwEhxJdo7/M3
         lfz+a4WW9pRis5QRcwCzEWMpIoNZnZJ+PtmmZUvgPYhKLcHYg4euWVHHijbIBoFUFSSv
         /f+e4NG7CsgDEqFxQZC8z0JJKVawjspRWqrlryIdwSsvQrawKa1Yqg0JW7bQ3ZhhqAbx
         tc3spdMO8XQdrhOmqklJvHgRbhtrgtoNod/l6plbbtN4kNElMZIzYLvHa0fZigj6BXlU
         aVxgUg9Rz/C6FEgjgUXqCNvlsfOG+DXPdOy6mYCGefdaj4zMIXQmxGyQZArbNIcFE4Lo
         xmiQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of bot@kernelci.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=bot@kernelci.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of bot@kernelci.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=bot@kernelci.org
X-Google-Smtp-Source: AB8JxZqIxWHPYoqgA1CIoJ1PoNmYQpzLDlUCiXZwFdO//1KXgO2zkQpDQ/r3lAqv56h8WDtWJSpBjA==
Message-ID: <5ae37d7f.1c69fb81.3f68c.c77f@mx.google.com>
Date: Fri, 27 Apr 2018 12:43:59 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.4.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: boot
X-Kernelci-Kernel: v4.4.129-51-gaedfcc63a1a9
In-Reply-To: <20180427135655.623669681@linuxfoundation.org>
References: <20180427135655.623669681@linuxfoundation.org>
Subject: Re: [PATCH 4.4 00/50] 4.4.130-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org
From: kernelci.org bot <bot@kernelci.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net,
 shuah@kernel.org, patches@kernelci.org, ben.hutchings@codethink.co.uk,
 lkft-triage@lists.linaro.org, stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598908162748669149?=
X-GMAIL-MSGID: =?utf-8?q?1598929755410492767?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

stable-rc/linux-4.4.y boot: 119 boots: 0 failed, 64 passed with 53 offline,=
 2 untried/unknown (v4.4.129-51-gaedfcc63a1a9)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.4.y/kernel/v4.4.129-51-gaedfcc63a1a9/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.4.y=
/kernel/v4.4.129-51-gaedfcc63a1a9/

Tree: stable-rc
Branch: linux-4.4.y
Git Describe: v4.4.129-51-gaedfcc63a1a9
Git Commit: aedfcc63a1a9aca5a263e7733131589117195778
Git URL: http://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git
Tested: 57 unique boards, 21 SoC families, 16 builds out of 177

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
        bcm4708-smartrg-sr400ac: 1 offline lab
        bcm72521-bcm97252sffe: 1 offline lab
        bcm7445-bcm97445c: 1 offline lab
        exynos5250-arndale: 1 offline lab
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

arm64:

    defconfig:
        apq8016-sbc: 1 offline lab

---
For more info write to <info@kernelci.org>
