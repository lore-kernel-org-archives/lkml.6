Return-Path: <bot@kernelci.org>
ARC-Seal: i=1; a=rsa-sha256; t=1519424265; cv=none;
        d=google.com; s=arc-20160816;
        b=SSfVP/BbcnyAtTlfcvBkEhAu5at2DTdPb3ohc5JCWli6diZwqfuu9UvrPInYhKkC0z
         fROXiTRyQMmw4XwH7WwSVG25PGeEQs5JvhWYZWEH68SwYXUZ520YbD2UohgMLVSJPWyI
         +kNv6QWVKJG9v8m3q1sFDpX8+SgxDbaYPZappOFTQgpYVULIJ5EM4blQ0JcUfR5+HkPc
         es2Z223ap0IpmL6W5LJ0umWfYi52U+ilA/hwiaRu7QEQKNcPHL49VrWdYrv6BHBawEpz
         GR3ahILmNH5g6jig3LB/yqwQoCwnj4HZuwFsDHF+YVh+nNaLuWMvVJNyx6c8lJVX+jx7
         7BIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:from:to:subject:references:in-reply-to:content-transfer-encoding
         :mime-version:date:message-id:arc-authentication-results;
        bh=3pzQwG+fOzctXE4bQhwm0zzX7q91Up6+mx1eZnbHV6g=;
        b=eXm7mPixBFDrSonIZdv2uG6l8IkUGjop83M0vVunE9Dxp5N06W1pF3NbdtcgcbZNwq
         7GZz7hUs96RqjNmOeRJTf0o8qaeqnYlVJNerCBqVPhkJy30B5GhNgOEkBvwmQ2AT0pnc
         iM/UatKSHlEbvPoi/LUmViXfGAgRvOaTFJVFdnaEH0ZhitvxGd8CMAHms63D4U/WFzOn
         IM+BJFeUEiU2rAFf4JpqDpwvWLiNdkkRBxD8EedyHMpwGMmP+csRFXTo/KoipyM+OwES
         UOfWS8HmgQOLpdt6pyCyQyfJ6oSabBISEEdPRy3nIo3HpzNM5QBgzpX2/ULINulyNqeC
         K+mQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of bot@kernelci.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=bot@kernelci.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of bot@kernelci.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=bot@kernelci.org
X-Google-Smtp-Source: AH8x224cBiPxrDv7vkckaP2ID4tbOtBZxMUx0sdE9rJvumlIqgFxAnBaZfd6TgxvKWF1rhQTA2bVDQ==
Message-ID: <5a909308.c5b71c0a.c8cff.f57d@mx.google.com>
Date: Fri, 23 Feb 2018 14:17:44 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-3.18.y
X-Kernelci-Kernel: v3.18.95-59-g1f0a8ec0eeca
X-Kernelci-Report-Type: boot
X-Kernelci-Tree: stable-rc
In-Reply-To: <20180223170206.724655284@linuxfoundation.org>
References: <20180223170206.724655284@linuxfoundation.org>
Subject: Re: [PATCH 3.18 00/58] 3.18.96-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org
From: kernelci.org bot <bot@kernelci.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net,
 shuahkh@osg.samsung.com, patches@kernelci.org, ben.hutchings@codethink.co.uk,
 lkft-triage@lists.linaro.org, stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593217489993597435?=
X-GMAIL-MSGID: =?utf-8?q?1593231819112702618?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

stable-rc/linux-3.18.y boot: 62 boots: 1 failed, 53 passed with 8 offline (=
v3.18.95-59-g1f0a8ec0eeca)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-3.18.y/kernel/v3.18.95-59-g1f0a8ec0eeca/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-3.18.=
y/kernel/v3.18.95-59-g1f0a8ec0eeca/

Tree: stable-rc
Branch: linux-3.18.y
Git Describe: v3.18.95-59-g1f0a8ec0eeca
Git Commit: 1f0a8ec0eeca1f3e49ea0674c3b166120f25a656
Git URL: http://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git
Tested: 30 unique boards, 13 SoC families, 14 builds out of 167

Boot Regressions Detected:

arm:

    exynos_defconfig:
        exynos5420-arndale-octa:
            lab-baylibre-seattle: failing since 2 days (last pass: v3.18.95=
 - first fail: v3.18.95-18-g740dcd9a92f2)

Boot Failure Detected:

arm:

    exynos_defconfig
        exynos5420-arndale-octa: 1 failed lab

Offline Platforms:

arm:

    exynos_defconfig:
        exynos5410-odroidxu: 1 offline lab

    multi_v7_defconfig:
        am335x-boneblack: 1 offline lab
        exynos5410-odroidxu: 1 offline lab
        tegra124-jetson-tk1: 1 offline lab

    sama5_defconfig:
        at91-sama5d4ek: 1 offline lab

    tegra_defconfig:
        tegra124-jetson-tk1: 1 offline lab

    bcm2835_defconfig:
        bcm2835-rpi-b: 1 offline lab

    omap2plus_defconfig:
        am335x-boneblack: 1 offline lab

---
For more info write to <info@kernelci.org>
