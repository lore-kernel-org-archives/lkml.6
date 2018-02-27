Return-Path: <bot@kernelci.org>
ARC-Seal: i=1; a=rsa-sha256; t=1519715886; cv=none;
        d=google.com; s=arc-20160816;
        b=Xl5ucdDOXburR4vFOBjrzGz5mDAZ332wVR/YtgsftwObxH3iwCnyy3igfGCpyS+yiv
         sq4yhddVhCCD+eU0cH0/0pMNfK/Jm1EsK5j6Xo81IAbJUzSA/NUK8mAQdONJQXmg1jxg
         N9nNbXgU/Ju8P8puZfoegTIA0RtJS7gXRdRzR1fLn3JSpC0FWLX1zVWkIC2lgKhOeYVl
         jFzacThZLSI3LaSF/ZyyHtjvNl1F8oJ3GFTvkVB27kqvYgdiEV+6lWqf6KXzgN8FOEaq
         TmeAkRVxSyVU/zaMQmAzIxlxwFg0Rdgq0JgKDJ9H+z+20QCvtIGjmGrdj7LMS80Ew4NC
         i9BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:from:to:subject:references:in-reply-to:content-transfer-encoding
         :mime-version:date:message-id:arc-authentication-results;
        bh=jmp++xBK8n7aN6xrFL3Myi/ta4Ca9HwHqcAQ4kHgM0E=;
        b=dkAmzgc2EHXpMmEu8nIWukZWf9BO8JKAVbVuFJ1kQfNXdLozPrK9BTeA/LG509nXWY
         9kgmbO70MiKogtQRgKjrRRvewxz4w2vb96NrYmzlLSGBy6dflvLmxHKWZt+srNjMcdfq
         +Gtfet1yAieUdB5V8Z7M/Jz9R0gVbj1TK8otzrBZ7jDrUpWcto1BBzRLWgML6F4EpN31
         pgFzMphDFZRbxKCIaL3hTsbjWC50Vw/FdeGhhRHcIQhMco7Mip+HepsgelBbmrOZoyj7
         ohBF6Ksu0My4ZKRDfbvvSKHa7W9BLCJxNn0/vJQTkmqYZ1EH+uS7PcYPITv+SYGqGfWw
         p0CQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of bot@kernelci.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=bot@kernelci.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of bot@kernelci.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=bot@kernelci.org
X-Google-Smtp-Source: AH8x227sBDZsMh5pfYQWnV+Rku4fgwm5wnx1uteKEoI5uLZSk8jwBAl46PUQG3NwG4PFhvqPeDdFaw==
Message-ID: <5a95062d.86e0500a.a89ba.55ec@mx.google.com>
Date: Mon, 26 Feb 2018 23:18:05 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.15.y
X-Kernelci-Kernel: v4.15.6-65-g3d453a1a75bc
X-Kernelci-Report-Type: boot
X-Kernelci-Tree: stable-rc
In-Reply-To: <20180226202153.453363333@linuxfoundation.org>
References: <20180226202153.453363333@linuxfoundation.org>
Subject: Re: [PATCH 4.15 00/64] 4.15.7-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org
From: kernelci.org bot <bot@kernelci.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net,
 shuahkh@osg.samsung.com, patches@kernelci.org, ben.hutchings@codethink.co.uk,
 lkft-triage@lists.linaro.org, stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593496679131822580?=
X-GMAIL-MSGID: =?utf-8?q?1593537605950711139?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

stable-rc/linux-4.15.y boot: 105 boots: 0 failed, 91 passed with 7 offline,=
 7 untried/unknown (v4.15.6-65-g3d453a1a75bc)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.15.y/kernel/v4.15.6-65-g3d453a1a75bc/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.15.=
y/kernel/v4.15.6-65-g3d453a1a75bc/

Tree: stable-rc
Branch: linux-4.15.y
Git Describe: v4.15.6-65-g3d453a1a75bc
Git Commit: 3d453a1a75bc48e16e118a9c08fec19c5b93ca59
Git URL: http://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git
Tested: 59 unique boards, 22 SoC families, 15 builds out of 185

Offline Platforms:

arm:

    bcm2835_defconfig:
        bcm2835-rpi-b: 1 offline lab

    exynos_defconfig:
        exynos5410-odroidxu: 1 offline lab
        exynos5422-odroidxu3: 1 offline lab

    multi_v7_defconfig:
        exynos5410-odroidxu: 1 offline lab
        exynos5422-odroidxu3: 1 offline lab
        tegra124-jetson-tk1: 1 offline lab

arm64:

    defconfig:
        meson-gxbb-odroidc2: 1 offline lab

---
For more info write to <info@kernelci.org>
