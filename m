Return-Path: <bot@kernelci.org>
ARC-Seal: i=1; a=rsa-sha256; t=1524421410; cv=none;
        d=google.com; s=arc-20160816;
        b=TEdNfURzj895sOSZBIBUcAIgYiYwOTywnK/Np9zexVNckBKQTNUS+4rZkywUqYwvrV
         WoTwNxlglrQibBZeDBqsq00UgQPT+T1Ab+mDoIJc9LULR+pAKmX1NeYzKHqPHHde9+YD
         WiRYto+/p4k5DLItEfgeXkzZu49pjEKyW70h15hiKt74AhnXbifW9w/CefqLBsrU+VA6
         G2PxaT6ytUv6+DeC0kL/e7zzCmE3sYT+jhyLzdGA6vdkzhTE/57tk3/htX7zWNE080M0
         QFhJME5IDv72hJn/MU3MqCxR2IrTNahtFocYzZwAdL4S95HwQ8BNZDrQp9bKvKObPV0M
         Lpxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:from:to:subject:references:in-reply-to:content-transfer-encoding
         :mime-version:date:message-id:arc-authentication-results;
        bh=w+eLaFkBX1XRayTTdayiDCJ3xb33z3F7dW0BGLLT5Kw=;
        b=eyYOC9isuaJ6wUETcWFngjjyIa+nPpYcG9nNxuwAL+Uw3O5+XAqI1aHPUACWQMBYe8
         pPFTwzrgHQJKHInfmwfVFQyp3s4RzW+9InboHHIzAvZWVRW7hj8mrsxlNO64Acm3dbVm
         VlkT5dPacGrM29nX/LezEs9WMGggzvcaf9EWPUGSU2HPyX8JqJ4oJeREDPN194Vghs0D
         xscY5zVYp/2weQWVoH9fTz7kG8FF0IHzrGeKe8B/ayWYenAa4hjgJTXX7SseTak38uxU
         VJE2JZda7hJFYGBfRctHnlhobU2Y70nrPujnp5Un7QP01Xw3zxOR+lGv7FM92YHM6svQ
         sU4Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of bot@kernelci.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=bot@kernelci.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of bot@kernelci.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=bot@kernelci.org
X-Google-Smtp-Source: AIpwx4+pN3hodDXuKbr1np2iuUx6HERYYP7j8Ds0AqOBrYI3pSRSaVu/oRSrwdAi4yihCy8QgjgmyA==
Message-ID: <5adcd321.1c69fb81.78f2.876d@mx.google.com>
Date: Sun, 22 Apr 2018 11:23:29 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.4.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: boot
X-Kernelci-Kernel: v4.4.128-98-g7f61d298acbc
In-Reply-To: <20180422135304.577223025@linuxfoundation.org>
References: <20180422135304.577223025@linuxfoundation.org>
Subject: Re: [PATCH 4.4 00/97] 4.4.129-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org
From: kernelci.org bot <bot@kernelci.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net,
 shuah@kernel.org, patches@kernelci.org, ben.hutchings@codethink.co.uk,
 lkft-triage@lists.linaro.org, stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598456189119404560?=
X-GMAIL-MSGID: =?utf-8?q?1598471704440342219?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

stable-rc/linux-4.4.y boot: 121 boots: 1 failed, 106 passed with 9 offline,=
 3 untried/unknown, 2 conflicts (v4.4.128-98-g7f61d298acbc)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.4.y/kernel/v4.4.128-98-g7f61d298acbc/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.4.y=
/kernel/v4.4.128-98-g7f61d298acbc/

Tree: stable-rc
Branch: linux-4.4.y
Git Describe: v4.4.128-98-g7f61d298acbc
Git Commit: 7f61d298acbc397846d74572c39fd4920cb317af
Git URL: http://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git
Tested: 59 unique boards, 20 SoC families, 16 builds out of 176

Boot Regressions Detected:

arm:

    multi_v7_defconfig:
        at91-sama5d4_xplained:
            lab-free-electrons: new failure (last pass: v4.4.128-19-ga168d2=
8608b3)

    sama5_defconfig:
        at91-sama5d4_xplained:
            lab-free-electrons: new failure (last pass: v4.4.128-19-ga168d2=
8608b3)
        sama5d36ek:
            lab-free-electrons: new failure (last pass: v4.4.128-19-ga168d2=
8608b3)

Boot Failure Detected:

arm:

    sama5_defconfig
        sama5d36ek: 1 failed lab

Offline Platforms:

arm:

    sunxi_defconfig:
        sun5i-r8-chip: 1 offline lab

    multi_v7_defconfig:
        qcom-apq8064-cm-qs600: 1 offline lab
        qcom-apq8064-ifc6410: 1 offline lab
        sun5i-r8-chip: 1 offline lab
        tegra20-iris-512: 1 offline lab

    qcom_defconfig:
        qcom-apq8064-cm-qs600: 1 offline lab
        qcom-apq8064-ifc6410: 1 offline lab

    tegra_defconfig:
        tegra20-iris-512: 1 offline lab

arm64:

    defconfig:
        apq8016-sbc: 1 offline lab

Conflicting Boot Failures Detected: (These likely are not failures as other=
 labs are reporting PASS. Needs review.)

arm:

    sama5_defconfig:
        at91-sama5d4_xplained:
            lab-free-electrons: FAIL
            lab-baylibre-seattle: PASS

    multi_v7_defconfig:
        at91-sama5d4_xplained:
            lab-free-electrons: FAIL
            lab-baylibre-seattle: PASS

---
For more info write to <info@kernelci.org>
