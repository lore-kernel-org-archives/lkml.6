Return-Path: <bot@kernelci.org>
ARC-Seal: i=1; a=rsa-sha256; t=1520661577; cv=none;
        d=google.com; s=arc-20160816;
        b=RSwtcswWiFY66YuRu04UoTAh5hYW9ZWow2HZO2so1pTaIRkfxTDJdIK/QN4TFFhYeS
         92V+ZmLyrYI1LbsmAKu5cn272tOiEcULA5h2v+N3KoTjRX8ba1fQ6WisIkSI5LAarnEQ
         CvzeYOhkvw3v+4/UkZC0w8uKfL3BV2krTUp8+DN4QUJ7NXXY7D9Xqj5mSyUl1wtSBzaH
         rbR99chN56paVQlrAnoLhiC4HvBXPvbpNP8SKBJigmIzdBrgddKP/RcCNC5gFZLmsIAn
         ox0iT337uPSGupPm722yiwWAZ+2/oU9SELQ5uGNggCAsW7uqQsb32Ys0DcJy7SHRvCU4
         R98w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:from:to:subject:references:in-reply-to:content-transfer-encoding
         :mime-version:date:message-id:arc-authentication-results;
        bh=iSWbX0XsJOjZObkkCk6gDADox9GyreoZVgUZ3QvdOfY=;
        b=BVGkytLReGshcAL/y1ERc+wWODksV8s/cMGWZU5vISvtjuKfp8zOjpltohBh7IaqLm
         DHDiFJmitVCUgHlIhSjSbcNJO7utSZq5/yeoRNAP+LG0ZNBkBEufNpXX97xd80ce+Mm0
         yKfA0xIlM8q2GYAY7zHmuyWJ46I3J84oxvkZvxdhfFZ5Mkk1udojRqVPJdUOJ54gjH6r
         vDskTvWRer7tuVmeoEByGnRNkJb6zLFwtOatR0Pyx2FVnMYhsHR6CV+H9SRiS7IdWN85
         6PrzFVgcR6ybRwTijcbq5d04RT6Z9jF/u75kjX2tXZJ9W4+GNV2DuRZOciRhILKunPaq
         R2xA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of bot@kernelci.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=bot@kernelci.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of bot@kernelci.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=bot@kernelci.org
X-Google-Smtp-Source: AG47ELsMI5XBI+vd4+IeL6VEucaAjGzlYZjP6NWnISE6Z4MYPLXCyuWHirxv2QSg0rxNwqFYL2mURg==
Message-ID: <5aa37448.81b1500a.dfe47.84df@mx.google.com>
Date: Fri, 09 Mar 2018 21:59:36 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.15.y
X-Kernelci-Kernel: v4.15.8-12-g212dd4bb587d
X-Kernelci-Report-Type: boot
X-Kernelci-Tree: stable-rc
In-Reply-To: <20180310001834.560857664@linuxfoundation.org>
References: <20180310001834.560857664@linuxfoundation.org>
Subject: Re: [PATCH 4.15 00/11] 4.15.9-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org
From: kernelci.org bot <bot@kernelci.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net,
 shuahkh@osg.samsung.com, patches@kernelci.org, ben.hutchings@codethink.co.uk,
 lkft-triage@lists.linaro.org, stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594508118629398484?=
X-GMAIL-MSGID: =?utf-8?q?1594529234370588278?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

stable-rc/linux-4.15.y boot: 143 boots: 3 failed, 127 passed with 9 offline=
, 3 untried/unknown, 1 conflict (v4.15.8-12-g212dd4bb587d)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.15.y/kernel/v4.15.8-12-g212dd4bb587d/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.15.=
y/kernel/v4.15.8-12-g212dd4bb587d/

Tree: stable-rc
Branch: linux-4.15.y
Git Describe: v4.15.8-12-g212dd4bb587d
Git Commit: 212dd4bb587d5ad616b41c343f4bdcd5ab99371c
Git URL: http://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git
Tested: 75 unique boards, 23 SoC families, 17 builds out of 185

Boot Regressions Detected:

arm:

    mvebu_v7_defconfig:
        armada-375-db:
            lab-free-electrons: new failure (last pass: v4.15.8)

    sunxi_defconfig:
        sun8i-a83t-allwinner-h8homlet-v2:
            lab-free-electrons: new failure (last pass: v4.15.8)

    tegra_defconfig:
        tegra124-nyan-big:
            lab-collabora: new failure (last pass: v4.15.8)

arm64:

    defconfig:
        meson-gxl-s905x-khadas-vim:
            lab-baylibre-seattle: new failure (last pass: v4.15.8)

Boot Failures Detected:

arm:

    mvebu_v7_defconfig
        armada-375-db: 1 failed lab

    tegra_defconfig
        tegra124-nyan-big: 1 failed lab

    sunxi_defconfig
        sun8i-a83t-allwinner-h8homlet-v2: 1 failed lab

Offline Platforms:

arm:

    multi_v7_defconfig:
        exynos5410-odroidxu: 1 offline lab
        meson8b-odroidc1: 1 offline lab
        vf610-colibri-eval-v3: 1 offline lab

    exynos_defconfig:
        exynos5410-odroidxu: 1 offline lab

    imx_v6_v7_defconfig:
        vf610-colibri-eval-v3: 1 offline lab

arm64:

    defconfig:
        meson-gxbb-odroidc2: 1 offline lab
        meson-gxbb-p200: 1 offline lab
        meson-gxl-s905x-nexbox-a95x: 1 offline lab
        mt7622-rfb1: 1 offline lab

Conflicting Boot Failure Detected: (These likely are not failures as other =
labs are reporting PASS. Needs review.)

arm64:

    defconfig:
        meson-gxl-s905x-khadas-vim:
            lab-baylibre: PASS
            lab-baylibre-seattle: FAIL

---
For more info write to <info@kernelci.org>
