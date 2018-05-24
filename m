Return-Path: <bot@kernelci.org>
ARC-Seal: i=1; a=rsa-sha256; t=1527177987; cv=none;
        d=google.com; s=arc-20160816;
        b=V0avN29q0o8b9nU31jzjR9BZlUxXdZQQ98mwLPx/fT3likdHkmXJ2J46q1x9GLgULA
         1kIU+AxG3KCKsly9nqXQK3RVRQVPjs9xikrAtYvSC9vgmIg4AzEdddnAgNxGpccgkht4
         LTfO6HHPrc8ujteAnoZViKndLLydBNM8TuTJ+gpa6GSFAokM6VxTdflI4xxwUIuXrdF4
         JTQ+7HCpRYzIk12GodV0pIxeFOxwsB1ZzM1cc8l/K8KSukCa2GMWkOXBeSGOwV9lDNr3
         qga++5MLoJUKeGdyBa2/xEiGW/IldvGr61kkHEtXwSxVKxEpKV5y8cO0Uj5IdaatXIUC
         5UHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:from:to:subject:references:in-reply-to:content-transfer-encoding
         :mime-version:date:message-id:arc-authentication-results;
        bh=Z4Vs5Qi0j1NluxX7glG5Gcno3f4crdvzJ+BqQHPDEw4=;
        b=wTGfDOHeJUL4Fe33XKszvXX86Kk5krWIcuVS6T2T3uU/nE5soVsNm/a7UIxcoWcss5
         x0iyImDkKZTyV9wxpHLVbz2w44er3JXAVbPXVV6M2/hwsfPexEw0uiuVGkqV0FvPFvAv
         gtbgYvcXNToMga0LSc5IpIUxoD2S0vZoMzweTSWynlNc2DuBWwQP1PSWjvb4BsDjSYR1
         H0xXDex9tygw+TL0I9bauk5S70FRe1UClQ5j1TC3ZFhjbukVTnXi7uAvCd5uPf+5Vftv
         INCP0Bf6pllfgsRJzifca5AEjs+Imyxcb6YRQJy92D2Gui6hHwhoYrWDCEA+EgQnETNI
         SVMg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of bot@kernelci.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=bot@kernelci.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of bot@kernelci.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=bot@kernelci.org
X-Google-Smtp-Source: AB8JxZrdTghHRRpF23WhAwphKxom9vZPbZiwI41T2NxHCzVVJBrblkvMSoMKSqEVVAQplYsbRMCNRw==
Message-ID: <5b06e302.1c69fb81.36a3f.35d0@mx.google.com>
Date: Thu, 24 May 2018 09:06:26 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: stable-rc
X-Kernelci-Branch: linux-4.14.y
X-Kernelci-Report-Type: boot
X-Kernelci-Kernel: v4.14.43-166-ga3881b7a4d3c
In-Reply-To: <20180524093621.979359379@linuxfoundation.org>
References: <20180524093621.979359379@linuxfoundation.org>
Subject: Re: [PATCH 4.14 000/165] 4.14.44-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org
From: kernelci.org bot <bot@kernelci.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net,
 shuah@kernel.org, patches@kernelci.org, ben.hutchings@codethink.co.uk,
 lkft-triage@lists.linaro.org, stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1601338601440343923?=
X-GMAIL-MSGID: =?utf-8?q?1601362185614255019?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

stable-rc/linux-4.14.y boot: 120 boots: 1 failed, 114 passed with 5 offline=
 (v4.14.43-166-ga3881b7a4d3c)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.14.y/kernel/v4.14.43-166-ga3881b7a4d3c/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.14.=
y/kernel/v4.14.43-166-ga3881b7a4d3c/

Tree: stable-rc
Branch: linux-4.14.y
Git Describe: v4.14.43-166-ga3881b7a4d3c
Git Commit: a3881b7a4d3c9991599672e83cbfb2eb26359dc8
Git URL: http://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git
Tested: 63 unique boards, 24 SoC families, 15 builds out of 185

Boot Regressions Detected:

arm64:

    defconfig:
        meson-gxl-s905x-khadas-vim:
            lab-baylibre: failing since 29 days (last pass: v4.14.26-140-g2=
a1700a4929f - first fail: v4.14.36-184-g3cd53e436ee2)

Boot Failure Detected:

arm64:

    defconfig
        meson-gxl-s905x-khadas-vim: 1 failed lab

Offline Platforms:

arm:

    imx_v6_v7_defconfig:
        imx7s-warp: 1 offline lab

    multi_v7_defconfig:
        imx7s-warp: 1 offline lab

arm64:

    defconfig:
        meson-gxbb-p200: 1 offline lab
        meson-gxl-s905x-khadas-vim: 1 offline lab
        sun50i-a64-pine64-plus: 1 offline lab

---
For more info write to <info@kernelci.org>
