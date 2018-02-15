Return-Path: <bot@kernelci.org>
ARC-Seal: i=1; a=rsa-sha256; t=1518731820; cv=none;
        d=google.com; s=arc-20160816;
        b=n5WMJ9dhtLwvf0wP0NFwjP/QuFoigL3Cq8te9GLzEV9Ti5Qg5AsAiKmBo4NjakmgrX
         goP3pBQpBvjVealKbtJClDxr+2MW1F+6vrVrD+8FWCOGSJhtQ+gBfFrCQSlbI4SF7Fyg
         elVnT0rJhMAZHMO/gOZ4/nzuUt7EohoWLHei0V+tsUxm7lFg5/G9RxZjGoESTXINGf9C
         d2hCP38TXtInM7q/55y39KW4glyCxESceTN49YEDCc14V/B5XuYiFwKnpJIGVhQfR+RY
         6qh97Gh2Or0Pe8qu67MMn+zlo1cSWTrch5V9KowUtKKstyDq1Di777e3knqzSzyB077X
         o6zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:from:to:subject:references:in-reply-to:content-transfer-encoding
         :mime-version:date:message-id:arc-authentication-results;
        bh=OrC6aBz0I1eUaiGcs33BxFZxsFIV0jAAzb+DW8ZsizY=;
        b=pcx0n4LinXm/ve+3lQA1O086n8UzURlarmD+7lcYE8sPHJnPuvXlntQwdDR20tbniO
         L5g4ozfUyPwNsW1/vfL310kQHh8fdRtwG+feWOItMWvNZLo6fKDyvVmCQi6va/+pQVKr
         WrDz9Y1L0igkYp1aDx/q4apKxdqgclsh+z491Zl+N9FmVUwYF4ay3FeEr6TjdJg4NWr5
         TZ50j4prJbBgGRet4OqlEqfeeFN/CSkbg1YSer9lbnK3PNQqKYMK6yGlfrZuCmcnm71c
         AvcvgR79eMZSDOFZsT1H3p3knPkXTozFeJcUGE1O+n6Tu34gRy3Jh0HplrtbNvtTL5yb
         oaeg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of bot@kernelci.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=bot@kernelci.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of bot@kernelci.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=bot@kernelci.org
X-Google-Smtp-Source: AH8x2241xzF31VEST1ZrPg1ftcQ+tbJ8xBfUJKH/S5CxhQYoGOZoAw0QBbSGzJgvuhm6jhBW6PUf1w==
Message-ID: <5a86022a.4ed11c0a.6443e.585b@mx.google.com>
Date: Thu, 15 Feb 2018 13:56:58 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v4.4.115-109-gf235d122836c
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: boot
X-Kernelci-Branch: linux-4.4.y
In-Reply-To: <20180215151222.267507937@linuxfoundation.org>
References: <20180215151222.267507937@linuxfoundation.org>
Subject: Re: [PATCH 4.4 000/108] 4.4.116-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org
From: kernelci.org bot <bot@kernelci.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net,
 shuahkh@osg.samsung.com, patches@kernelci.org, ben.hutchings@codethink.co.uk,
 lkft-triage@lists.linaro.org, stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592480831775234699?=
X-GMAIL-MSGID: =?utf-8?q?1592505737191574833?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

stable-rc/linux-4.4.y boot: 87 boots: 0 failed, 82 passed with 4 offline, 1=
 conflict (v4.4.115-109-gf235d122836c)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.4.y/kernel/v4.4.115-109-gf235d122836c/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.4.y=
/kernel/v4.4.115-109-gf235d122836c/

Tree: stable-rc
Branch: linux-4.4.y
Git Describe: v4.4.115-109-gf235d122836c
Git Commit: f235d122836c25ae9e99721537bcb3f9e01ae7c6
Git URL: http://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git
Tested: 44 unique boards, 18 SoC families, 14 builds out of 178

Boot Regressions Detected:

arm:

    omap2plus_defconfig:
        am335x-boneblack:
            lab-collabora: new failure (last pass: v4.4.111-72-g34e9e548f21=
9)

Offline Platforms:

arm:

    multi_v7_defconfig:
        exynos5410-odroidxu: 1 offline lab
        sun4i-a10-cubieboard: 1 offline lab

    sunxi_defconfig:
        sun4i-a10-cubieboard: 1 offline lab

    exynos_defconfig:
        exynos5410-odroidxu: 1 offline lab

Conflicting Boot Failure Detected: (These likely are not failures as other =
labs are reporting PASS. Needs review.)

arm:

    omap2plus_defconfig:
        am335x-boneblack:
            lab-baylibre-seattle: PASS
            lab-collabora: FAIL

---
For more info write to <info@kernelci.org>
