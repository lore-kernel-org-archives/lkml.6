Return-Path: <bot@kernelci.org>
ARC-Seal: i=1; a=rsa-sha256; t=1526961975; cv=none;
        d=google.com; s=arc-20160816;
        b=cd0U3luQt+bK/QbpqaBvSA8FAbnFvkZV8nEEdl8hMAwuzADXirso8xQ7YR6WyoQJp8
         I/yheJDpVYn46Nil234QsirI92DRUKRbatKzPY+jwxcJEfOSEpOz2nODOTscB/tie3oV
         0x7Y7YqCwsxkIpiQh7ywHhjbS3d4R+mTAlXarFB1EGi5c2+oNjPW46NQnme/8uWoTyCi
         hjwvwuJ1EkSQksOR1zpJ/9IRJ5wNLMU6WnjCkFWMV+6e2Qry4RXgD2e0JpnGCXt/0Eox
         YYBbpEuQzdqhgYdKLjpdfkSE2OpFp4+RA6eM2RalBOkDugeHCiGBucuvkPfb3rGQ8PZt
         4Xfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:from:to:subject:references:in-reply-to:content-transfer-encoding
         :mime-version:date:message-id:arc-authentication-results;
        bh=8jYldZviK7MDh6ZM2BJ0ijEN1dBcLM9X+afUvv9h5zw=;
        b=ejk00cGac7iGvz58jQBHEGCG8lJHVfycLTKaVFw0wiWhnAcKvPMtGhHBuosZATpbVl
         +iCm1VS6b1sz5NNjGpLpcqxs71ObQ49543++VJsSLFJEnBgfp2hzbJVNQ7j4dVVqFo8c
         n4g6O2PRK5Msw9wJTi5BkimtCj1E2EIGrK8tBbgEJmD+1nI+Zqj9ekGIYM3yVteX8rVZ
         c1gvhbhq/Ze1C/ANDOE7XfVRpCtMm2XrjPLLZHi6MarmGtVayqr9LFQdTA0J+XRCwxdX
         FJ2Zp4IAgJN5V0EUGWQ+piEftngH5dmvHwv/59L2Qhv5xGWs/1pLtclG2VWida0A+ORw
         Xayg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of bot@kernelci.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=bot@kernelci.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of bot@kernelci.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=bot@kernelci.org
X-Google-Smtp-Source: AB8JxZoQMfvqUkK6NBcsFF+DrsyO0YfuT7D7hPshFO/vL/K5C1ISBiRVci0n59RV+OL7ML7h1KGsow==
Message-ID: <5b039735.1c69fb81.4225b.6ec0@mx.google.com>
Date: Mon, 21 May 2018 21:06:13 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: stable-rc
X-Kernelci-Branch: linux-4.16.y
X-Kernelci-Report-Type: boot
X-Kernelci-Kernel: v4.16.10-111-g663daea64d0b
In-Reply-To: <20180521210503.823249477@linuxfoundation.org>
References: <20180521210503.823249477@linuxfoundation.org>
Subject: Re: [PATCH 4.16 000/110] 4.16.11-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org
From: kernelci.org bot <bot@kernelci.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net,
 shuah@kernel.org, patches@kernelci.org, ben.hutchings@codethink.co.uk,
 lkft-triage@lists.linaro.org, stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1601110346996533530?=
X-GMAIL-MSGID: =?utf-8?q?1601135680456898230?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

stable-rc/linux-4.16.y boot: 112 boots: 1 failed, 96 passed with 15 offline=
 (v4.16.10-111-g663daea64d0b)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.16.y/kernel/v4.16.10-111-g663daea64d0b/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.16.=
y/kernel/v4.16.10-111-g663daea64d0b/

Tree: stable-rc
Branch: linux-4.16.y
Git Describe: v4.16.10-111-g663daea64d0b
Git Commit: 663daea64d0bbd800ae507d08f35706d169c6883
Git URL: http://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git
Tested: 60 unique boards, 23 SoC families, 15 builds out of 186

Boot Regressions Detected:

arm:

    qcom_defconfig:
        qcom-apq8064-cm-qs600:
            lab-baylibre-seattle: new failure (last pass: v4.16.10-62-g473d=
9b275b2a)

Boot Failure Detected:

arm:

    qcom_defconfig
        qcom-apq8064-cm-qs600: 1 failed lab

Offline Platforms:

arm:

    sama5_defconfig:
        at91-sama5d4_xplained: 1 offline lab

    multi_v7_defconfig:
        alpine-db: 1 offline lab
        armada-xp-openblocks-ax3-4: 1 offline lab
        at91-sama5d4_xplained: 1 offline lab
        socfpga_cyclone5_de0_sockit: 1 offline lab
        tegra124-jetson-tk1: 1 offline lab
        tegra30-beaver: 1 offline lab
        zynq-zc702: 1 offline lab

    tegra_defconfig:
        tegra124-jetson-tk1: 1 offline lab
        tegra30-beaver: 1 offline lab

    mvebu_v7_defconfig:
        armada-xp-openblocks-ax3-4: 1 offline lab

    bcm2835_defconfig:
        bcm2835-rpi-b: 1 offline lab

arm64:

    defconfig:
        apq8016-sbc: 1 offline lab
        juno-r2: 1 offline lab
        mt7622-rfb1: 1 offline lab

---
For more info write to <info@kernelci.org>
