Return-Path: <bot@kernelci.org>
ARC-Seal: i=1; a=rsa-sha256; t=1519239453; cv=none;
        d=google.com; s=arc-20160816;
        b=c8NarwZL7w7xC5U9hwqaKVNJc3G9n8vLjHQmy511iIU4apE4a+Biy77hTzsETN+/5d
         N7uJfUPrhD0fRzTqGOjuM/thDDCfFHWOdJD6me20UbCg7dcrohUY95h9hFW6OBuATsPP
         0jXp+HkO7l6EedOY+eymH/+FzNV5zCiw8ai46ugzne4/3EMMs/Du5hylsPtJVdBPQcHD
         +LE8FwsXt7QicHzub+8FL/UvJ4osNl0efwj65OMu0O9JdRRA2g3z7d4Nbr2DbHnCBs+g
         VrHmLu0LzPaT8S6D9bL9UjQHvYFrj7aR/rJoa3K7itnZcfPJxeZYsfN3DNdartfqQ/an
         uLcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:from:to:subject:references:in-reply-to:content-transfer-encoding
         :mime-version:date:message-id:arc-authentication-results;
        bh=7CdUgz4Uw5Ht0Yg47suZMG/lykWGOjF3oQO+WobeaNk=;
        b=wLnMP7d8TPIPbd7GsqI/uq+E52ym0y+BZ9SvjtaXKc4CcER8F1IZFUQGUE+iycqc/v
         Ewl8ExhaxYZRcbACtzMYyXsnMSvXlr5I06geSNPvH9zYutBVc5DLBR0JtU/YaP+VUxSm
         W4NerXz25mALmEZMCun346yp2ats34jkUxvdlzE4b9GhvoF0mpnOwjf+PAMJe3RF8VkL
         a+pgZ/+hd4qLTek8TjG5K8Ey/YTSvIKI4oaWh+dWVNVADAZ0zQv7wd576pKIvip0+SEy
         5JMZ5AIy7tYbrXhGYWI7lB/koQKKwyE3iYRL6doFvILRR9PZYRYfSBAEYkrHh1KQ2Orl
         ebbA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of bot@kernelci.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=bot@kernelci.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of bot@kernelci.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=bot@kernelci.org
X-Google-Smtp-Source: AH8x225IonpXqsrpBscpIl8KdBfAvZ6COHRoZBpzm7U0f+f5yN257lQ75Z6XETK2mPRCvJDqAMsVZg==
Message-ID: <5a8dc11c.0683df0a.7f03.04d7@mx.google.com>
Date: Wed, 21 Feb 2018 10:57:32 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.4.y
X-Kernelci-Kernel: v4.4.116-34-g4335fbc640f9
X-Kernelci-Report-Type: boot
X-Kernelci-Tree: stable-rc
In-Reply-To: <20180221124409.564661689@linuxfoundation.org>
References: <20180221124409.564661689@linuxfoundation.org>
Subject: Re: [PATCH 4.4 00/33] 4.4.117-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org
From: kernelci.org bot <bot@kernelci.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net,
 shuahkh@osg.samsung.com, patches@kernelci.org, ben.hutchings@codethink.co.uk,
 lkft-triage@lists.linaro.org, stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593014609837749485?=
X-GMAIL-MSGID: =?utf-8?q?1593038028944555155?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

stable-rc/linux-4.4.y boot: 67 boots: 0 failed, 53 passed with 14 offline (=
v4.4.116-34-g4335fbc640f9)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.4.y/kernel/v4.4.116-34-g4335fbc640f9/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.4.y=
/kernel/v4.4.116-34-g4335fbc640f9/

Tree: stable-rc
Branch: linux-4.4.y
Git Describe: v4.4.116-34-g4335fbc640f9
Git Commit: 4335fbc640f95fcd163c5883d21db1ea69ac89d3
Git URL: http://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git
Tested: 38 unique boards, 17 SoC families, 14 builds out of 174

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

---
For more info write to <info@kernelci.org>
