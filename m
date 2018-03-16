Return-Path: <bot@kernelci.org>
ARC-Seal: i=1; a=rsa-sha256; t=1521238808; cv=none;
        d=google.com; s=arc-20160816;
        b=o47wE8g+qNHpQaX0K83wCo8Fj4RTX7NWU8UbsEcVXUnIJ+LljGjJcKFBzMcDLsC8sD
         C++q+MsORtCD3FyGqWVe5a/MbeDa95Q97O5IwABwR58a7lThHcF5snojwDkIilWqGuI2
         FEqvOwbVMEE44qLMtvMWUK8xJmnjdTSz5U3Bs7Nk0cgD9wOPMZYoUbr1wWh3mGR0gtKF
         bkup3sxseqq9l59KnsL9lInr4cUsj+AINbLDIyzqz80YWaQ/8U7JFghXWOC1u8IQzGCu
         JeTP6ksvsc6yDEqUwpKVstu/zfXkwctHhlnb09oBOBv733yAp9Y23FUZA92kX0DN5cuW
         WPNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:from:to:subject:references:in-reply-to:content-transfer-encoding
         :mime-version:date:message-id:arc-authentication-results;
        bh=bj1UeN8/fvzcJ9JxwegU822UCcf9aJtJIG5J7T+MUSs=;
        b=RPtyTAF0HpiMTzu0iLspP8aP7ZUill2ZRVQ0ghEEq8r+l4Hy7BvPtLys1+HzHNdA1O
         Ds7V1C/GfAjWKdwp/C00YolHMZObUZH9qMHEYYzk7l8Q44QdxLiCC7Rnxo/ZuARxvxI1
         4GaoX4WPd8k0/r2ZDaEc6SbORhoI89p2t0h/dSn6WyyIzaDwSCzD9ihWGG4mW4BSGJkc
         f8kddFF5mr43awNjTQHi/5iHj9R252f7/P6e6O6tQit/Ef0eIRWwnNl/d6qP31AdtdDA
         Ieze/6CMM7TDwEQxBsh8KhesvD8tpyXnavaK+nCS0FkQS3w2G9p9Eg+GKt+KxH2Xvrjm
         krig==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of bot@kernelci.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=bot@kernelci.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of bot@kernelci.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=bot@kernelci.org
X-Google-Smtp-Source: AG47ELsShJGby8wG8o5Ha/mdNlBKoLUXeYnP0qYfepYIshsoKUm/ttsTRZ/QwUU0NyLcN7Y/WSoTJg==
Message-ID: <5aac4317.49c7df0a.3322d.d0ad@mx.google.com>
Date: Fri, 16 Mar 2018 15:20:07 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.14.y
X-Kernelci-Kernel: v4.14.27-110-g96676597127d
X-Kernelci-Report-Type: boot
X-Kernelci-Tree: stable-rc
In-Reply-To: <20180316152329.844663293@linuxfoundation.org>
References: <20180316152329.844663293@linuxfoundation.org>
Subject: Re: [PATCH 4.14 000/109] 4.14.28-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org
From: kernelci.org bot <bot@kernelci.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net,
 shuahkh@osg.samsung.com, patches@kernelci.org, ben.hutchings@codethink.co.uk,
 lkft-triage@lists.linaro.org, stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595109030771020666?=
X-GMAIL-MSGID: =?utf-8?q?1595134504872610685?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

stable-rc/linux-4.14.y boot: 46 boots: 0 failed, 40 passed with 5 offline, =
1 untried/unknown (v4.14.27-110-g96676597127d)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.14.y/kernel/v4.14.27-110-g96676597127d/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.14.=
y/kernel/v4.14.27-110-g96676597127d/

Tree: stable-rc
Branch: linux-4.14.y
Git Describe: v4.14.27-110-g96676597127d
Git Commit: 96676597127d70db4be4679b97ad4936b6337a3d
Git URL: http://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git
Tested: 38 unique boards, 11 SoC families, 13 builds out of 185

Offline Platforms:

arm:

    tegra_defconfig:
        tegra124-jetson-tk1: 1 offline lab

    sunxi_defconfig:
        sun5i-r8-chip: 1 offline lab

    exynos_defconfig:
        exynos5410-odroidxu: 1 offline lab

    imx_v6_v7_defconfig:
        vf610-colibri-eval-v3: 1 offline lab

    sama5_defconfig:
        at91-sama5d4_xplained: 1 offline lab

---
For more info write to <info@kernelci.org>
