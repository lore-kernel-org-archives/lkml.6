Return-Path: <bot@kernelci.org>
ARC-Seal: i=1; a=rsa-sha256; t=1524671051; cv=none;
        d=google.com; s=arc-20160816;
        b=UZkTtE8KRlZDhOliP6aDLVw2QCUE8UG4Pd6cBr8bWR3VqaPMoXOG7OfA42KYQFbihs
         yBbcqwgmDRA4/y60ZIrFRvb/+iQgDxMqQght74Y35k9O0U3lEcjseGieTbKDMytWmDQX
         vTcytXQxigFlqAm+nbFHEYpYy/+mkJ22N/rAs5YWg+Xua2j9xVMrCeveSWrwhhaKhSqn
         2FHey56LdY88aW2zW1d6oXQopbBwKRR6R/f7Z7nu+gmHxZ2Kmhyd+vIJeZrkflw90PZ1
         0Nbc9MYXupo4jTFV5DqREhrTPuU8lw/n8mr165vCvOmd3GBSiII8nKvZ5EMxaqqB3EP8
         8QyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:from:to:subject:references:in-reply-to:content-transfer-encoding
         :mime-version:date:message-id:arc-authentication-results;
        bh=p/lgcnWi9b+NPkOvtY95LWURG3uDKYTXwUzmnsUb3Zc=;
        b=VEhO+ZOjRVG5J04ulDFale0eeaaOHyuQYBbyU56yGq9pzal1V9GJgR3hfdAI74QTgN
         NCr0Uvi3B48pi4f2oe1xdP4jxDt4VGznDE0ZEZLG1Z5UezFZo66GHm4DKDAHEPmTDqW5
         xozV6E0/wR52rSK9656teLHlJ+oMfyIn0S6Di6SjDmxDgt3z4qRMC2SooQJE6OvYgUAi
         FaEoR0fAfBHNvRdbDTUhEJE0yu21dqYRMdGdBEWNDzg5AhKCkO+jujIBGcheeX8dbu3E
         Wa7pIe2L1Y5jal4pWStqI7+1hI26JG84PO4Zndnk/u2UV1/kHQfuDuUQlQZYupmPlG06
         2GVw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of bot@kernelci.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=bot@kernelci.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of bot@kernelci.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=bot@kernelci.org
X-Google-Smtp-Source: AIpwx4/2h42dDOT+FCqTHsJO++guaIa26axKaFIvna7efff5UUoWaeAl8blt7J99fEgpB8ZPa0buwg==
Message-ID: <5ae0a24a.494a1c0a.6cfdc.e0f5@mx.google.com>
Date: Wed, 25 Apr 2018 08:44:10 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.16.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: boot
X-Kernelci-Kernel: v4.16.4-27-g9a7eb4ea64f3
In-Reply-To: <20180425103314.842517924@linuxfoundation.org>
References: <20180425103314.842517924@linuxfoundation.org>
Subject: Re: [PATCH 4.16 00/26] 4.16.5-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org
From: kernelci.org bot <bot@kernelci.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net,
 shuah@kernel.org, patches@kernelci.org, ben.hutchings@codethink.co.uk,
 lkft-triage@lists.linaro.org, stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598713939951113780?=
X-GMAIL-MSGID: =?utf-8?q?1598733472384067374?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

stable-rc/linux-4.16.y boot: 152 boots: 4 failed, 131 passed with 16 offlin=
e, 1 untried/unknown (v4.16.4-27-g9a7eb4ea64f3)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.16.y/kernel/v4.16.4-27-g9a7eb4ea64f3/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.16.=
y/kernel/v4.16.4-27-g9a7eb4ea64f3/

Tree: stable-rc
Branch: linux-4.16.y
Git Describe: v4.16.4-27-g9a7eb4ea64f3
Git Commit: 9a7eb4ea64f3850a0fabfdf2d95f4c8cbffcb324
Git URL: http://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git
Tested: 79 unique boards, 24 SoC families, 17 builds out of 186

Boot Regressions Detected:

arm:

    multi_v7_defconfig:
        am335x-boneblack:
            lab-baylibre-seattle: new failure (last pass: v4.16.3-197-g405d=
1f8b04d1)
        sun5i-gr8-chip-pro:
            lab-free-electrons: new failure (last pass: v4.16.4)

Boot Failures Detected:

arm:

    omap2plus_defconfig
        dra7-evm: 1 failed lab

    multi_v7_defconfig
        am335x-boneblack: 1 failed lab
        dra7-evm: 1 failed lab
        sun5i-gr8-chip-pro: 1 failed lab

Offline Platforms:

arm:

    tegra_defconfig:
        tegra20-iris-512: 1 offline lab

    multi_v7_defconfig:
        meson8b-odroidc1: 1 offline lab
        qcom-apq8064-cm-qs600: 1 offline lab
        qcom-apq8064-ifc6410: 1 offline lab
        tegra20-iris-512: 1 offline lab
        vf610-colibri-eval-v3: 1 offline lab

    imx_v6_v7_defconfig:
        vf610-colibri-eval-v3: 1 offline lab

    davinci_all_defconfig:
        da850-lcdk: 1 offline lab

    qcom_defconfig:
        qcom-apq8064-cm-qs600: 1 offline lab
        qcom-apq8064-ifc6410: 1 offline lab

arm64:

    defconfig:
        apq8016-sbc: 1 offline lab
        meson-gxbb-odroidc2: 1 offline lab
        meson-gxl-s905d-p230: 1 offline lab
        meson-gxl-s905x-nexbox-a95x: 1 offline lab
        meson-gxl-s905x-p212: 1 offline lab
        rk3399-firefly: 1 offline lab

---
For more info write to <info@kernelci.org>
