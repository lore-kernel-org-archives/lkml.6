Return-Path: <bot@kernelci.org>
ARC-Seal: i=1; a=rsa-sha256; t=1518722219; cv=none;
        d=google.com; s=arc-20160816;
        b=CcWppak4Hq9bg20w/fGcx5CNVp/liRTQ/hrL152iPs8KTc7ma4Ibj1imzebywWA0Pv
         XJt5ZPlFC1DDt2pQFB+1FRLkEw1dKfqitV/KfYl5W+WbXHJY+s1h3bgjM1EARtWt1GXL
         FXr2dhmSEYj9FOFGxQjdzvJQ1PoJmI0Iemjk+60wZ1mpYwLYadK9XnkPVswyL695H/tY
         u19yjVPQVRotnxW/PtYl/Q8lgcmZFV19K/WkeffDPj0ULPFNE68QLo5vUWhdG1atvxc1
         PiuQzQ1kn/GP1ikE+zFWNGpWwC744B/xGt0ml+QXIori3SKW7cl6e/gKfN6I1ULGf2l8
         gR2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:from:to:subject:references:in-reply-to:content-transfer-encoding
         :mime-version:date:message-id:arc-authentication-results;
        bh=pBWvn5ZIFxmR/KAUzRTkS9w68vmjsTQ+0iHh65HV0Ck=;
        b=UYVPya4PfS/rACrCCWTjPBgkJ9xallSq4LCvw0pXws4/RjbqQ6HeOdHJIo6HeFfIf/
         HS+M3MM2KXc0nC7MtoysYUXEeW/dx4uLrwB4dee+QRf7UPnQWK2E37n1AHrMYBZxuC8s
         qS70+owwqpiYJA28OaGIsUrLrJCCx/+cAMMUNYUtTDD8C+4uwb0OY89lH13Nbkb/j2ws
         IR9X5iBKnFYQI/HoXbF5IDnyFpYCGO3wEkORfsYmctdsQNSw+4b+vBu5yiZOhb7qjgk3
         qDyaASZvRcYBuZEjQAJibigPnx3uEWwJsg+tDLEPrC8vCvZtaspyDAlbzFdocaJMKy2w
         tMEA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of bot@kernelci.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=bot@kernelci.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of bot@kernelci.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=bot@kernelci.org
X-Google-Smtp-Source: AH8x225NF4TWWdp7Ch/fiGTEw+w3Y8172rMDBJBPXaHabNs1jGxb8Vg59LXO8zix1ENI9yS1Qc5ZDw==
Message-ID: <5a85dcaa.42e61c0a.bc4d0.dd5f@mx.google.com>
Date: Thu, 15 Feb 2018 11:16:58 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v3.18.94-46-g72255f521206
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: boot
X-Kernelci-Branch: linux-3.18.y
In-Reply-To: <20180215144115.863307741@linuxfoundation.org>
References: <20180215144115.863307741@linuxfoundation.org>
Subject: Re: [PATCH 3.18 00/45] 3.18.95-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org
From: kernelci.org bot <bot@kernelci.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net,
 shuahkh@osg.samsung.com, patches@kernelci.org, ben.hutchings@codethink.co.uk,
 lkft-triage@lists.linaro.org, stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592480703978774067?=
X-GMAIL-MSGID: =?utf-8?q?1592495670398380639?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

stable-rc/linux-3.18.y boot: 63 boots: 2 failed, 51 passed with 5 offline, =
5 conflicts (v3.18.94-46-g72255f521206)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-3.18.y/kernel/v3.18.94-46-g72255f521206/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-3.18.=
y/kernel/v3.18.94-46-g72255f521206/

Tree: stable-rc
Branch: linux-3.18.y
Git Describe: v3.18.94-46-g72255f521206
Git Commit: 72255f5212068a6f4936e55b7089aa8e76d3b4ce
Git URL: http://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git
Tested: 29 unique boards, 12 SoC families, 13 builds out of 183

Boot Regressions Detected:

arm:

    multi_v7_defconfig:
        am335x-boneblack:
            lab-collabora: new failure (last pass: v3.18.91-37-gd5790feb0d8=
a)
        dra7-evm:
            lab-baylibre: new failure (last pass: v3.18.94-27-gc19bd79392f2)
        qemu:
            lab-baylibre: new failure (last pass: v3.18.94-27-gc19bd79392f2)

    omap2plus_defconfig:
        dra7-evm:
            lab-baylibre: new failure (last pass: v3.18.94-27-gc19bd79392f2)

    vexpress_defconfig:
        qemu:
            lab-baylibre: new failure (last pass: v3.18.94-27-gc19bd79392f2)

arm64:

    defconfig:
        qemu:
            lab-baylibre: new failure (last pass: v3.18.94-27-gc19bd79392f2)

x86:

    x86_64_defconfig:
        qemu:
            lab-baylibre: new failure (last pass: v3.18.94-27-gc19bd79392f2)

Boot Failures Detected:

arm:

    omap2plus_defconfig
        dra7-evm: 1 failed lab

    multi_v7_defconfig
        dra7-evm: 1 failed lab

Offline Platforms:

arm:

    multi_v7_defconfig:
        exynos5410-odroidxu: 1 offline lab
        sun4i-a10-cubieboard: 1 offline lab

    sunxi_defconfig:
        sun4i-a10-cubieboard: 1 offline lab

    exynos_defconfig:
        exynos5410-odroidxu: 1 offline lab
        exynos5420-arndale-octa: 1 offline lab

Conflicting Boot Failures Detected: (These likely are not failures as other=
 labs are reporting PASS. Needs review.)

arm64:

    defconfig:
        qemu:
            lab-baylibre: FAIL
            lab-collabora: PASS

x86:

    x86_64_defconfig:
        qemu:
            lab-baylibre: FAIL
            lab-collabora: PASS

arm:

    multi_v7_defconfig:
        qemu:
            lab-baylibre: FAIL
            lab-collabora: PASS
        am335x-boneblack:
            lab-baylibre-seattle: PASS
            lab-collabora: FAIL

    vexpress_defconfig:
        qemu:
            lab-baylibre: FAIL
            lab-collabora: PASS

---
For more info write to <info@kernelci.org>
