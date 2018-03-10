Return-Path: <bot@kernelci.org>
ARC-Seal: i=1; a=rsa-sha256; t=1520666378; cv=none;
        d=google.com; s=arc-20160816;
        b=Wz5d1npKpWUW6VRotNdW9lJ9Q5vXUO0b0ZH6e6HnmpYbWewUPpsMCnkJpGXf+j3Jl2
         NPWKK8PYvz6dxFHvvUIjF7v2OSBde0FKx95DRTt+XkAbeX3x6nnX0rfYe2v3OP8mCeC7
         QV0dGVsK5i05Yro8nKkzPpFbUO3NmvnPO+kgRtFz3y8auFKL0G61/Wg7gLaUETSoW/mw
         NtK/cnfoYm8MqgIahEdOY3X+qewF5KIVRzlo6kP91dnA7CBB4hTPGSrD8xTgewRKqyTf
         GraO3iQ30BU6D493Cc5SuJwywSQen5Jeofdg3gQrsRgGpmzs2rNQrcXw5POWzg8s0CQR
         08Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:from:to:subject:references:in-reply-to:content-transfer-encoding
         :mime-version:date:message-id:arc-authentication-results;
        bh=p+JyV2AHN8sR+U4BoVvaCxMxJrFxinpumf378Rr7erc=;
        b=A0r2ZQ94JPZPUPzN9orbCs5D05Yzuxo66G1F2hRx2PGW0qWw3/ziFABXaW0KzaT+U8
         LD+IxgORdIy+0dDPufYqf4G5RnReMsF4wQOxRh6fbLGAii+UWVHqB8cG83ZS3T0OmjBl
         /4TUlHbmqco7jagvLV+8fdFzUe3jVapoM1+dZHlc3LEegdcmC97qNgTQTOUIXFQoM6js
         vukch+LAWkqaYSA+a9mEJWg21/8HvnusKzLHDXvk9X7iofli7feTMJ72jH6cn/kX3Pv6
         RBHQ9O8kctHycy1NtrV8obDIhMGD+Y8Yk+QusJpXSqLWRKmnJAJWwW4IcetKVjACMHkX
         3ALg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of bot@kernelci.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=bot@kernelci.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of bot@kernelci.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=bot@kernelci.org
X-Google-Smtp-Source: AG47ELuSztTGgYGJazLTgNfYJZmAW6zY+2nDFuS3qeMd11Ddlr/EHR7eGf2WjOJB8ypuUxTga/q8GA==
Message-ID: <5aa38708.3d97500a.4cbdb.9353@mx.google.com>
Date: Fri, 09 Mar 2018 23:19:36 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.14.y
X-Kernelci-Kernel: v4.14.25-10-gcf6424f29452
X-Kernelci-Report-Type: boot
X-Kernelci-Tree: stable-rc
In-Reply-To: <20180310001828.476933393@linuxfoundation.org>
References: <20180310001828.476933393@linuxfoundation.org>
Subject: Re: [PATCH 4.14 0/9] 4.14.26-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org
From: kernelci.org bot <bot@kernelci.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net,
 shuahkh@osg.samsung.com, patches@kernelci.org, ben.hutchings@codethink.co.uk,
 lkft-triage@lists.linaro.org, stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594508092195097724?=
X-GMAIL-MSGID: =?utf-8?q?1594534267944327333?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

stable-rc/linux-4.14.y boot: 143 boots: 1 failed, 130 passed with 10 offlin=
e, 2 untried/unknown (v4.14.25-10-gcf6424f29452)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.14.y/kernel/v4.14.25-10-gcf6424f29452/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.14.=
y/kernel/v4.14.25-10-gcf6424f29452/

Tree: stable-rc
Branch: linux-4.14.y
Git Describe: v4.14.25-10-gcf6424f29452
Git Commit: cf6424f29452daad0a844baf77c4a248f9b4196f
Git URL: http://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git
Tested: 75 unique boards, 23 SoC families, 17 builds out of 185

Boot Regressions Detected:

arm:

    multi_v7_defconfig:
        armada-375-db:
            lab-free-electrons: new failure (last pass: v4.14.25)

Boot Failure Detected:

arm:

    multi_v7_defconfig
        armada-375-db: 1 failed lab

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
