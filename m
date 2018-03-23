Return-Path: <bot@kernelci.org>
ARC-Seal: i=1; a=rsa-sha256; t=1521819645; cv=none;
        d=google.com; s=arc-20160816;
        b=h0VjvZBMYXah+pcAgza3ehWSvdqs5a8GhwLWgqA7AAWPJMJGehWswRhlM81yRKNfVJ
         h1+0UqSMgbeurPTtT3Tt16zkdw68FK8Wfh/qEPcqsBm0TTq+jq0rJ7CRJOszERv3NEvY
         r6BkCCvLZzYZDg0RBnMMu9RSxtXbybrInxPew7Xihdh2piXVw6ORTxh7YUYxlIS7wpzu
         NvkRg0x01zQwuQzOQhVt87YTlvB295QvXBOwRrzTkpUVJnU/1MavtoiKRejeeZmmMkwX
         7MfYOgim57qbQqAJ3dD1mMNEDXgy1CTCjNAsMQ1FEPvSArSwSftRRrTmwUzzePZGZPFC
         bFmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:from:to:subject:references:in-reply-to:content-transfer-encoding
         :mime-version:date:message-id:arc-authentication-results;
        bh=VRudNiDhxAL7+EL23RQ3nkK65BO7kcslHh2orGXaMVY=;
        b=RjSa7hC52EWI0AIo2F9SA8LfMDMntDEvTIR+NzM6IbzhQdAFBjbt5ykJH4JpWa7uFm
         UcktT4lk7Fw/o6TQj4pFzmopqltoIMAW40G8aFjMccpg612AJ/Hp0VKPgF8G/zyjCzCk
         a0nlOHMT28kRUgvWXTgwcbrtnxXJIJRs/lqy0EZR/Mr0nIuskt6sUITGtf0mxUIp2GQ7
         V3TQDU/ATO0ymGjl5bbXlhWlaUjsw2HlInueMaIeFTTBIHxYu8rLlSK1GkBW+4LLslYM
         FTk9oOxIXLFoQ9yPSJOQAZX5FBnjQxlG7/7xCmwrSuslOLbYA3MlXcFV5+wWeNhQqJY1
         wyBg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of bot@kernelci.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=bot@kernelci.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of bot@kernelci.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=bot@kernelci.org
X-Google-Smtp-Source: AG47ELumsr/952qHYRrVtlm6A99XRrYFYPs2FAWe4v0l7s2pU87T8T/WCPTAGZu5LInPlbPZ4xB96A==
Message-ID: <5ab51ffb.0eaddf0a.850f5.80ba@mx.google.com>
Date: Fri, 23 Mar 2018 08:40:43 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.14.y
X-Kernelci-Kernel: v4.14.29-78-g4a9cf243a20b
X-Kernelci-Report-Type: boot
X-Kernelci-Tree: stable-rc
In-Reply-To: <20180323094142.260022880@linuxfoundation.org>
References: <20180323094142.260022880@linuxfoundation.org>
Subject: Re: [PATCH 4.14 00/77] 4.14.30-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org
From: kernelci.org bot <bot@kernelci.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net,
 shuahkh@osg.samsung.com, patches@kernelci.org, ben.hutchings@codethink.co.uk,
 lkft-triage@lists.linaro.org, stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595722175278000467?=
X-GMAIL-MSGID: =?utf-8?q?1595743556391704524?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

stable-rc/linux-4.14.y boot: 61 boots: 0 failed, 56 passed with 4 offline, =
1 untried/unknown (v4.14.29-78-g4a9cf243a20b)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.14.y/kernel/v4.14.29-78-g4a9cf243a20b/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.14.=
y/kernel/v4.14.29-78-g4a9cf243a20b/

Tree: stable-rc
Branch: linux-4.14.y
Git Describe: v4.14.29-78-g4a9cf243a20b
Git Commit: 4a9cf243a20b29928986828f79faa229a4e57100
Git URL: http://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git
Tested: 49 unique boards, 18 SoC families, 14 builds out of 185

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

---
For more info write to <info@kernelci.org>
