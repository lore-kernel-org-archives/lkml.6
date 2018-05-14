Return-Path: <bot@kernelci.org>
ARC-Seal: i=1; a=rsa-sha256; t=1526305533; cv=none;
        d=google.com; s=arc-20160816;
        b=W6rnhqczdWk/mAY5XRZU4Dmk9PC0R9NKyMJ2IfW7qQ9LgQl6gZ7GjLOLWa5NwauMNV
         s2ehAcj9itagqzocM9rGALqydSits97WETc3GeMdHk2uQj53Q1vBDKxHAtuHReqVwGH/
         J8s4BGIo0en+JpeGsZiZcFBKkz30jUY0sGpdetMA63OXgQSbwRUmWU1kaKAsIdu9Zb0s
         TTSiUCFEB2TDc3/JkiGYib+xU05q4UQLcOITVYVVWsZQ1V6BRH3n6YVdt4k1yVuvpeQG
         cfw8SkNVia4B8h4L+8mFZ0dMW6VlgQilFXm/fr/lJCXewk2tgsGv+/dCWyWG+PDIGF8q
         tLsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:from:to:subject:references:in-reply-to:content-transfer-encoding
         :mime-version:date:message-id:arc-authentication-results;
        bh=+fcRRK5GwGlrtvleFjUFBaW08gPhHJ7a1h1ubqLamMo=;
        b=RTTGI53YoXFbs8nviBrw8QE0f5CcFEDTzjjDqziDzezAyek2d7zAHdNSx0eGJ9PDvg
         qdVbLLqeAYM0Cdy9XMqj0QULHAVS457iDxMLhYXQol5OMMFhcrtHqosFGC5KK0vn/4L5
         Svfx7FlX78+0UnIKY6I5gBhA3g4tx3YwM4g0wHY4FYPbyRYRvbjXB1fB8wGLo+M4uzf8
         Pu8e5qBMuYdOyNY88ujau5yYOSly8A20V4xjAf2NOuWjHRHeNmtQ3YPkIvF0+2vvjjbV
         pgleQOJhE1J0jsnBKzDKc/rglziRpkQKngdSUvz0rnqo5aMaQl4yrxAzJzUhKYptiro1
         Sd4w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of bot@kernelci.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=bot@kernelci.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of bot@kernelci.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=bot@kernelci.org
X-Google-Smtp-Source: AB8JxZpdOccuIGWG8gFZLV8F4ZOTo1xlv2P7xBAeYdG4pLwxOHgkBNb9lRhuY4Yba5E7QstYBN+AAg==
Message-ID: <5af992fc.1c69fb81.e0e22.239a@mx.google.com>
Date: Mon, 14 May 2018 06:45:32 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.16.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: boot
X-Kernelci-Kernel: v4.16.8-73-gdaccae8696e8
In-Reply-To: <20180514064823.033169170@linuxfoundation.org>
References: <20180514064823.033169170@linuxfoundation.org>
Subject: Re: [PATCH 4.16 00/72] 4.16.9-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org
From: kernelci.org bot <bot@kernelci.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net,
 shuah@kernel.org, patches@kernelci.org, ben.hutchings@codethink.co.uk,
 lkft-triage@lists.linaro.org, stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600421792741096129?=
X-GMAIL-MSGID: =?utf-8?q?1600447350818547129?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

stable-rc/linux-4.16.y boot: 102 boots: 2 failed, 100 passed (v4.16.8-73-gd=
accae8696e8)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.16.y/kernel/v4.16.8-73-gdaccae8696e8/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.16.=
y/kernel/v4.16.8-73-gdaccae8696e8/

Tree: stable-rc
Branch: linux-4.16.y
Git Describe: v4.16.8-73-gdaccae8696e8
Git Commit: daccae8696e8b0a3b166b0a86a20095c25c08929
Git URL: http://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git
Tested: 55 unique boards, 22 SoC families, 15 builds out of 186

Boot Regressions Detected:

arm:

    exynos_defconfig:
        exynos5250-snow:
            lab-collabora: new failure (last pass: v4.16.8-23-g8339bc61b873)

    qcom_defconfig:
        qcom-apq8064-cm-qs600:
            lab-baylibre-seattle: new failure (last pass: v4.16.8-23-g8339b=
c61b873)

Boot Failures Detected:

arm:

    exynos_defconfig
        exynos5250-snow: 1 failed lab

    qcom_defconfig
        qcom-apq8064-cm-qs600: 1 failed lab

---
For more info write to <info@kernelci.org>
