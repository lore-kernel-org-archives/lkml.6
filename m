Return-Path: <bot@kernelci.org>
ARC-Seal: i=1; a=rsa-sha256; t=1523487769; cv=none;
        d=google.com; s=arc-20160816;
        b=PnciofNhUjOPbmtkOTw+nOFETIXXXOSg/GSCgMn+u7WefJiadfpJ2wgc5iVLIxRixO
         FP0bh9qXesafZug3lr44nWCJWViHu9YSB11D/N+BCmPsOcqkuhB38wMW63niacQq0v4S
         N4Z009n7Oe5mTcqAk5higq+ly7A6DB2jvSlGBQ033PSttJxUO/5PvSuspxMTBEJkTe7W
         x0d1CPD4FpfJpcDoYL+WxCEYBg3y9zd4UU0QxDulPvTkFk1vG+Vumw7JHRXBH3e/NbrV
         zTyeJ/lhVKDFQxAQYS4kbaA2i4nicJGCNy4asgEUczQv43n8hmax6jqEIWtXV/q5z9wS
         +sBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:from:to:subject:references:in-reply-to:content-transfer-encoding
         :mime-version:date:message-id:arc-authentication-results;
        bh=HaSa101QP5Oih9AUeNx5obglhhXOtwZXf59YNaR3b68=;
        b=eql+Z2lEV0XvuDzTNML8EeNzG6/nmJrB1UxP0xjtO0MjtGIBx3Td+Ysw7PFeaHnvTo
         Bkx6aSEB1I2o7qvKevr1MRV6zuaQEzo7pMGvR30a3GI70UO/2lDhSQWljOCgOIjtXE3o
         bsFOY4EWQzraOWhAk11EHgK9AjoMWqKUgdpBE1QbyViZ9TuncqQjmi+7fUBD7ykI5zGY
         lXsJsEfsJM85l/VtJC17RABABW2FCNUPRijO2HoS+oAgbc/pgxk/5pOF6LkVVtrlxU9O
         Al6LZkjGp3P/8KKoNJCugfO5aAm07O8jk9H6EEttSu65A9CzSXUHD48O0UVDckhImINJ
         O3Uw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of bot@kernelci.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=bot@kernelci.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of bot@kernelci.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=bot@kernelci.org
X-Google-Smtp-Source: AIpwx494Y4mU5aqyB5ZHMeddek3KndQUpqHRR4phC5I9guz1n5I39rHAwbSNQoETCqZ6+7zUMNJArA==
Message-ID: <5ace9417.3388df0a.e75fb.585e@mx.google.com>
Date: Wed, 11 Apr 2018 16:02:47 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-3.18.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: boot
X-Kernelci-Kernel: v3.18.104-122-ga2dc3f94f95b
In-Reply-To: <20180411183456.195010921@linuxfoundation.org>
References: <20180411183456.195010921@linuxfoundation.org>
Subject: Re: [PATCH 3.18 000/121] 3.18.105-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org
From: kernelci.org bot <bot@kernelci.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net,
 shuahkh@osg.samsung.com, patches@kernelci.org, ben.hutchings@codethink.co.uk,
 lkft-triage@lists.linaro.org, stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597476070898180660?=
X-GMAIL-MSGID: =?utf-8?q?1597492710474200095?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

stable-rc/linux-3.18.y boot: 41 boots: 1 failed, 40 passed (v3.18.104-122-g=
a2dc3f94f95b)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-3.18.y/kernel/v3.18.104-122-ga2dc3f94f95b/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-3.18.=
y/kernel/v3.18.104-122-ga2dc3f94f95b/

Tree: stable-rc
Branch: linux-3.18.y
Git Describe: v3.18.104-122-ga2dc3f94f95b
Git Commit: a2dc3f94f95bea4b325a1c8025630a9c430aa83a
Git URL: http://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git
Tested: 18 unique boards, 9 SoC families, 13 builds out of 183

Boot Regressions Detected:

arm:

    multi_v7_defconfig:
        socfpga_cyclone5_socrates:
            lab-pengutronix: new failure (last pass: v3.18.104-103-g472e131=
a3eb9)

Boot Failure Detected:

arm:

    multi_v7_defconfig
        socfpga_cyclone5_socrates: 1 failed lab

---
For more info write to <info@kernelci.org>
