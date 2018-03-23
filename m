Return-Path: <bot@kernelci.org>
ARC-Seal: i=1; a=rsa-sha256; t=1521819644; cv=none;
        d=google.com; s=arc-20160816;
        b=hBwu0IVvb5FYFr4kdxvV96+o1zZSb3FonUmaberkq8az6BsuSrHlc3PlhxAhRQ8NYg
         +hCNQSfPg3UihQsW/XYf41rwjzVZlWrB1jdPcOtmuE6LojO4mrtv87dCUdDH618LEhb2
         qTLBxrt3TbuSY8Dmy1Q15/q/99+SeQSWBBP12XIgFJTagqV2gYJYqKejkkcnXYTzstYM
         711UNHynJPVR1WFO6J6FUk3iIbuM+yThnhtwu2m0wg3FLLcmhhAY7hBI74ZmEwJLkK4t
         PTmZNZcrEQUP8af2sDQkZScVE6wcD1o4/3Lx3wooJb5DDb9rcZaG+FBdvN6ao1BKzIic
         FBTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:from:to:subject:references:in-reply-to:content-transfer-encoding
         :mime-version:date:message-id:arc-authentication-results;
        bh=k1/i53xJJWYN0P+xwp3H24Pff3QgTryBbQYIKt5QQRE=;
        b=awK5RbEjq0yCZEOEwSJgB+w8T8e035dOHAk6ujg14gmnp67YTwoP5roBp6ObqoYcui
         CaYKTdAcThr83Ge5bZpdFO2oQEzaC921ubLqDpbkeDEJKpIVaDHPgO7v+mykTcgYteTu
         8fN9eA+i/bAMxCZKvoppXUCT1l5LgSUWqdFjY7XCquyZNWvEYqW4dQEZ1iB/BnWu8IFL
         w7aqkq+H6uSEx9nRF08DTxkUKkcIEd2qSCkJwzYpsi6k9AL3wVmsGT19oZkurU3kyOD/
         4/ZYlUFy1X7lDY5w7w4okq69bEkjgoGOWDGGiJmNmppPBOL1KpE0z8lHVufceVIdPaag
         3WCQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of bot@kernelci.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=bot@kernelci.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of bot@kernelci.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=bot@kernelci.org
X-Google-Smtp-Source: AG47ELvoIUoGtoxlcTu73SuXyp1Tbd9DkiCFGkdHOxBizgjzXi4xwvGURqpH6GHVbknmNgfo3RryIA==
Message-ID: <5ab51ffb.464a1c0a.239cd.b8d3@mx.google.com>
Date: Fri, 23 Mar 2018 08:40:43 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.9.y
X-Kernelci-Kernel: v4.9.89-178-g8d6f4aae473a
X-Kernelci-Report-Type: boot
X-Kernelci-Tree: stable-rc
In-Reply-To: <20180323094205.090519271@linuxfoundation.org>
References: <20180323094205.090519271@linuxfoundation.org>
Subject: Re: [PATCH 4.9 000/177] 4.9.90-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org
From: kernelci.org bot <bot@kernelci.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net,
 shuahkh@osg.samsung.com, patches@kernelci.org, ben.hutchings@codethink.co.uk,
 lkft-triage@lists.linaro.org, stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595722405965668152?=
X-GMAIL-MSGID: =?utf-8?q?1595743555808948846?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

stable-rc/linux-4.9.y boot: 117 boots: 0 failed, 106 passed with 7 offline,=
 4 untried/unknown (v4.9.89-178-g8d6f4aae473a)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.9.y/kernel/v4.9.89-178-g8d6f4aae473a/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.9.y=
/kernel/v4.9.89-178-g8d6f4aae473a/

Tree: stable-rc
Branch: linux-4.9.y
Git Describe: v4.9.89-178-g8d6f4aae473a
Git Commit: 8d6f4aae473a1fd5c670f7dfb22c303a9d391a9a
Git URL: http://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git
Tested: 60 unique boards, 21 SoC families, 19 builds out of 183

Offline Platforms:

arm:

    tegra_defconfig:
        tegra20-iris-512: 1 offline lab

    multi_v7_defconfig:
        exynos5410-odroidxu: 1 offline lab
        exynos5800-peach-pi: 1 offline lab
        tegra20-iris-512: 1 offline lab

    exynos_defconfig:
        exynos5410-odroidxu: 1 offline lab
        exynos5800-peach-pi: 1 offline lab

arm64:

    defconfig:
        meson-gxbb-odroidc2: 1 offline lab

---
For more info write to <info@kernelci.org>
