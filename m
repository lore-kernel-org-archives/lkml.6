Return-Path: <bot@kernelci.org>
ARC-Seal: i=1; a=rsa-sha256; t=1520974815; cv=none;
        d=google.com; s=arc-20160816;
        b=l1GHwy0ugXbB1UhaB0jrHYjrkqGTVg0r0FWemn1iXvB8agDYvyb0s3BboBQFMaNP2f
         hhiDnUr3DK/Uoih9PNvUzvvUdoMvaRengK/1jPirzRGjpM4R4TzwUrSOVppFpVIKoi/1
         jU0XbNg0LPsFF4//g1+pwUVbNUCf4vPjQZhVc7st5dJt9/ZxQ0R4B3xG5XhTdYHZW3pH
         VFhTGtIlJEFE1Su3s893DYNiG9MGeHr8Y3kgoQG1Jj/oLZZ3yVmjf7I2/UBBfnb6/sqN
         IIpLtKUB7Px8eqs/6YmDA0573JgOJbHhAIbmAjfiOjcoBWeSZUdu4zzc7A444Ulq+GV1
         q4iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:from:to:subject:references:in-reply-to:content-transfer-encoding
         :mime-version:date:message-id:arc-authentication-results;
        bh=JDJTtzcoRNEvliJ/DjvgIIip8G/Jp1zdHEdCN2F23XY=;
        b=aUQ48xMECIws/4bjKwnpk/bJlu4/g56ipOYAnYtw4Z/GdwZ9e7ND6+yuXZvRVUEOHs
         292l0o20nfHrJ9wUBP84ROvTACPCFuNpxHaoJX+lAEONG4pE+i0Fj5KlZag7mCv8VDFI
         52tRBgfKbmhH0ckmw78dW5S4rveK7lRVWKKUP0PQSZcF89elY+76QXKBnwgriiW4LnAq
         AiP51bfN2FMpskppcBD0AVFlHdWMop+TGlm8jKYqBHVaqdz4HEskLijCg/UFu+wbz+uw
         xaDXVK9qbSsjhHJUIomAzvp7Q4G/YIpgj23yupWh8wZ63evrCpvz+p4aX5KMQTzjQRBU
         JOVg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of bot@kernelci.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=bot@kernelci.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of bot@kernelci.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=bot@kernelci.org
X-Google-Smtp-Source: AG47ELuwsAwnMW+U0jFahSzx90q/ow19E4yNRFSstMMmNoEGgXDo7qAZEgGTltPCHLLQ1mcIJ2HSbg==
Message-ID: <5aa83bdd.12691c0a.bd45d.96f5@mx.google.com>
Date: Tue, 13 Mar 2018 14:00:13 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.14.y
X-Kernelci-Kernel: v4.14.26-141-g7ba3c4cdde59
X-Kernelci-Report-Type: boot
X-Kernelci-Tree: stable-rc
In-Reply-To: <20180313152458.201155692@linuxfoundation.org>
References: <20180313152458.201155692@linuxfoundation.org>
Subject: Re: [PATCH 4.14 000/140] 4.14.27-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org
From: kernelci.org bot <bot@kernelci.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net,
 shuahkh@osg.samsung.com, patches@kernelci.org, ben.hutchings@codethink.co.uk,
 lkft-triage@lists.linaro.org, stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594837222777113471?=
X-GMAIL-MSGID: =?utf-8?q?1594857687975407745?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

stable-rc/linux-4.14.y boot: 144 boots: 7 failed, 113 passed with 21 offlin=
e, 2 untried/unknown, 1 conflict (v4.14.26-141-g7ba3c4cdde59)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.14.y/kernel/v4.14.26-141-g7ba3c4cdde59/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.14.=
y/kernel/v4.14.26-141-g7ba3c4cdde59/

Tree: stable-rc
Branch: linux-4.14.y
Git Describe: v4.14.26-141-g7ba3c4cdde59
Git Commit: 7ba3c4cdde59100ec5cae9f4537ec8bd8709ab59
Git URL: http://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git
Tested: 77 unique boards, 22 SoC families, 17 builds out of 185

Boot Regressions Detected:

arm:

    exynos_defconfig:
        exynos5800-peach-pi:
            lab-baylibre-seattle: failing since 1 day (last pass: v4.14.25-=
10-gcf6424f29452 - first fail: v4.14.26)

    sunxi_defconfig:
        sun5i-gr8-chip-pro:
            lab-free-electrons: new failure (last pass: v4.14.26)

arm64:

    defconfig:
        apq8016-sbc:
            lab-mhart: new failure (last pass: v4.14.26)
        meson-gxbb-p200:
            lab-baylibre-seattle: new failure (last pass: v4.14.25)
        meson-gxl-s905d-p230:
            lab-baylibre-seattle: new failure (last pass: v4.14.26)
        meson-gxl-s905x-khadas-vim:
            lab-baylibre: new failure (last pass: v4.14.26)
            lab-baylibre-seattle: new failure (last pass: v4.14.25)
        meson-gxl-s905x-p212:
            lab-baylibre-seattle: new failure (last pass: v4.14.26)

Boot Failures Detected:

arm:

    sunxi_defconfig
        sun5i-gr8-chip-pro: 1 failed lab

arm64:

    defconfig
        apq8016-sbc: 1 failed lab
        meson-gxbb-p200: 1 failed lab
        meson-gxl-s905d-p230: 1 failed lab
        meson-gxl-s905x-khadas-vim: 2 failed labs
        meson-gxl-s905x-p212: 1 failed lab

Offline Platforms:

arm:

    tegra_defconfig:
        tegra124-jetson-tk1: 1 offline lab

    multi_v7_defconfig:
        alpine-db: 1 offline lab
        am335x-boneblack: 1 offline lab
        at91-sama5d4_xplained: 1 offline lab
        exynos5410-odroidxu: 1 offline lab
        meson8b-odroidc1: 1 offline lab
        socfpga_cyclone5_de0_sockit: 1 offline lab
        sun5i-r8-chip: 1 offline lab
        tegra124-jetson-tk1: 1 offline lab
        vf610-colibri-eval-v3: 1 offline lab

    sunxi_defconfig:
        sun5i-r8-chip: 1 offline lab

    imx_v6_v7_defconfig:
        vf610-colibri-eval-v3: 1 offline lab

    sama5_defconfig:
        at91-sama5d4_xplained: 1 offline lab

    exynos_defconfig:
        exynos5410-odroidxu: 1 offline lab

    bcm2835_defconfig:
        bcm2835-rpi-b: 1 offline lab

    omap2plus_defconfig:
        am335x-boneblack: 1 offline lab

arm64:

    defconfig:
        apq8016-sbc: 1 offline lab
        juno-r2: 1 offline lab
        meson-gxbb-odroidc2: 1 offline lab
        meson-gxl-s905x-nexbox-a95x: 1 offline lab
        mt7622-rfb1: 1 offline lab

Conflicting Boot Failure Detected: (These likely are not failures as other =
labs are reporting PASS. Needs review.)

arm:

    exynos_defconfig:
        exynos5800-peach-pi:
            lab-collabora: PASS
            lab-baylibre-seattle: FAIL

---
For more info write to <info@kernelci.org>
