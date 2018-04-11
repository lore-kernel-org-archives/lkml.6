Return-Path: <bot@kernelci.org>
ARC-Seal: i=1; a=rsa-sha256; t=1523414544; cv=none;
        d=google.com; s=arc-20160816;
        b=ArPByY7bV+24RlvyYPxZ5k+VfDV5b3WsG0NSbgVTOIj3LJ4eGhXL/oeOVJLBb9928B
         ekuU4BHmQW+7upR6tQ66cp1bF3QzGH7btcZmivQySl39cyuB4I8RFdyQ4Frc1qV4tkMW
         iVifM4H7zUYlq8JoCJDiZRQ/XIkIpnDXnTnh0M64JCajZbML/zgCIPwM3/fahBDoXAWP
         tMe5Bmqr0lU7vwrcjNdSv2LeyQK6s4BuB8z9zA73Jniz3760wxFTiWg429ire/6YQlVs
         r2iVjYVWZydLBG6Cf6wbgV43Rgb/kicAwCV0s7Ojg9csbSw2me0AZqEFGH2K+llhwg2r
         Afqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:from:to:subject:references:in-reply-to:content-transfer-encoding
         :mime-version:date:message-id:arc-authentication-results;
        bh=gAHtAc+K0CU9ZFKe2XJbw6QUN482PCtgRmNYzLNdXEc=;
        b=xudGyoySP/BkKnFlKcO9AGLlmkDUnxsASEV7hHGelWKLbyjaOEWZi4dJeCyC3WgctN
         Y3vdXQtyWgGBsGT/4fQukACWebRijrKRa+TkRPCZ0iMlj0Aexk/yQ004F0vocRMTtGeB
         W5zUY9sn5Rs5tj+O/hVB3FcInStmX42pe3nrFSR95AwHXMjU1J291EPRe1KJHsIjpo/c
         7zralSnPzrgHByET1P8FIfFqmrtboLk/c7BHMiMii2NFEYTjDvsaWys6vDzc+1Razl00
         VCRtf3GcU7OM7XAOuhfxIC6vM0TdPrDZ51FYW40+/nOMqBveIvAj4mDmnwoXpwts1aZH
         RukA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of bot@kernelci.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=bot@kernelci.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of bot@kernelci.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=bot@kernelci.org
X-Google-Smtp-Source: AIpwx4+jTUTn48WqmEJ/4TQ/NgMy4bD37J/NulfXDbp9ggJLzKmUbEjdzNvF9WOSwggE6iNYyalA+g==
Message-ID: <5acd760f.2495df0a.1fdcf.030a@mx.google.com>
Date: Tue, 10 Apr 2018 19:42:23 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.15.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: boot
X-Kernelci-Kernel: v4.15.16-169-g99a63ea2bfce
In-Reply-To: <20180410212800.144079021@linuxfoundation.org>
References: <20180410212800.144079021@linuxfoundation.org>
Subject: Re: [PATCH 4.15 000/168] 4.15.17-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org
From: kernelci.org bot <bot@kernelci.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net,
 shuahkh@osg.samsung.com, patches@kernelci.org, ben.hutchings@codethink.co.uk,
 lkft-triage@lists.linaro.org, stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597399823724415231?=
X-GMAIL-MSGID: =?utf-8?q?1597415929334773851?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

stable-rc/linux-4.15.y boot: 82 boots: 2 failed, 78 passed with 2 untried/u=
nknown (v4.15.16-169-g99a63ea2bfce)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.15.y/kernel/v4.15.16-169-g99a63ea2bfce/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.15.=
y/kernel/v4.15.16-169-g99a63ea2bfce/

Tree: stable-rc
Branch: linux-4.15.y
Git Describe: v4.15.16-169-g99a63ea2bfce
Git Commit: 99a63ea2bfce072fa43311cceb4642c1b2ccca9c
Git URL: http://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git
Tested: 40 unique boards, 15 SoC families, 15 builds out of 185

Boot Regressions Detected:

arm:

    multi_v7_defconfig:
        sun8i-a83t-allwinner-h8homlet-v2:
            lab-free-electrons: failing since 1 day (last pass: v4.15.16-11=
0-gc35a9efcac26 - first fail: v4.15.16-124-gff369be839c7)

    mvebu_v7_defconfig:
        armada-375-db:
            lab-free-electrons: new failure (last pass: v4.15.16-124-gff369=
be839c7)

Boot Failures Detected:

arm:

    multi_v7_defconfig
        sun8i-a83t-allwinner-h8homlet-v2: 1 failed lab

    mvebu_v7_defconfig
        armada-375-db: 1 failed lab

---
For more info write to <info@kernelci.org>
