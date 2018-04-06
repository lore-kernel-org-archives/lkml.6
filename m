Return-Path: <bot@kernelci.org>
ARC-Seal: i=1; a=rsa-sha256; t=1523036529; cv=none;
        d=google.com; s=arc-20160816;
        b=iDcBkz1Eu6DLJ5Pm7T5ng/sD6jteoLKMMJfe7TCAZp8ybhdL8nl0IHM7fxQaiA3xCR
         LO6OBBoJ2e2lwxVcltqESECfY9m0QJ/bn1JSbHGsPA6tvj8ayt7+nQyG5FafKx3n0ZYK
         OIg5VmZlHJTuYigXNwvyhPQFsjzspUFq7zqKFqcoLwPyPda62AqmwqT0gpnwmSmTclWN
         i9U48bV0eCBPJWXJkoNC5awDaw/HNJKb4GIG/Q3m6eW/USiWzf6dfZFU1SidCDvXrBdC
         KjoS26VvtNUREnNhALZjCR/0F2TEIjmParvXnxtzmEIAQJVBJFjsOsp5oKQzbulXCl7G
         m7mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:from:to:subject:references:in-reply-to:content-transfer-encoding
         :mime-version:date:message-id:arc-authentication-results;
        bh=tUfAQXzlb1h3tI6HNoA3XP2UuTDmSMENCwIsf1coI4s=;
        b=Thp2IVJGXpvJ6i4kfpmoGtYR+KT/iJJFgEdhGn2aWK51qPIIDtc5E4wx4ZldKn0pLD
         s2nrh8r/ZEV1p50EzG8jDaXBpKnwkdxtENMmR3tb5nv6SO3O8Vyw5ZL/yYkRdJzrKDm9
         DgwU7i+TJfqBMZfTUMhI2BVX0QiEeL5DJo/FM3p4AQ9HPWjtKXHanqe/Yo4zSy0jXgjy
         Xnx8xsbhAMT7XAxdCDEuI11zFrcRPljvtVpbSx0mA4BHhqf7F109C0+8peNJiyTdfr9b
         lIcgRV3+QlytrrHbR2QCwyg/yEEAUSYhCWUcY9x8T/MkF/jFayeJn6Un5WnKyNGGTt8U
         d/3A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of bot@kernelci.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=bot@kernelci.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of bot@kernelci.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=bot@kernelci.org
X-Google-Smtp-Source: AIpwx4+r52CMZyPDdn6rlkicvWR9tIdwbvJVl4YIOIGIcjGUpBMZCJPyEuqwrceM5yJ2MqjGlsJqxw==
Message-ID: <5ac7b170.88c0df0a.6b186.3e3c@mx.google.com>
Date: Fri, 06 Apr 2018 10:42:08 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.15.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: boot
X-Kernelci-Kernel: v4.15.15-73-g1abb272b72b7
In-Reply-To: <20180406084349.367583460@linuxfoundation.org>
References: <20180406084349.367583460@linuxfoundation.org>
Subject: Re: [PATCH 4.15 00/72] 4.15.16-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org
From: kernelci.org bot <bot@kernelci.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net,
 shuahkh@osg.samsung.com, patches@kernelci.org, ben.hutchings@codethink.co.uk,
 lkft-triage@lists.linaro.org, stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597004407519340779?=
X-GMAIL-MSGID: =?utf-8?q?1597019552391006083?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

stable-rc/linux-4.15.y boot: 65 boots: 0 failed, 62 passed with 3 untried/u=
nknown (v4.15.15-73-g1abb272b72b7)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.15.y/kernel/v4.15.15-73-g1abb272b72b7/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.15.=
y/kernel/v4.15.15-73-g1abb272b72b7/

Tree: stable-rc
Branch: linux-4.15.y
Git Describe: v4.15.15-73-g1abb272b72b7
Git Commit: 1abb272b72b7242da1c7b6bb5a57bfe7d6ac15e1
Git URL: http://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git
Tested: 32 unique boards, 14 SoC families, 15 builds out of 185

---
For more info write to <info@kernelci.org>
