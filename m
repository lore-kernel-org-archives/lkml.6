Return-Path: <bot@kernelci.org>
ARC-Seal: i=1; a=rsa-sha256; t=1524861841; cv=none;
        d=google.com; s=arc-20160816;
        b=b5ViJaeLwq8HWeSE3RO0yL2D/1+vS1uPPbox1EG4JVfLflUrLVVDid864dAFKlAYdU
         XmqVPbdfNNoabld0BSw8DrfoJnRt82Dp8x76x60t2NMYEyAMy38w8u1vP7Z6d8BMkSMI
         KdetmdYvo6o9FAfWpjVqh+8qnrw2waZVzDxeZf3yGaAx3Q9SDTPSYthDrJwXvfPnUhDV
         0CeekEmJModmQC1n4eZbuAq+P+TIb5v0mUl7IpjMSFpYHduLsXJI4I8P06kOO1+Uc8in
         ozMJM/Eos6zPmuC3hpsIUPO/XrMIjs1FaLxNVOSgpkV7uzVlN7fDskhIIrpnv3drQO/I
         0lvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:from:to:subject:references:in-reply-to:content-transfer-encoding
         :mime-version:date:message-id:arc-authentication-results;
        bh=wJmyeNL9b2ewwkX/JjWFuHpCd3pAzRyt3JeYAmRFaLw=;
        b=m+CjWS4G3vEmQp6Pa/NAAxyUAOUCOuzf66PTXpZ/zyktkSTV57+3BSpx/0MMY/afjm
         Yy6RwuuZqep3rcTaIbMZ2a9XuXmV8XlcrKhbcr6BcQhl4BgENHKTu5e2YP9ZTMGXfwej
         SBBMOhazD/ENbzBatGfNjkP/UTqGqOcgROYmvEnEcRhB6Bz55p7UpPFK7J16xEArKAyT
         /+u2cGo93NnjAVScWha3MN0/Ay5fTkVq3ndVVF6FWIr7PVQUFlNavzzjPKXYARoyy8h1
         6rgukhLYZUqa2WzyWldJ84spLP1h432z3dc8RWA86SNcl7OjjgakSDYKt8UY/FsG9z1W
         u+xg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of bot@kernelci.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=bot@kernelci.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of bot@kernelci.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=bot@kernelci.org
X-Google-Smtp-Source: AB8JxZpsonPWF/axLPSyUsVIkHf+AvNuLkD1LzWrBGMzJ4Rpk6pNEC2c8q0IpNIXBBLaUaZs8OWCJw==
Message-ID: <5ae38b90.0aab1c0a.668a5.e2dc@mx.google.com>
Date: Fri, 27 Apr 2018 13:44:00 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.9.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: boot
X-Kernelci-Kernel: v4.9.96-75-ge90f47651ef9
In-Reply-To: <20180427135709.899303463@linuxfoundation.org>
References: <20180427135709.899303463@linuxfoundation.org>
Subject: Re: [PATCH 4.9 00/74] 4.9.97-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org
From: kernelci.org bot <bot@kernelci.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net,
 shuah@kernel.org, patches@kernelci.org, ben.hutchings@codethink.co.uk,
 lkft-triage@lists.linaro.org, stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598908317228713004?=
X-GMAIL-MSGID: =?utf-8?q?1598933530750694651?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

stable-rc/linux-4.9.y boot: 143 boots: 1 failed, 135 passed with 7 offline =
(v4.9.96-75-ge90f47651ef9)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.9.y/kernel/v4.9.96-75-ge90f47651ef9/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.9.y=
/kernel/v4.9.96-75-ge90f47651ef9/

Tree: stable-rc
Branch: linux-4.9.y
Git Describe: v4.9.96-75-ge90f47651ef9
Git Commit: e90f47651ef96205f1e6eb07f155ffa7470b8110
Git URL: http://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git
Tested: 71 unique boards, 23 SoC families, 19 builds out of 183

Boot Regressions Detected:

arm64:

    defconfig:
        r8a7795-salvator-x:
            lab-baylibre: new failure (last pass: v4.9.96)

Boot Failure Detected:

arm64:

    defconfig
        r8a7795-salvator-x: 1 failed lab

Offline Platforms:

arm:

    tegra_defconfig:
        tegra20-iris-512: 1 offline lab

    multi_v7_defconfig:
        qcom-apq8064-cm-qs600: 1 offline lab
        qcom-apq8064-ifc6410: 1 offline lab
        tegra20-iris-512: 1 offline lab

    qcom_defconfig:
        qcom-apq8064-cm-qs600: 1 offline lab
        qcom-apq8064-ifc6410: 1 offline lab

arm64:

    defconfig:
        apq8016-sbc: 1 offline lab

---
For more info write to <info@kernelci.org>
