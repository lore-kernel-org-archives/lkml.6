Return-Path: <bot@kernelci.org>
ARC-Seal: i=1; a=rsa-sha256; t=1524855841; cv=none;
        d=google.com; s=arc-20160816;
        b=UBWwtWmjHl/ZRvj/xex3bBnSPcy/eKpYsjtN/bj3ocZOl1iM7ubzgfBLPTmidJoKfq
         5OKGLOjUwOTzZd+nqMOq9SRty4tYq53n3bnjmPs3RvY6iZflrGrWjNR3CadOYDhlaeVB
         Wx96VMBqbg6GMLsfUAy1EiLXF/rR2pF9rnKaqVWhUtoMupGu2oPQyI04ht4jQRin/TbA
         LtoQk5fWdhumYtAEnq91FVYcw0kG8vnYDCPDj7x9qSE67F0FhevvgjarV/nLPPubwcOu
         dr4SyLVr3l5fmcXfa3ugakM6yMeG6w7KUqLVXbFJQdB4BpoFS6u0ZQIR1CSFsfuuR0AV
         BR0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:from:to:subject:references:in-reply-to:content-transfer-encoding
         :mime-version:date:message-id:arc-authentication-results;
        bh=0G22bBdmn5fI31sKzR2o8v4KZQTy1pEwqD02SCkvNm0=;
        b=ysUVzipzjFRP8xBAq0YZAryb7Xb3KipQFIVZbNniOpJUkZvc4AZe4GNm2+pnxyi0pJ
         TKvGynZYztcC9aYDMg6WSfABb+8BrbFyA3fXtKfzhJ3xvW2GM5x8SVoBTQQzmSUqKAzw
         kafm+CmXVvRdX+Zoq51J2h8Q4zosyOA79tRX/jtMi/lcqAeup0yxJy4Y5o3Gdt8ELI5y
         iGWARZh8BomZUNvFP3+xlcP4F1qNzSuaZyf2oJXA2C641XV+lahA1pEktq/KPgxzzBVK
         HEg02BTCcL4IQaOGmMxcGqF7kzRj6WT7p1SDAbQLxuCcA/KygMfOHhxloeFzNp7TX/df
         vr6g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of bot@kernelci.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=bot@kernelci.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of bot@kernelci.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=bot@kernelci.org
X-Google-Smtp-Source: AB8JxZpog/03b9Gx1K93XbTV5L+pYL9ziw2Bep/tmOI+pOf6ae47TRXDu6JqNpV4j8wryBHgruS3Vg==
Message-ID: <5ae3741f.05921c0a.31f2d.1d52@mx.google.com>
Date: Fri, 27 Apr 2018 12:03:59 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-3.18.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: boot
X-Kernelci-Kernel: v3.18.106-25-ga63769905de2
In-Reply-To: <20180427135631.584839868@linuxfoundation.org>
References: <20180427135631.584839868@linuxfoundation.org>
Subject: Re: [PATCH 3.18 00/24] 3.18.107-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org
From: kernelci.org bot <bot@kernelci.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net,
 shuah@kernel.org, patches@kernelci.org, ben.hutchings@codethink.co.uk,
 lkft-triage@lists.linaro.org, stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598907995162115578?=
X-GMAIL-MSGID: =?utf-8?q?1598927238186124888?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

stable-rc/linux-3.18.y boot: 68 boots: 0 failed, 34 passed with 34 offline =
(v3.18.106-25-ga63769905de2)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-3.18.y/kernel/v3.18.106-25-ga63769905de2/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-3.18.=
y/kernel/v3.18.106-25-ga63769905de2/

Tree: stable-rc
Branch: linux-3.18.y
Git Describe: v3.18.106-25-ga63769905de2
Git Commit: a63769905de2150eb48d9b60a851ce6b24079f91
Git URL: http://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git
Tested: 33 unique boards, 12 SoC families, 15 builds out of 166

Offline Platforms:

arm:

    sunxi_defconfig:
        sun4i-a10-cubieboard: 1 offline lab
        sun7i-a20-cubietruck: 1 offline lab

    bcm2835_defconfig:
        bcm2835-rpi-b: 1 offline lab

    sama5_defconfig:
        at91-sama5d4ek: 1 offline lab

    multi_v7_defconfig:
        am335x-boneblack: 1 offline lab
        armada-xp-openblocks-ax3-4: 1 offline lab
        exynos5420-arndale-octa: 1 offline lab
        exynos5800-peach-pi: 1 offline lab
        imx6dl-wandboard_dual: 1 offline lab
        imx6dl-wandboard_solo: 1 offline lab
        omap3-beagle: 1 offline lab
        omap3-beagle-xm: 1 offline lab
        omap4-panda: 1 offline lab
        sun4i-a10-cubieboard: 1 offline lab
        sun7i-a20-cubietruck: 1 offline lab
        tegra124-jetson-tk1: 1 offline lab
        tegra20-iris-512: 1 offline lab
        tegra30-beaver: 1 offline lab
        zynq-zc702: 1 offline lab

    tegra_defconfig:
        tegra124-jetson-tk1: 1 offline lab
        tegra20-iris-512: 1 offline lab
        tegra30-beaver: 1 offline lab

    imx_v6_v7_defconfig:
        imx6dl-wandboard_dual: 1 offline lab
        imx6dl-wandboard_solo: 1 offline lab

    exynos_defconfig:
        exynos5420-arndale-octa: 1 offline lab
        exynos5800-peach-pi: 1 offline lab

    omap2plus_defconfig:
        am335x-boneblack: 1 offline lab
        omap3-beagle: 1 offline lab
        omap3-beagle,legacy: 1 offline lab
        omap3-beagle-xm: 1 offline lab
        omap3-beagle-xm,legacy: 1 offline lab
        omap4-panda: 1 offline lab

    davinci_all_defconfig:
        dm365evm,legacy: 1 offline lab

    mvebu_v7_defconfig:
        armada-xp-openblocks-ax3-4: 1 offline lab

---
For more info write to <info@kernelci.org>
