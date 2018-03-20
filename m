Return-Path: <bot@kernelci.org>
ARC-Seal: i=1; a=rsa-sha256; t=1521504026; cv=none;
        d=google.com; s=arc-20160816;
        b=IcaMPANCqH3fTCXcRQOvRov7jOhQ1if4m1u8BpuPfOQn72SrwUZvpz+x1UvYzGwEjJ
         a57QYUOutD6NpsS/bMOFYcSZC6uggXnejXwDPj92x+MFihxoy9GLrj67HEWLs2Gl3Rlv
         4eybfwlV4HT6LgzbYBXtFjPZV4q8YInGDqyb0PXEOtH5rTSrxlKj0dYrbRZQiX89eXBQ
         YRRLbNV5m3L1vtD2EaDxc9n1ZXFHTZpjep81K5pNin30CepvLQzxwoespDTB+6sN/+bS
         u3u3XOaEkj3zRvr2xBajRVOVChI7JU2YGJig7bqVy5/q62otCRCAj3c4ark5HonpN932
         DvhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:from:to:subject:references:in-reply-to:content-transfer-encoding
         :mime-version:date:message-id:arc-authentication-results;
        bh=6KcTKEY8lEyI1HDtI2TbeROLpT78WUOZm7P0SIh/xQE=;
        b=JnUFj6KKprD9TpkJ4iVI0oBwQ4UsigWXhTBiS6fuxEd6jcEBRcgI0j00Ykx+n6IrBC
         t9oQEmhJvu55iBx6s4Phe+ndd5XtMqktVkep+XAePOCdGiL5yi33n4FFcvY1z7YckCm5
         qCfudt3lSKC8Hb4gApvg759pOS8NXDrN952AskR6oSka0MJu/yNxKJdyNROamapXNaC5
         SPQbWTq8WBrt/vfFnkm+YWQY/LqI78IdGoZhNB6QC2uV3WryTvBuEbbhdCtGxbmOXTIR
         a9rhvqeslFP80LE3qWRJS2sN7D6CLJuQ2l2Ho5uV+5oI3tYEyukDm9/zpzKFyTpNS7XI
         Pz9A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of bot@kernelci.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=bot@kernelci.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of bot@kernelci.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=bot@kernelci.org
X-Google-Smtp-Source: AG47ELstSL61Ig2g+z4uTkFbuP81+6bzOdR8ibFej9xpFWlGkxKKmXv3PPxtFKuepXU/6wuWQhc9ow==
Message-ID: <5ab04f19.103e1c0a.a9e4f.3f24@mx.google.com>
Date: Mon, 19 Mar 2018 17:00:25 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.9.y
X-Kernelci-Kernel: v4.9.88-242-g0568177724e0
X-Kernelci-Report-Type: boot
X-Kernelci-Tree: stable-rc
In-Reply-To: <20180319180751.172155436@linuxfoundation.org>
References: <20180319180751.172155436@linuxfoundation.org>
Subject: Re: [PATCH 4.9 000/241] 4.9.89-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org
From: kernelci.org bot <bot@kernelci.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net,
 shuahkh@osg.samsung.com, patches@kernelci.org, ben.hutchings@codethink.co.uk,
 lkft-triage@lists.linaro.org, stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595391137042363427?=
X-GMAIL-MSGID: =?utf-8?q?1595412606377899697?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

stable-rc/linux-4.9.y boot: 35 boots: 0 failed, 30 passed with 4 offline, 1=
 untried/unknown (v4.9.88-242-g0568177724e0)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.9.y/kernel/v4.9.88-242-g0568177724e0/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.9.y=
/kernel/v4.9.88-242-g0568177724e0/

Tree: stable-rc
Branch: linux-4.9.y
Git Describe: v4.9.88-242-g0568177724e0
Git Commit: 0568177724e0610f4592a7e927085b06481e52f4
Git URL: http://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git
Tested: 28 unique boards, 8 SoC families, 12 builds out of 183

Offline Platforms:

arm:

    davinci_all_defconfig:
        dm365evm,legacy: 1 offline lab

    exynos_defconfig:
        exynos5410-odroidxu: 1 offline lab
        exynos5800-peach-pi: 1 offline lab

    imx_v6_v7_defconfig:
        vf610-colibri-eval-v3: 1 offline lab

---
For more info write to <info@kernelci.org>
