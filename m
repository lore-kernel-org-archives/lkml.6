Return-Path: <bot@kernelci.org>
ARC-Seal: i=1; a=rsa-sha256; t=1520482757; cv=none;
        d=google.com; s=arc-20160816;
        b=mIewkniU27/gI/Z0wR2nu6IuUdBNxujG+I+1yqITm5RslTsHpUijWTNSyjMKIwIMuy
         1DtT/w1wCALQBZRVpZ1pL2pyOwpZyH3AGlNxoe/CmIGI/Itjkh0rLvyGGdlApbbxvIht
         f7c0yBhG/IcKCDHc2dqB+3SEMabCku03BNLbXgM1TeqZj45Wt57LUsRuYI7w/XYoUglJ
         5A/F8qL+SZG4bTho7F0Rzt15CvTpnH4EcJl2QwkiHGCJQnxymCeKoP0F0oI2o2WpIw6e
         Di8BMsMX20WAJGt0LKnWl2RmrVx50OGeV4db5ytBf2ioqqMRd/ZN66Ki7ZHSHZC5ETdH
         r8jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:from:to:subject:references:in-reply-to:content-transfer-encoding
         :mime-version:date:message-id:arc-authentication-results;
        bh=2M1+t38dyCOEXYmRRYD5b3m062XGdHGbWEksRWj5sRk=;
        b=KHbEi+hGrHQYmum4wWOuXeIMIt2X9JIYYrpn0QaxYKRNa3ZZP1I4XccIv9swXbd6U+
         IisBELDrdULb04RYol8P354OPSfGTm3/nG5cMZsxa2eQx2mkpwNJ5fTb1atcXt/OGzY8
         7RAcGoDDW1QznnUiI9nECzgDq67dl2TWZRcIOyQ3AbHVw280CMwJVvF7oowwalXvyS4Z
         HiKyDcdMdI2aQEEIZAJ3TuQHPck0HqtsDf2XJ4wQKIxRjN9BaE/KOHxVt59MepGbFeEf
         aTCV/0xmYha2nqH6rWoDeLAS0dT4TyBVxm143hAlpxr8S3pZY1LzQDjo+er999aHwvVI
         PLmw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of bot@kernelci.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=bot@kernelci.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of bot@kernelci.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=bot@kernelci.org
X-Google-Smtp-Source: AG47ELuDjvBG7FPmzbOkrZ/hPZ7yRu41J97LnbE3wc4azK0s+CE9r8graPuzxQwIhqzz5IEAAdjmCg==
Message-ID: <5aa0b9c4.f8aedf0a.117e1.748d@mx.google.com>
Date: Wed, 07 Mar 2018 20:19:16 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.14.y
X-Kernelci-Kernel: v4.14.24-111-g66060ac1dfa0
X-Kernelci-Report-Type: boot
X-Kernelci-Tree: stable-rc
In-Reply-To: <20180307191039.748351103@linuxfoundation.org>
References: <20180307191039.748351103@linuxfoundation.org>
Subject: Re: [PATCH 4.14 000/110] 4.14.25-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org
From: kernelci.org bot <bot@kernelci.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net,
 shuahkh@osg.samsung.com, patches@kernelci.org, ben.hutchings@codethink.co.uk,
 lkft-triage@lists.linaro.org, stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594309365480057936?=
X-GMAIL-MSGID: =?utf-8?q?1594341728369831340?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

stable-rc/linux-4.14.y boot: 148 boots: 4 failed, 133 passed with 7 offline=
, 3 untried/unknown, 1 conflict (v4.14.24-111-g66060ac1dfa0)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.14.y/kernel/v4.14.24-111-g66060ac1dfa0/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.14.=
y/kernel/v4.14.24-111-g66060ac1dfa0/

Tree: stable-rc
Branch: linux-4.14.y
Git Describe: v4.14.24-111-g66060ac1dfa0
Git Commit: 66060ac1dfa02f02646a55f6ed888c0f2001623e
Git URL: http://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git
Tested: 76 unique boards, 23 SoC families, 17 builds out of 182

Boot Regressions Detected:

arm:

    davinci_all_defconfig:
        da850-evm:
            lab-baylibre-seattle: failing since 1 day (last pass: v4.14.4-7=
6-gf91a57b206e0 - first fail: v4.14.24)

    multi_v7_defconfig:
        armada-375-db:
            lab-free-electrons: new failure (last pass: v4.14.24)
        sun8i-h3-orangepi-pc:
            lab-free-electrons: failing since 1 day (last pass: v4.14.18-23=
-g8d861f5b27b0 - first fail: v4.14.24)

    sunxi_defconfig:
        sun8i-h3-orangepi-pc:
            lab-free-electrons: failing since 5 days (last pass: v4.14.18-2=
3-g8d861f5b27b0 - first fail: v4.14.23-116-g0ae11358b0bd)

Boot Failures Detected:

arm:

    davinci_all_defconfig
        da850-evm: 1 failed lab

    sunxi_defconfig
        sun8i-h3-orangepi-pc: 1 failed lab

    multi_v7_defconfig
        armada-375-db: 1 failed lab
        sun8i-h3-orangepi-pc: 1 failed lab

Offline Platforms:

arm:

    multi_v7_defconfig:
        exynos5410-odroidxu: 1 offline lab
        vf610-colibri-eval-v3: 1 offline lab

    exynos_defconfig:
        exynos5410-odroidxu: 1 offline lab

    imx_v6_v7_defconfig:
        vf610-colibri-eval-v3: 1 offline lab

arm64:

    defconfig:
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
