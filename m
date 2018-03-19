Return-Path: <bot@kernelci.org>
ARC-Seal: i=1; a=rsa-sha256; t=1521501624; cv=none;
        d=google.com; s=arc-20160816;
        b=S+Ar67p0yoyRw7OfidTpM5whSZAMD8vgz6NIn9wIRbdV1JfLNWEBTjYcbfQJRPECAa
         MHMuVC6cKI9fEK8fJy1GYmtkVU0BH0/zP1jkrfycluFl6KVq9jYMp7TfkTGpB58+c1xj
         cHO9ochZoa9rU5Nu2XcL27TpSHePE/kl6BVvCqVMpng05enENp6ggp/f6G9IrMoukOk5
         AsXWOGFXVckX8bC0oM2gmrKT5+iQE73a5tTnxBcO3j4rT/RWimCPblWhP5feogYsV54h
         lesAGbodxhfZATc3rNy+62csqPOdtc/N5eECOlGkxX490oRdmtLaKcpH/3IBm5q1emKJ
         pLyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:from:to:subject:references:in-reply-to:content-transfer-encoding
         :mime-version:date:message-id:arc-authentication-results;
        bh=gHdef+OIyT7JPDTDbwmZ4pNI9tbGh+xIl5cq3S0cCnQ=;
        b=ekxoKx3QSrx2x84Eh3TFqX7R2yZgVQb5P7AX3M5Nf2MjUlekPFCvmkQAjkPy5sVUQz
         iWboqfN3awKCMH+tvqP93z4fKCX1CLPoWUF/78AW86le35Yp+AfveqWaeeaLx4LH+/Z+
         RRl2NbFapPGNtW+RARQhRGnuBGmUeQYG9cv0Nhqgov93ejGcYog61mSOz1Ntj4ipJRnl
         xvNE+QAxcRx230xZmZ9Eb8UoX8Cxn1jFzESaB1rd4yzLMuf40Q8+bFuPepKB22A00fhP
         CLbwklEuByq4Ns9L2HHXOl+E3QF0D7yMb71TQeV2yAHaw4m/yV9DdOSgccOv8yq5q5Mn
         +YPQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of bot@kernelci.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=bot@kernelci.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of bot@kernelci.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=bot@kernelci.org
X-Google-Smtp-Source: AG47ELsLY5ejOPnA/P6RdbkIJT4ZLIbcUdmSWqxoOL88P08TXw1lD2bu+c9CMJnBvdOHBCVw+TdtBg==
Message-ID: <5ab045b7.2495df0a.a304f.19d5@mx.google.com>
Date: Mon, 19 Mar 2018 16:20:23 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.15.y
X-Kernelci-Kernel: v4.15.11-53-g3c07abdbc9bc
X-Kernelci-Report-Type: boot
X-Kernelci-Tree: stable-rc
In-Reply-To: <20180319180734.976730813@linuxfoundation.org>
References: <20180319180734.976730813@linuxfoundation.org>
Subject: Re: [PATCH 4.15 00/52] 4.15.12-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org
From: kernelci.org bot <bot@kernelci.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net,
 shuahkh@osg.samsung.com, patches@kernelci.org, ben.hutchings@codethink.co.uk,
 lkft-triage@lists.linaro.org, stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595391957310699281?=
X-GMAIL-MSGID: =?utf-8?q?1595410087620780431?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

stable-rc/linux-4.15.y boot: 118 boots: 1 failed, 103 passed with 11 offlin=
e, 3 untried/unknown (v4.15.11-53-g3c07abdbc9bc)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.15.y/kernel/v4.15.11-53-g3c07abdbc9bc/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.15.=
y/kernel/v4.15.11-53-g3c07abdbc9bc/

Tree: stable-rc
Branch: linux-4.15.y
Git Describe: v4.15.11-53-g3c07abdbc9bc
Git Commit: 3c07abdbc9bc2a5e03a0f3be3a967484c4210abe
Git URL: http://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git
Tested: 67 unique boards, 23 SoC families, 17 builds out of 185

Boot Regressions Detected:

arm:

    sunxi_defconfig:
        sun5i-gr8-chip-pro:
            lab-free-electrons: new failure (last pass: v4.15.11)

Boot Failure Detected:

arm:

    sunxi_defconfig
        sun5i-gr8-chip-pro: 1 failed lab

Offline Platforms:

arm:

    multi_v7_defconfig:
        exynos5410-odroidxu: 1 offline lab
        meson8b-odroidc1: 1 offline lab
        vf610-colibri-eval-v3: 1 offline lab

    exynos_defconfig:
        exynos5410-odroidxu: 1 offline lab
        exynos5800-peach-pi: 1 offline lab

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
