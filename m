Return-Path: <bot@kernelci.org>
ARC-Seal: i=1; a=rsa-sha256; t=1523488969; cv=none;
        d=google.com; s=arc-20160816;
        b=yL1L8g/a1Ldfb8jVUc8ONr+qVtxIcA8TeEoJ3e/nBJgR3DU/48vRqBHmk0slGZ4I/B
         ngGJOFidxulBrpiT1A6eqennBDPCjBhP2CF2uuWTw0LFO24BD7Lr4P8GEXK/m5n+IaWN
         qqP7U1BYQ9E22JFjeSF6tAoiG+lgL71oorJeaz5xsIM18ZPsxf/9KdlWDyV1Y4UNNLKp
         dqDO7cKVJO+9reYQn9rdfCsSMpSzDOSrjRY1fa7AuN8raSoCn8lmnWz0gtPWtpC4GZua
         c01GYuZyQcz1evwHPD7ltVpJ96hQg45wdcBWzQR5ZbcmjDJhlNy0cUH5Uh6k12KthOt9
         z9gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:from:to:subject:references:in-reply-to:content-transfer-encoding
         :mime-version:date:message-id:arc-authentication-results;
        bh=CcCMKt6GocgA78kFDKCk23c3r1wsJAU7pKhpsQVdEZo=;
        b=hdkpm/tmQkDX/RLogK479cfYA6DALAOaHArVd0YHIHPBO8kjm3C0b1bJg/O//N8g21
         We6TI+LO/byP3IWxovwZKqHFvOXzvMuAaZr9IK0ufMepPsBEU8l76tkzHVzoCOWaftVp
         QcjkcB+4LXxLa2sSeRktVbHzTya8Uf36hp/OYHwJcpcW5XK6pjsCgSQBNAf0TgTaCdjN
         Li9iweMEKPopOrYT74sqC4hPcL2+tNTapp4b6aSgyrRQk7JAobRl9q7L2g7Ut6er1J7N
         3CisQxiVHQTvp7tAsW36qpQujZKN4FYB8DZM4zvdcDlxvBX0msFDFE3DDkM+lzTtWLo7
         0nHQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of bot@kernelci.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=bot@kernelci.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of bot@kernelci.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=bot@kernelci.org
X-Google-Smtp-Source: AIpwx4/yS0vY4kt31obrX6z+/U8JBi/j1jaVl4SOhJON34lQe1sRsxdJgkhcxYN5jxrldhZNBiEWqQ==
Message-ID: <5ace98c8.f4a0df0a.b7909.a5b7@mx.google.com>
Date: Wed, 11 Apr 2018 16:22:48 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.4.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: boot
X-Kernelci-Kernel: v4.4.127-191-ge9832d7653b2
In-Reply-To: <20180411183550.114495991@linuxfoundation.org>
References: <20180411183550.114495991@linuxfoundation.org>
Subject: Re: [PATCH 4.4 000/190] 4.4.128-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org
From: kernelci.org bot <bot@kernelci.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net,
 shuahkh@osg.samsung.com, patches@kernelci.org, ben.hutchings@codethink.co.uk,
 lkft-triage@lists.linaro.org, stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597476469270540325?=
X-GMAIL-MSGID: =?utf-8?q?1597493969159035505?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

stable-rc/linux-4.4.y boot: 61 boots: 3 failed, 56 passed with 2 untried/un=
known (v4.4.127-191-ge9832d7653b2)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.4.y/kernel/v4.4.127-191-ge9832d7653b2/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.4.y=
/kernel/v4.4.127-191-ge9832d7653b2/

Tree: stable-rc
Branch: linux-4.4.y
Git Describe: v4.4.127-191-ge9832d7653b2
Git Commit: e9832d7653b2d69d156dcad4c78f82330c781aff
Git URL: http://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git
Tested: 30 unique boards, 13 SoC families, 13 builds out of 178

Boot Regressions Detected:

arm:

    at91_dt_defconfig:
        at91sam9m10g45ek:
            lab-free-electrons: new failure (last pass: v4.4.127-166-ge5eea=
b3948ec)

    exynos_defconfig:
        exynos5422-odroidxu3:
            lab-collabora: failing since 1 day (last pass: v4.4.127 - first=
 fail: v4.4.127-166-ge5eeab3948ec)

    multi_v7_defconfig:
        armada-375-db:
            lab-free-electrons: new failure (last pass: v4.4.127-166-ge5eea=
b3948ec)

Boot Failures Detected:

arm:

    at91_dt_defconfig
        at91sam9m10g45ek: 1 failed lab

    exynos_defconfig
        exynos5422-odroidxu3: 1 failed lab

    multi_v7_defconfig
        armada-375-db: 1 failed lab

---
For more info write to <info@kernelci.org>
