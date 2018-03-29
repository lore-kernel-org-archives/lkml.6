Return-Path: <bot@kernelci.org>
ARC-Seal: i=1; a=rsa-sha256; t=1522360881; cv=none;
        d=google.com; s=arc-20160816;
        b=K5Qlju3hvRTbiuejah5BqXHPYLmoZjOLJaX5usJYLRThcQbd0TE9Dl1zckDZdu8GBE
         1G1rGyIGxccPqlbirinTNm1cAMwT1ZY35O3UEYWX1a0lA9lfx4O/txVUrZbJewHMQQIS
         nsKwpXrC+6hw3WQEebF7HjEbABTpVKSAOeMpQ4zdlphCAoYluXWCoD0xGlJMWdqZQlVN
         9M83viMy9Qn5/WKQF5Tag2mXelcdOLFvshvmZY8S+y2duc2CnScXI8mt3YvcUXoKEcBD
         Twn2B0rrSzReLWkdUzjGlmt0NZRQ9S3HY2NabAUkTZILMC/+fgU/vj3yBs44fCn9Wra+
         LqFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:from:to:subject:references:in-reply-to:content-transfer-encoding
         :mime-version:date:message-id:arc-authentication-results;
        bh=FZjt9w+mdGeDvnhW0ZH9/Ril+GeROgeoJl3eLWH2HjM=;
        b=XW75Gao2XLcp4IOrAUl4r5K4dFYCa+TdqbM2qUYM8XMUwtjgh6o6Atst19d5Z5lhJo
         6yB/n+boY4upWzxIUhaeg3+h9y3x9mo2epvyxambkfEujgcv0E0JZHgeygJeoUSXrsNB
         /1j+ydJBcs8j10H+jeU9xeMt2KL8ZEUKnhdhabOIkNI0DaMRX1sY3OvUlKlFrJwJGiXB
         JFyKrFJOLiEu/PjWqjtPcq8QEe1drBjsrWKESpF1tGcsF1BF1wsDhUtvtscpl0lWFCpb
         6uU12SYbOO6FJ38ibfqDe+A0xh7sA+9wgc2FM8eFjFm3hoNI66LGW9JwUBEV1pabAJJX
         DMwQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of bot@kernelci.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=bot@kernelci.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of bot@kernelci.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=bot@kernelci.org
X-Google-Smtp-Source: AIpwx48dyNv/Inpv6QoX47Q3E7ILqS25uedLYXjLINHQytZNPrCs/uRFjOdsaeYYqfivGvDXcwPLlg==
Message-ID: <5abd622f.82151c0a.319b3.2d31@mx.google.com>
Date: Thu, 29 Mar 2018 15:01:19 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.15.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: boot
X-Kernelci-Kernel: v4.15.14-48-g98a6610fb36e
In-Reply-To: <20180329175729.225211114@linuxfoundation.org>
References: <20180329175729.225211114@linuxfoundation.org>
Subject: Re: [PATCH 4.15 00/47] 4.15.15-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org
From: kernelci.org bot <bot@kernelci.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net,
 shuahkh@osg.samsung.com, patches@kernelci.org, ben.hutchings@codethink.co.uk,
 lkft-triage@lists.linaro.org, stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596296024525248460?=
X-GMAIL-MSGID: =?utf-8?q?1596311082935171499?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

stable-rc/linux-4.15.y boot: 130 boots: 1 failed, 114 passed with 12 offlin=
e, 2 untried/unknown, 1 conflict (v4.15.14-48-g98a6610fb36e)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.15.y/kernel/v4.15.14-48-g98a6610fb36e/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.15.=
y/kernel/v4.15.14-48-g98a6610fb36e/

Tree: stable-rc
Branch: linux-4.15.y
Git Describe: v4.15.14-48-g98a6610fb36e
Git Commit: 98a6610fb36ed6f07135fc9acf55d74ef9a1a769
Git URL: http://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git
Tested: 70 unique boards, 23 SoC families, 17 builds out of 185

Boot Regressions Detected:

arm:

    exynos_defconfig:
        exynos5800-peach-pi:
            lab-baylibre-seattle: failing since 1 day (last pass: v4.15.13 =
- first fail: v4.15.13-106-g720c68fc1406)

    sunxi_defconfig:
        sun8i-a33-sinlinx-sina33:
            lab-free-electrons: new failure (last pass: v4.15.14)

Boot Failure Detected:

arm:

    sunxi_defconfig
        sun8i-a33-sinlinx-sina33: 1 failed lab

Offline Platforms:

arm:

    sunxi_defconfig:
        sun5i-r8-chip: 1 offline lab
        sun7i-a20-cubietruck: 1 offline lab

    multi_v7_defconfig:
        exynos5410-odroidxu: 1 offline lab
        sun5i-r8-chip: 1 offline lab
        sun7i-a20-cubietruck: 1 offline lab
        tegra20-iris-512: 1 offline lab
        tegra30-beaver: 1 offline lab

    exynos_defconfig:
        exynos5410-odroidxu: 1 offline lab

    tegra_defconfig:
        tegra20-iris-512: 1 offline lab
        tegra30-beaver: 1 offline lab

arm64:

    defconfig:
        meson-gxbb-odroidc2: 1 offline lab
        meson-gxl-s905d-p230: 1 offline lab

Conflicting Boot Failure Detected: (These likely are not failures as other =
labs are reporting PASS. Needs review.)

arm:

    exynos_defconfig:
        exynos5800-peach-pi:
            lab-collabora: PASS
            lab-baylibre-seattle: FAIL

---
For more info write to <info@kernelci.org>
