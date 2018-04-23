Return-Path: <bot@kernelci.org>
ARC-Seal: i=1; a=rsa-sha256; t=1524492217; cv=none;
        d=google.com; s=arc-20160816;
        b=Zfx3LWQ+9M/HmI+BiNwzslmw2B3h1SyYYaRmnWNdxdvu2GRtoDkZT/P3FDwI4Pc4Ia
         BzvF03jTdlDZrmoj06gDzcwYLuSN4aWsd+SxF7BPExNK83WH44oQQk7soo0Qk0J24SJW
         Fs0s1NPVxNR7irGLu3rEMRkEoyWLugqlqOu6PW6Y6yXUelvZvgFlCaVz83CheTjKi/xm
         lZ1qotSOuM0lO4Zvl7A3afzy7lZy6l6pBz+zwgSqEm2+9xLDKhomCoZfJ7hp8JTYENpD
         b3CawbppUZkg2sTXI9bGGvFMJlZ8hjmziDxfsMOxHNot/y4Ni5Z6V4/1JOUkt/RUFNqm
         yfBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:from:to:subject:references:in-reply-to:content-transfer-encoding
         :mime-version:date:message-id:arc-authentication-results;
        bh=MX+N2pJ7uG8mStsi/epCFOP0bpHmg0v4nNTW+uLF3eY=;
        b=WswOkPfKPU9Es6VFAW9JuA9g0y0n4V8W4g/t66fa21ZxFFq4iDf+sHKiR+e4yoRpsD
         LHEMH2bF09MXEWoYKHTQKgu0a4T5dhKE76Xsso4Ldm9PNqWfyq44KNkM45zv7U1qpmSP
         8LziLOXJf5KIBcSJaipt/Z8rwOYkLZ0c8SWC0y61fUHn/R6qTIuMfOO4Kmhn96h3cjMk
         sZ2gYoj28oyq4+CJVEgSvSa8ckQMbgv+a2C2ffaGzLbUhvnz2Akt+QZFQytXEm0+DEDR
         eTHWMIxZSZTkU8kXe0xVTp5DCu3vJmQE5yhBUEHwFdrN9lfrUsLaEbs2E6JpCweJt0N+
         XDrA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of bot@kernelci.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=bot@kernelci.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of bot@kernelci.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=bot@kernelci.org
X-Google-Smtp-Source: AIpwx4/dw7s10s53obE6p6yBDEoIR18v+o+L8OqEJebPizcU/aQdHPzsoWlJpePMYNroB3Sfnqx65w==
Message-ID: <5adde7b8.65b0500a.733a5.de18@mx.google.com>
Date: Mon, 23 Apr 2018 07:03:36 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.16.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: boot
X-Kernelci-Kernel: v4.16.3-197-g405d1f8b04d1
In-Reply-To: <20180422135104.278511750@linuxfoundation.org>
References: <20180422135104.278511750@linuxfoundation.org>
Subject: Re: [PATCH 4.16 000/196] 4.16.4-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org
From: kernelci.org bot <bot@kernelci.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net,
 shuah@kernel.org, patches@kernelci.org, ben.hutchings@codethink.co.uk,
 lkft-triage@lists.linaro.org, stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598454802503426017?=
X-GMAIL-MSGID: =?utf-8?q?1598545951411965018?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

stable-rc/linux-4.16.y boot: 152 boots: 4 failed, 136 passed with 9 offline=
, 2 untried/unknown, 1 conflict (v4.16.3-197-g405d1f8b04d1)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.16.y/kernel/v4.16.3-197-g405d1f8b04d1/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.16.=
y/kernel/v4.16.3-197-g405d1f8b04d1/

Tree: stable-rc
Branch: linux-4.16.y
Git Describe: v4.16.3-197-g405d1f8b04d1
Git Commit: 405d1f8b04d1be21a0ed20cc6adebdc8830215c4
Git URL: http://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git
Tested: 78 unique boards, 23 SoC families, 17 builds out of 186

Boot Regressions Detected:

arm:

    multi_v7_defconfig:
        sun8i-a33-sinlinx-sina33:
            lab-free-electrons: new failure (last pass: v4.16.2-266-g5befb1=
483fc7)

    mvebu_v7_defconfig:
        armada-xp-linksys-mamba:
            lab-free-electrons: new failure (last pass: v4.16.2-266-g5befb1=
483fc7)

    sunxi_defconfig:
        sun5i-r8-chip:
            lab-free-electrons: new failure (last pass: v4.16.2-266-g5befb1=
483fc7)
        sun8i-a83t-allwinner-h8homlet-v2:
            lab-free-electrons: new failure (last pass: v4.16.2-266-g5befb1=
483fc7)

arm64:

    defconfig:
        r8a7796-m3ulcb:
            lab-baylibre: new failure (last pass: v4.16.2-266-g5befb1483fc7)

Boot Failures Detected:

arm:

    sunxi_defconfig
        sun5i-r8-chip: 1 failed lab
        sun8i-a83t-allwinner-h8homlet-v2: 1 failed lab

    multi_v7_defconfig
        sun8i-a33-sinlinx-sina33: 1 failed lab

    mvebu_v7_defconfig
        armada-xp-linksys-mamba: 1 failed lab

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

Conflicting Boot Failure Detected: (These likely are not failures as other =
labs are reporting PASS. Needs review.)

arm64:

    defconfig:
        r8a7796-m3ulcb:
            lab-collabora: PASS
            lab-baylibre: FAIL

---
For more info write to <info@kernelci.org>
