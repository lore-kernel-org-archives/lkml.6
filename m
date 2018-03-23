Return-Path: <bot@kernelci.org>
ARC-Seal: i=1; a=rsa-sha256; t=1521812445; cv=none;
        d=google.com; s=arc-20160816;
        b=SwSDHVx3EMHYRfNDH0xWX5UfwVE8v7LVO4ihKSImoJ4RLruq84BnysROBycsaPTAph
         QgrWQ49qS5Yu94mwuaEKGWjnGsFvK4/mOGQpk1mshAIa2slF0kZPYqjUIEUiugzhLRIi
         bSoecRcp7Ftto0k3ziu5EFjzH4NNzjs+0ZEFUgXu6fduV7WBDCFmARR422ile9ewQzNo
         cYgibbXJ8SNXPi3xWky4lPwZmKPr5mYyM0uK1G4Mq3cn70B7f8rSNSza3cltoHhJCIqm
         2gYo7Uv7WxBLhDdL82HLfI9AeYqW4pDvayHQ/ONgNvWG/XYjAxaiaNgl94T6B3JQSYPn
         kB8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:from:to:subject:references:in-reply-to:content-transfer-encoding
         :mime-version:date:message-id:arc-authentication-results;
        bh=6Eg6nHZtWWBFmEw3ndEIlTbK6FhtfB3YOYSdKXl5HX8=;
        b=i6WGU9cHk9ilszkmIa4VcuOUzSmjaa7URCLdp55lM0PEJyHZ9bhWuPSEc+6ULeHJJx
         dcf7usPj7CY5S843kCGsn4+udwE9W4v6kQh6MJa4EcMrK2BmVNZxT/EiaXUU4ggxLQxn
         WD4zcEQLn2lq0eGSlFngoz+3GeXBnwLMoin+b+B1lsTkfhfU14t9P8fDhsPzLbJFJEbM
         Q+h4g5YCscAvbCJfK8j1UzmlQqIcdBA/KtySDrPqg7vEp9lISMf+qfnMSuVAjNEcUdPA
         qkACX2XTD4ctLCuVmwySwMnK/+Of6h4pPWnzY0PYs1QLTjIi+AfVdQi2SYDto6l1iEJy
         fgOA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of bot@kernelci.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=bot@kernelci.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of bot@kernelci.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=bot@kernelci.org
X-Google-Smtp-Source: AG47ELt0OCgtbHIecVmfwvd0VZwFCICgUxT9jDhYUExEV1m69+2+Bubm6VsaDPCQwiPNR6Ltb1cVHw==
Message-ID: <5ab503dc.01b9df0a.fdb52.22cc@mx.google.com>
Date: Fri, 23 Mar 2018 06:40:44 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.15.y
X-Kernelci-Kernel: v4.15.12-85-gbd2925ccfad3
X-Kernelci-Report-Type: boot
X-Kernelci-Tree: stable-rc
In-Reply-To: <20180323095411.913234798@linuxfoundation.org>
References: <20180323095411.913234798@linuxfoundation.org>
Subject: Re: [PATCH 4.15 00/84] 4.15.13-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org
From: kernelci.org bot <bot@kernelci.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net,
 shuahkh@osg.samsung.com, patches@kernelci.org, ben.hutchings@codethink.co.uk,
 lkft-triage@lists.linaro.org, stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595721912137540632?=
X-GMAIL-MSGID: =?utf-8?q?1595736007468866025?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

stable-rc/linux-4.15.y boot: 59 boots: 0 failed, 53 passed with 4 offline, =
1 untried/unknown, 1 conflict (v4.15.12-85-gbd2925ccfad3)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.15.y/kernel/v4.15.12-85-gbd2925ccfad3/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.15.=
y/kernel/v4.15.12-85-gbd2925ccfad3/

Tree: stable-rc
Branch: linux-4.15.y
Git Describe: v4.15.12-85-gbd2925ccfad3
Git Commit: bd2925ccfad3e41c318d4d1df9a476620b71a50b
Git URL: http://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git
Tested: 49 unique boards, 18 SoC families, 14 builds out of 185

Boot Regressions Detected:

arm:

    exynos_defconfig:
        exynos5800-peach-pi:
            lab-baylibre-seattle: failing since 1 day (last pass: v4.15.11-=
53-g3c07abdbc9bc - first fail: v4.15.12)

Offline Platforms:

arm:

    tegra_defconfig:
        tegra20-iris-512: 1 offline lab

    exynos_defconfig:
        exynos5410-odroidxu: 1 offline lab

arm64:

    defconfig:
        meson-gxbb-odroidc2: 1 offline lab
        mt7622-rfb1: 1 offline lab

Conflicting Boot Failure Detected: (These likely are not failures as other =
labs are reporting PASS. Needs review.)

arm:

    exynos_defconfig:
        exynos5800-peach-pi:
            lab-collabora: PASS
            lab-baylibre-seattle: FAIL

---
For more info write to <info@kernelci.org>
