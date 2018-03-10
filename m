Return-Path: <bot@kernelci.org>
ARC-Seal: i=1; a=rsa-sha256; t=1520668772; cv=none;
        d=google.com; s=arc-20160816;
        b=CRkMQ/FYco+cwiRU1RN1gF/OCK26vinEwaKJhlt+JLBitPFYaYzeKfQmpx0wxTURGO
         6GImMTMGHPFicmElS2indoz52f5IID6qHGOD2tu5pVvuGjft+uFhm00MHV1DVB4pAUPR
         BRg+zcHikQHFjBKriqtpBiJsaY+xXUZQkKUIULyVHfVmjQf+w2cQCwa5uxb2SGBhm4zf
         H/NeVRPvNEZgIEvZEKHRtxAFSY8iTc2egMgALBBHYUPEgazMsLxK3yjpB3G+CtfmkN8E
         0qYtNfOC/4gJrBffv01NZiLlm4au52mGcccxObrHRNVIwon8eAksXfyTRoByNq7Uhqk/
         TwWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:from:to:subject:references:in-reply-to:content-transfer-encoding
         :mime-version:date:message-id:arc-authentication-results;
        bh=Hk9Q4lXQ7tQJfgkHKmidviW0mccjeR5As2daMQ7j7b4=;
        b=o9SITOVC0qMM4Smv31NICFvgGGebjzzs2z6pHebcz6KknmPNJMgrsEXDlNkAufjuPp
         7ubZTO2sVxf5Lev9scVZE+FbfyhcadeO7GRnjTRCTBlDcmNtPU7Ru/qxFbzbUI++NoWW
         4p/R/CgWzzIKWbHmvS0xB8Uo+a98aoBEBvmg2Dl0ppUYkZ7ZnMu20+cMLKdPZ/nlEPMl
         f/9llSg9dmMqF8WPmbupg6vq1aXq/0j3XqWQOYZVXqHlef7bWNxIR8Pfn0R41WNvXZsJ
         QuTnX0dX+CRzZeBkHccwHk/xdaeK1u1P5oauW3VGX1e7PtTD7iHEIDuRcSe0FB4BJ860
         ag4Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of bot@kernelci.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=bot@kernelci.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of bot@kernelci.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=bot@kernelci.org
X-Google-Smtp-Source: AG47ELupaBs5QpIWBydpWw/4p/ImHB5MSYp5/mdCEY2XcPO/lgQpaEZ8GgSrdtzsidKzjMcuvMkVPQ==
Message-ID: <5aa39062.73b3500a.b599d.a2d5@mx.google.com>
Date: Fri, 09 Mar 2018 23:59:30 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.9.y
X-Kernelci-Kernel: v4.9.86-66-gfaac4c330feb
X-Kernelci-Report-Type: boot
X-Kernelci-Tree: stable-rc
In-Reply-To: <20180310001824.927996722@linuxfoundation.org>
References: <20180310001824.927996722@linuxfoundation.org>
Subject: Re: [PATCH 4.9 00/65] 4.9.87-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org
From: kernelci.org bot <bot@kernelci.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net,
 shuahkh@osg.samsung.com, patches@kernelci.org, ben.hutchings@codethink.co.uk,
 lkft-triage@lists.linaro.org, stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594507975302163705?=
X-GMAIL-MSGID: =?utf-8?q?1594536778236889523?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

stable-rc/linux-4.9.y boot: 131 boots: 2 failed, 121 passed with 6 offline,=
 2 untried/unknown (v4.9.86-66-gfaac4c330feb)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.9.y/kernel/v4.9.86-66-gfaac4c330feb/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.9.y=
/kernel/v4.9.86-66-gfaac4c330feb/

Tree: stable-rc
Branch: linux-4.9.y
Git Describe: v4.9.86-66-gfaac4c330feb
Git Commit: faac4c330feb734f35d2b37221ae35bf28981ada
Git URL: http://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git
Tested: 67 unique boards, 22 SoC families, 18 builds out of 183

Boot Regressions Detected:

arm:

    multi_v7_defconfig:
        meson8b-odroidc1:
            lab-baylibre-seattle: new failure (last pass: v4.9.86)
        qcom-apq8064-cm-qs600:
            lab-baylibre-seattle: new failure (last pass: v4.9.86)

Boot Failures Detected:

arm:

    multi_v7_defconfig
        meson8b-odroidc1: 1 failed lab
        qcom-apq8064-cm-qs600: 1 failed lab

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
        meson-gxbb-p200: 1 offline lab

---
For more info write to <info@kernelci.org>
