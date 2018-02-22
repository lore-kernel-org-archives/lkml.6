Return-Path: <bot@kernelci.org>
ARC-Seal: i=1; a=rsa-sha256; t=1519269455; cv=none;
        d=google.com; s=arc-20160816;
        b=GQrM83RbYEM43QXQxgFM55LlPyMLNQhcWyeGsm8CKBiV5NOVKmrjgfy7IJF3VBqUk/
         UYRUU1Z//dh8zBp07Qu+Wk3hdd8RD3Ti8y3YCMxGE382Im7UJ5Sjb6TgPMxwe/bPncVh
         cULeXDsCA/GaVyMCNOnDkx7/ADs518TpwPUAtqrK2N6AM5unMXbgPKwAlfgAnkP4OMu9
         k44d6yqMcm/T/cHzuUQfFiUSnqYhA70UOHPTZMJDtT/cfipoT36m97eC3wdlU/rIo8Og
         qiArXtHfiTRZPzwnIVgc53GI+yhYPufacqFNXdJvonF34eI8C4qu0bXxaG+KJbtGjxAS
         4g1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:from:to:subject:references:in-reply-to:content-transfer-encoding
         :mime-version:date:message-id:arc-authentication-results;
        bh=LWV/P5E+MqROrWAKATmAmyKRLkFr68HcTGbPCju11NM=;
        b=K5b8ZBydnH9OUnOf0PvHpLLH1LtcYJXZ9k+J1y1h0yOuN6Av1KoFPFsatu1mM3C3W6
         AZXztME0551pMOZHWReRk4V5d/D0XE6klSW0yvC6mcP0UHfLXJ7dfCI8nEeClXWUslTq
         IEbpasp8OiW1TiG5UNuVG1zEsXNyQJwZAcNdX7NCfSk1MCKie4v9mSQuT3xEBbuZQ78Z
         nbFroXYQh4RYitXiEiurfTCC8TonI9aCC0UwVOPPxG/2pK2RG26o9tYcHjtM1yqMsMeB
         EAJ00eVyCAB1zkjhMatyP9ftnNpIUOT00Yehs9y6sW/aZ65pTOlI0nMXoqfwRWnrMHTM
         JIvw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of bot@kernelci.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=bot@kernelci.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of bot@kernelci.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=bot@kernelci.org
X-Google-Smtp-Source: AH8x225hZz9I8Nn+I9qWI8nD1hZXvrdoJwkHu5hHdrmR6P4k50LSaYCnHdKe+IawVr4rdDSizAnRCQ==
Message-ID: <5a8e364d.8cbbdf0a.84e98.90d6@mx.google.com>
Date: Wed, 21 Feb 2018 19:17:33 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.14.y
X-Kernelci-Kernel: v4.14.20-168-g20a80dd2bbb0
X-Kernelci-Report-Type: boot
X-Kernelci-Tree: stable-rc
In-Reply-To: <20180221124524.639039577@linuxfoundation.org>
References: <20180221124524.639039577@linuxfoundation.org>
Subject: Re: [PATCH 4.14 000/167] 4.14.21-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org
From: kernelci.org bot <bot@kernelci.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net,
 shuahkh@osg.samsung.com, patches@kernelci.org, ben.hutchings@codethink.co.uk,
 lkft-triage@lists.linaro.org, stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593015490826174383?=
X-GMAIL-MSGID: =?utf-8?q?1593069488082363990?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

stable-rc/linux-4.14.y boot: 80 boots: 1 failed, 63 passed with 16 offline =
(v4.14.20-168-g20a80dd2bbb0)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.14.y/kernel/v4.14.20-168-g20a80dd2bbb0/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.14.=
y/kernel/v4.14.20-168-g20a80dd2bbb0/

Tree: stable-rc
Branch: linux-4.14.y
Git Describe: v4.14.20-168-g20a80dd2bbb0
Git Commit: 20a80dd2bbb095f1b2ae2e72143f12ff8b605382
Git URL: http://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git
Tested: 51 unique boards, 21 SoC families, 14 builds out of 184

Boot Regressions Detected:

arm64:

    defconfig:
        meson-gxbb-p200:
            lab-baylibre-seattle: failing since 4 days (last pass: v4.14.19=
-197-gff1db24d7bfc - first fail: v4.14.20)

Boot Failure Detected:

arm64:

    defconfig
        meson-gxbb-p200: 1 failed lab

Offline Platforms:

arm:

    exynos_defconfig:
        exynos5410-odroidxu: 1 offline lab
        exynos5422-odroidxu3: 1 offline lab

    multi_v7_defconfig:
        alpine-db: 1 offline lab
        am335x-boneblack: 1 offline lab
        at91-sama5d4_xplained: 1 offline lab
        exynos5410-odroidxu: 1 offline lab
        exynos5422-odroidxu3: 1 offline lab
        socfpga_cyclone5_de0_sockit: 1 offline lab
        tegra124-jetson-tk1: 1 offline lab

    sama5_defconfig:
        at91-sama5d4_xplained: 1 offline lab

    tegra_defconfig:
        tegra124-jetson-tk1: 1 offline lab

    bcm2835_defconfig:
        bcm2835-rpi-b: 1 offline lab

    omap2plus_defconfig:
        am335x-boneblack: 1 offline lab

arm64:

    defconfig:
        apq8016-sbc: 1 offline lab
        juno-r2: 1 offline lab
        meson-gxbb-odroidc2: 1 offline lab

---
For more info write to <info@kernelci.org>
