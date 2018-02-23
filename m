Return-Path: <bot@kernelci.org>
ARC-Seal: i=1; a=rsa-sha256; t=1519430266; cv=none;
        d=google.com; s=arc-20160816;
        b=hU2SibM/L/Xz3PudNzRPyEa+K2iUte8XYuAnb/VK0b32v67jj5osghKxvo4admdwlS
         4IC7AGBkeBN0IKIODfL0cfVAd01oxUxcEno0pTPq7kLWmdKLPi2+OOzIrltyrCcmsUfq
         SA0ayDtsKoPtcG1mbCathkRmkXSKbUOmyMM0PpiqBAPTqRT8yZ/iUtw+hnM/y3pOkaEt
         ijNAv2eRF20GWHfZA7psedSDZD5Hni7WagtZke4HMXypdbs5qUvZ7L0KVE/P6QvVc92U
         6P87xBWVaMDDKKR9X6RQMplSEYUYUSBAHtZJB+EILjFj3nK3b+jzL04onoklPJuFV57D
         67Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:from:to:subject:references:in-reply-to:content-transfer-encoding
         :mime-version:date:message-id:arc-authentication-results;
        bh=FwtRQ4h2CocJVH/3nxsguemVikCHfy+xCQZ9RiMs6FY=;
        b=GCCeB7mSKhsVT/5VO1EBlGG2Ab9LKCFZTDw0aODmchbsv5huOiWpCjU0FAKnpRIDn5
         DEAeA0Waur7CWExxqtfNUJFv2vHbq0DPR3lWotzQGo19WYwvlUO4MeTAOg28IoqDZOA6
         TzbrZlWgnp31juWvkk+SjVFPQHSCbSMnU+45s6szDhRMPLFD97GLx2FPJFzy/LCJkS5h
         iXsWAAP6Q6rPwXJ7D2MRVoIsXqQGAWQpXzv8o9u7N0BZ0vC55HjmTQCK/eY/JrJFLPWX
         5DnHr8Nm3f4zI5LtCFTFBOrD2qEz34/GV4J/iRhl8YC9cOjL9QWoXjC42QLOtCKqM2kZ
         GZ2w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of bot@kernelci.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=bot@kernelci.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of bot@kernelci.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=bot@kernelci.org
X-Google-Smtp-Source: AH8x22588n6Cr48wjJsLVuovPnS522ccFhnNwGghmdfJXrLPoBw1oHgnsYj6CT+cS5awoBTVNDhtlw==
Message-ID: <5a90aa79.02a6df0a.b29ea.7168@mx.google.com>
Date: Fri, 23 Feb 2018 15:57:45 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.15.y
X-Kernelci-Kernel: v4.15.5-46-g82ca63fd5c32
X-Kernelci-Report-Type: boot
X-Kernelci-Tree: stable-rc
In-Reply-To: <20180223170715.197760019@linuxfoundation.org>
References: <20180223170715.197760019@linuxfoundation.org>
Subject: Re: [PATCH 4.15 00/45] 4.15.6-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org
From: kernelci.org bot <bot@kernelci.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net,
 shuahkh@osg.samsung.com, patches@kernelci.org, ben.hutchings@codethink.co.uk,
 lkft-triage@lists.linaro.org, stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593219271451312603?=
X-GMAIL-MSGID: =?utf-8?q?1593238111348505877?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

stable-rc/linux-4.15.y boot: 105 boots: 3 failed, 85 passed with 17 offline=
 (v4.15.5-46-g82ca63fd5c32)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.15.y/kernel/v4.15.5-46-g82ca63fd5c32/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.15.=
y/kernel/v4.15.5-46-g82ca63fd5c32/

Tree: stable-rc
Branch: linux-4.15.y
Git Describe: v4.15.5-46-g82ca63fd5c32
Git Commit: 82ca63fd5c3280300c175fd372b9049c196d5676
Git URL: http://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git
Tested: 58 unique boards, 22 SoC families, 15 builds out of 185

Boot Regressions Detected:

arm:

    exynos_defconfig:
        exynos5800-peach-pi:
            lab-collabora: new failure (last pass: v4.15.4)

arm64:

    defconfig:
        meson-gxbb-p200:
            lab-baylibre-seattle: failing since 6 days (last pass: v4.15.3-=
204-g01be67fd216d - first fail: v4.15.4)
        r8a7795-salvator-x:
            lab-baylibre: failing since 1 day (last pass: v4.15.5 - first f=
ail: v4.15.5-42-gf40984b50e73)

Boot Failures Detected:

arm:

    exynos_defconfig
        exynos5800-peach-pi: 1 failed lab

arm64:

    defconfig
        meson-gxbb-p200: 1 failed lab
        r8a7795-salvator-x: 1 failed lab

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
