Return-Path: <bot@kernelci.org>
ARC-Seal: i=1; a=rsa-sha256; t=1519430266; cv=none;
        d=google.com; s=arc-20160816;
        b=EgGRxGhJQEqgXyLwT9+2sX7GKPWgbL6pZjRWRjtLYndvtCOC6O5hqFUHuuWAdBqC17
         HTG1X+fnlXBP1tkrAMvtE+2gNslKfoIYEPkh9Qv7xX9IR0hGv1o/7K0f0sjECHti4PUJ
         R9AILfVSzRIk9jW4KkXVfH4T3YGHBnaEX0gdAfKyN26Wslmv0Pt4R/ZDsT86nH/aG2R/
         0dQ7VXNHJIbmCw0o2CbIGdMKnVoLIdGVvaUFR/FZlI322oqtAd12tIu0aK1kjAUrlp3D
         YQaLX6UDaNYKy5q3JMONRpdYNu01WkIi9PTrHiibSMv8JuXXjmuMXKVBkvhzerihTJB9
         SP+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:from:to:subject:references:in-reply-to:content-transfer-encoding
         :mime-version:date:message-id:arc-authentication-results;
        bh=pNBBkgW3QdJlxV8TfPylAk9Kw/8A/hwxd4f7O+KMfcY=;
        b=rBt4nfKD+4zL/NAjP3oAktwN0jpVp1ypvyb2C0pajU6TiZPZaFgpPtsvt1iNxNHnPZ
         E6pri5E7K3x/ak9tkx9Ijxz9Pc0NCTOkMg4XoA0h/TPgqtQrgQsbsRhRm0RisYwO3KU2
         NxPpSFOiAMqOOJJ6hR3gnR6FOmHaQXmVa4rUJSmhR2zirS55nsj8O81YWm0VrCFPVh14
         Za+ZRLVUc250uq5tGu4sBJ0LLuSKUiNjpGSk0ilUC8oyeD3HwNbGxpS3BUn1QlhoCw0Z
         cJmd6YvkgEK7P4VUMi8uYKAG1pFLdmA3Jqpkc6q+XEpP34tANWMC1L72Rm/9FVJkqjrb
         Ioiw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of bot@kernelci.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=bot@kernelci.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of bot@kernelci.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=bot@kernelci.org
X-Google-Smtp-Source: AH8x225Tq76UJ26BYKZJINAVYr/lvfu/V6qwgpVbA0Gnyiu9fX1vLYcrAKbgL05kd0A5NCw/c/kEpQ==
Message-ID: <5a90aa79.c99adf0a.c5210.8111@mx.google.com>
Date: Fri, 23 Feb 2018 15:57:45 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.14.y
X-Kernelci-Kernel: v4.14.21-160-g61e5ffb08842
X-Kernelci-Report-Type: boot
X-Kernelci-Tree: stable-rc
In-Reply-To: <20180223170743.086611315@linuxfoundation.org>
References: <20180223170743.086611315@linuxfoundation.org>
Subject: Re: [PATCH 4.14 000/159] 4.14.22-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org
From: kernelci.org bot <bot@kernelci.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net,
 shuahkh@osg.samsung.com, patches@kernelci.org, ben.hutchings@codethink.co.uk,
 lkft-triage@lists.linaro.org, stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593218804991705252?=
X-GMAIL-MSGID: =?utf-8?q?1593238111388371889?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

stable-rc/linux-4.14.y boot: 105 boots: 1 failed, 87 passed with 17 offline=
 (v4.14.21-160-g61e5ffb08842)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.14.y/kernel/v4.14.21-160-g61e5ffb08842/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.14.=
y/kernel/v4.14.21-160-g61e5ffb08842/

Tree: stable-rc
Branch: linux-4.14.y
Git Describe: v4.14.21-160-g61e5ffb08842
Git Commit: 61e5ffb08842d3b466d2a321bc8d199c7e768892
Git URL: http://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git
Tested: 58 unique boards, 22 SoC families, 15 builds out of 185

Boot Regressions Detected:

arm64:

    defconfig:
        meson-gxbb-p200:
            lab-baylibre-seattle: failing since 6 days (last pass: v4.14.19=
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
        meson-gxl-s905d-p230: 1 offline lab

---
For more info write to <info@kernelci.org>
