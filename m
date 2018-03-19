Return-Path: <bot@kernelci.org>
ARC-Seal: i=1; a=rsa-sha256; t=1521498023; cv=none;
        d=google.com; s=arc-20160816;
        b=x1C6ikFabc4rQsUk972lZJonBvXOnSz93loSYfjh6zmapW0Z6lt67ULM+CmFQKAyHC
         0m2oYcQPUkzAKddKbhKTw7ryo15cFRJltcqvXmFK8ipvGbujTkmYY+gvYqYunjudvjRt
         Zx+Dj4FeGF1e1OA3mVq4im2euVH4itaBQJfsujOGO8YfM6Z+k1JZKiqpPVm30QJePL4b
         un4uaRT1nghQCWCX0OHvipBf7VoyfdVMaQ+4vbozBYoRIpJ/Sn5ciOhNsPFP0yaVGBIp
         I8ovFRk4v8Ki5z5zBRHEGzxVAB1q5gohn5Zfu/dmmxgni7i6hS1K+6dPWygCMaK0Mlvd
         1GGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:from:to:subject:references:in-reply-to:content-transfer-encoding
         :mime-version:date:message-id:arc-authentication-results;
        bh=bGBvgGAMz3kqdWO2h+yMi5fA3a7CDjQm2GggBtgZtFs=;
        b=tf5kSpA76szvAanfLR1DIxfw6VXmgF7vYV5KLH67CbBbbtnLyh8U9nULHg5otJosXk
         3SisJDBCyH1xAQ8W4CEq51DjGI/nwSBWoI2xL3kDlQaIY9D6dnenU421/aSPWJBr8p7+
         jpkxISeLhuSUDm45J5WAcoZtMo9SDkFQFQLyK0/1+mPAwqi9Qa6PUmv2b4Zl7ysfgqxf
         RB+BT1LkBMzsaET28KaV8JSd/SCbuNh3RP9cPNiXEc8Mh+FDt5jTzovUPprwDBScSR9F
         mEcGZIn/Fcaeb8nQ01/BVEmwPehSHjOUXBB9C0NXxBZu+ZYjsqhShFWHq2urYUb/B6j6
         DaVA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of bot@kernelci.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=bot@kernelci.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of bot@kernelci.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=bot@kernelci.org
X-Google-Smtp-Source: AG47ELvvpbsGEp832UBhI6cZ85Gu2gREKeoqg3gxm0NWmB8zqOqXUpASikGFOikWynhA9+kA3vmmXg==
Message-ID: <5ab037a6.0f8d1c0a.2d612.1602@mx.google.com>
Date: Mon, 19 Mar 2018 15:20:22 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.4.y
X-Kernelci-Kernel: v4.4.122-135-gce9da67811cd
X-Kernelci-Report-Type: boot
X-Kernelci-Tree: stable-rc
In-Reply-To: <20180319171849.024066323@linuxfoundation.org>
References: <20180319171849.024066323@linuxfoundation.org>
Subject: Re: [PATCH 4.4 000/134] 4.4.123-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org
From: kernelci.org bot <bot@kernelci.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net,
 shuahkh@osg.samsung.com, patches@kernelci.org, ben.hutchings@codethink.co.uk,
 lkft-triage@lists.linaro.org, stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595390786580465385?=
X-GMAIL-MSGID: =?utf-8?q?1595406311639436182?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

stable-rc/linux-4.4.y boot: 44 boots: 0 failed, 41 passed with 3 offline (v=
4.4.122-135-gce9da67811cd)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.4.y/kernel/v4.4.122-135-gce9da67811cd/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.4.y=
/kernel/v4.4.122-135-gce9da67811cd/

Tree: stable-rc
Branch: linux-4.4.y
Git Describe: v4.4.122-135-gce9da67811cd
Git Commit: ce9da67811cd4122533dfb0384f899bcb6e4160e
Git URL: http://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git
Tested: 34 unique boards, 11 SoC families, 13 builds out of 178

Offline Platforms:

arm:

    exynos_defconfig:
        exynos5410-odroidxu: 1 offline lab
        exynos5800-peach-pi: 1 offline lab

    imx_v6_v7_defconfig:
        vf610-colibri-eval-v3: 1 offline lab

---
For more info write to <info@kernelci.org>
