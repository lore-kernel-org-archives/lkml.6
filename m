Return-Path: <bot@kernelci.org>
ARC-Seal: i=1; a=rsa-sha256; t=1524006184; cv=none;
        d=google.com; s=arc-20160816;
        b=ERgbsez7zL16ClnKG/SHgRinVF/fUTavJ6q4+ajx1Ph1O/UAT4oP7JK3mwqyDUfzy4
         Dd14JzIY1pezFHSfbxVMscXFAyrfYxzszryvAWtkkqhEpc4E+XAXeG/AmVItBJQp5cHH
         xcgYlfgEo9Huev1ZoO1nWGOOTrxIW61oRzp9cn8yfhd5Ak+F+lqjcgg12SkTc55KMDZO
         sL7FxNPf3tqmoklXi92JaeWpBuNigY+pvq/QW2qIxpaXzsFoFOt3Fncbse8CbrjavDIM
         s7zHhktO1wFnyVxi7OKPA9lZZuR7xuckUuSCznhGTVPLQHzfUuU5PerddGIVVzHYo9RS
         4miw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:from:to:subject:references:in-reply-to:content-transfer-encoding
         :mime-version:date:message-id:arc-authentication-results;
        bh=PI9GbQmg5O9GapFq38icecmW/sSBmd71Ej8t/rB3BmE=;
        b=KVRUjqSoYr78BTE8HNZP4tcdR890eRaRtQIxdiVGLPz2fOIePt0D+WP0rwiO8JMStA
         ZJUOOXp397w3FEsToRJMgRqlbrVOoHupaB+Z+DyrZepM06jC2IXkiIkjmBs88xb4CK1X
         7cKc5kN1rKy78YpMLtTKWGY/3eu2qD3t9Kkrm6OJwgW9QoBpEjLBVWYpYwjO0chCFrG8
         8nvFirIQ42DsSR/4XLb7O/2GQX5plbGvQlKDiiGaKs8Q/jHI+dUDVfRpdhRacR7Akzer
         WQoXVN/gUMNg+NkNu3d1h4fv4gJY9tzDJicV6lFSGXK8jx8rhf0wvavuCpk9dZJIc4wE
         zV2g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of bot@kernelci.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=bot@kernelci.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of bot@kernelci.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=bot@kernelci.org
X-Google-Smtp-Source: AIpwx48mZR2NOOz4z4WxytzcHUHRSSkej5LsoHtyAXqUOK/TdfR8z6yeDFC6BpWKhEb4VImnfUrnew==
Message-ID: <5ad67d27.a6a0df0a.a4bd2.b7e9@mx.google.com>
Date: Tue, 17 Apr 2018 16:03:03 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.9.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: boot
X-Kernelci-Kernel: v4.9.94-67-g148bd16b9893
In-Reply-To: <20180417155645.868055442@linuxfoundation.org>
References: <20180417155645.868055442@linuxfoundation.org>
Subject: Re: [PATCH 4.9 00/66] 4.9.95-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org
From: kernelci.org bot <bot@kernelci.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net,
 shuahkh@osg.samsung.com, patches@kernelci.org, ben.hutchings@codethink.co.uk,
 lkft-triage@lists.linaro.org, stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598010284891206038?=
X-GMAIL-MSGID: =?utf-8?q?1598036308451247646?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

stable-rc/linux-4.9.y boot: 52 boots: 1 failed, 48 passed with 3 untried/un=
known (v4.9.94-67-g148bd16b9893)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.9.y/kernel/v4.9.94-67-g148bd16b9893/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.9.y=
/kernel/v4.9.94-67-g148bd16b9893/

Tree: stable-rc
Branch: linux-4.9.y
Git Describe: v4.9.94-67-g148bd16b9893
Git Commit: 148bd16b989355ed27e01a6480c2548d0bb795e1
Git URL: http://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git
Tested: 26 unique boards, 11 SoC families, 15 builds out of 182

Boot Regressions Detected:

arm64:

    defconfig:
        r8a7795-salvator-x:
            lab-baylibre: failing since 7 days (last pass: v4.9.93 - first =
fail: v4.9.93-278-g1614c07609f0)

Boot Failure Detected:

arm64:

    defconfig
        r8a7795-salvator-x: 1 failed lab

---
For more info write to <info@kernelci.org>
