Return-Path: <bot@kernelci.org>
ARC-Seal: i=1; a=rsa-sha256; t=1521502823; cv=none;
        d=google.com; s=arc-20160816;
        b=FYJnuWFmJhyNRYTJWLUE/+Hjwj5tJ+hiDT3o1k9qNbl/W3OHIvmx4dJoO0NYJsTAnj
         7LvsHsLEXDbNOW/R2c6YmFVKGIdEy+4LxyQYSQGyq8kXCJiwXgZB+D4WcPGx6j6MpyMs
         kEhGZOQijlbHs0cEpYCASfUGMIjo2YNUo7/D97jHsbi9wbxqm+a3fWHaR5Xo7kJNAa2v
         QRasF5iw4/6WUvCcNsJ0KgArmBC3aqaJxkMr5DM+zBQelI5swrO0+oiOXodFt/aFvYD1
         0SCtyJCUVOBSkRkiOIXRJ61WlKCnbPY2q5fI7445lrEm1LdVykPpL7Q9BsrtZZrhHqHE
         zVyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:from:to:subject:references:in-reply-to:content-transfer-encoding
         :mime-version:date:message-id:arc-authentication-results;
        bh=H06ZUX2Vdh56dfVpYHovjX3WO4h+tiocbAkCbJ1z+7M=;
        b=HDlYZQOgzjyg1vVRY0gOXpys41pLJj4sMvhNV/VIVcwFgWxnEn8ECtyihbsWLBvXd8
         ofdphbA7Z6z3iGmJ2x0CX+WM2IP4TOPiSAEKvxKASmPofACBz8Dz2mIl6yhgsQ6lYLVi
         yTjpw/CjQpbpeGemp+oJUryDIq092UKjtjJLFavQXgqSwbX6vJJHnrRl0b16P4x0aWWR
         GOxV4fkCzw9UIX2ao5oREg+HPgMM4XhiXXXxPMSwWgBWWWtW9zqs2D0pMIGyDrrb2XP2
         nDWgseXK2QOWeBl37/JpA9lFnohfFCNovq1NRcLxshYtnwvW8gy2GvIx18XIqhST2vM7
         gxBg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of bot@kernelci.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=bot@kernelci.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of bot@kernelci.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=bot@kernelci.org
X-Google-Smtp-Source: AG47ELsP1vjNrpQCzHgq+NJ41BCKrmz8BOBAZDGotm+R3Yic9O6Gai1VwTK3V3iXm3NNJy/AWYzgsQ==
Message-ID: <5ab04a66.c9351c0a.1eb49.1d2d@mx.google.com>
Date: Mon, 19 Mar 2018 16:40:22 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.14.y
X-Kernelci-Kernel: v4.14.28-42-g5efaf4e669b0
X-Kernelci-Report-Type: boot
X-Kernelci-Tree: stable-rc
In-Reply-To: <20180319180732.195217948@linuxfoundation.org>
References: <20180319180732.195217948@linuxfoundation.org>
Subject: Re: [PATCH 4.14 00/41] 4.14.29-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org
From: kernelci.org bot <bot@kernelci.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net,
 shuahkh@osg.samsung.com, patches@kernelci.org, ben.hutchings@codethink.co.uk,
 lkft-triage@lists.linaro.org, stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595391826189307019?=
X-GMAIL-MSGID: =?utf-8?q?1595411344691709584?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

stable-rc/linux-4.14.y boot: 118 boots: 0 failed, 106 passed with 10 offlin=
e, 2 untried/unknown (v4.14.28-42-g5efaf4e669b0)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.14.y/kernel/v4.14.28-42-g5efaf4e669b0/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.14.=
y/kernel/v4.14.28-42-g5efaf4e669b0/

Tree: stable-rc
Branch: linux-4.14.y
Git Describe: v4.14.28-42-g5efaf4e669b0
Git Commit: 5efaf4e669b0bb63f3be5c225f25ff832be26875
Git URL: http://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git
Tested: 67 unique boards, 23 SoC families, 17 builds out of 185

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
        meson-gxl-s905x-khadas-vim: 1 offline lab
        meson-gxl-s905x-nexbox-a95x: 1 offline lab
        mt7622-rfb1: 1 offline lab

---
For more info write to <info@kernelci.org>
