Return-Path: <bot@kernelci.org>
ARC-Seal: i=1; a=rsa-sha256; t=1517868966; cv=none;
        d=google.com; s=arc-20160816;
        b=IXYQvvD9xdY2gx2mgq/vcP9dXuM5GC3VGNUKlKBd7BtIpQbiY/GN3Las0T/enEjwF7
         0WFbmzJTrYqxgFaKTAoPkYS46o2YThf1ijL1tjQYslKaxlJBjYhsiLOi0FCBK2isoiQz
         ZAPPfK9blfaPr4zpVZZrtB6t0hyPqo4NwPhy8tiOp/Lssql6cI95Jidn43fGQDfStP8y
         qL8JcvAKg/7l7JqYoicsOIWuKg81CvHwHr5bbGzNrnvkIj/gpbxGjeqmT8kw2lxAFcTv
         i1fmvWN1nqZhzpSqDHHRNcV69bhgfIdytyGOIqXELcoN35dPM1LYYS6A0WL5F2v8ZsJg
         plBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:from:to:subject:references:in-reply-to:content-transfer-encoding
         :mime-version:date:message-id:arc-authentication-results;
        bh=IQWPLX3bC7est4NJsqlzcblZUDlsUksLTnTXugg6uoo=;
        b=FrPtNrISvRqYddrAC7p6zKLS1DmXhVDjoHd0QJ/vW16tm3F+dskYh82WlHvcA/7yAY
         Sb/Tvt71nCNhFKSU/RKH3u+igw8bGcsVFXwWzONp/7BID8dMef8M/BnYzAyVtajaMOCR
         piwQn9Gd8yoxyHnlemfPO+WuFwAkOb88aGYsHgNMRiKBzVsm2RXQBRvKsQABzZkt3VCV
         4JOi+hICK1l1oJoeWRCWqayhfCKsLxlHvzCddc5kgvafHL8PI12ZKtt3/5d7lXlOJWPV
         LTriLwxyU3u4hRIzA4W1ARYqGY+IENKQaT1lWzAA1IiNdJZlHkvY948p1I4DHkz/W6U+
         lYIg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of bot@kernelci.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=bot@kernelci.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of bot@kernelci.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=bot@kernelci.org
X-Google-Smtp-Source: AH8x224Rye0BM0g6zJe2xukPTh3czmw4dUx3RVeu69mPDbrjWT+Q3yjxb1hkSPtojxp/h+WlhF8Yzg==
Message-ID: <5a78d7a4.85631c0a.ab1cd.ccaa@mx.google.com>
Date: Mon, 05 Feb 2018 14:16:04 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-3.18.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v3.18.93-36-gfc50e0e1d16b
X-Kernelci-Report-Type: boot
In-Reply-To: <20180205182351.774761393@linuxfoundation.org>
References: <20180205182351.774761393@linuxfoundation.org>
Subject: Re: [PATCH 3.18 00/36] 3.18.94-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org
From: kernelci.org bot <bot@kernelci.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net,
 shuahkh@osg.samsung.com, patches@kernelci.org, ben.hutchings@codethink.co.uk,
 lkft-triage@lists.linaro.org, stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591586546649955538?=
X-GMAIL-MSGID: =?utf-8?q?1591600969258182663?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

stable-rc/linux-3.18.y boot: 57 boots: 3 failed, 52 passed with 2 untried/u=
nknown (v3.18.93-36-gfc50e0e1d16b)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-3.18.y/kernel/v3.18.93-36-gfc50e0e1d16b/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-3.18.=
y/kernel/v3.18.93-36-gfc50e0e1d16b/

Tree: stable-rc
Branch: linux-3.18.y
Git Describe: v3.18.93-36-gfc50e0e1d16b
Git Commit: fc50e0e1d16b163b620eedaa5906f610fee2e8cc
Git URL: http://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git
Tested: 28 unique boards, 12 SoC families, 12 builds out of 181

Boot Regressions Detected:

arm:

    exynos_defconfig:
        exynos5420-arndale-octa:
            lab-baylibre-seattle: failing since 9 days (last pass: v3.18.92=
-20-gabb170c68d61 - first fail: v3.18.92-36-gda6d5b92b55f)
        exynos5800-peach-pi:
            lab-collabora: new failure (last pass: v3.18.93-25-gb9c290b9fa6=
4)

    multi_v7_defconfig:
        exynos5800-peach-pi:
            lab-collabora: new failure (last pass: v3.18.93-25-gb9c290b9fa6=
4)

Boot Failures Detected:

arm:

    multi_v7_defconfig
        exynos5800-peach-pi: 1 failed lab

    exynos_defconfig
        exynos5420-arndale-octa: 1 failed lab
        exynos5800-peach-pi: 1 failed lab

---
For more info write to <info@kernelci.org>
