Return-Path: <bot@kernelci.org>
ARC-Seal: i=1; a=rsa-sha256; t=1523418145; cv=none;
        d=google.com; s=arc-20160816;
        b=FHp1iAUGMwBYrk6sZJulr50isQ8HgS1Vn61Kh5kzhtKs0y9FQnnubtBSeN3F5HPgyx
         Ck5I00S8ANWpTu2j0pGXeSlpbHJwiskHyNAh98whHBE+1PWFUz8DfJGuy2fcAWbP95Nc
         muRPp8rQMfeh/GiwlrnZ78USf4QxdDTp9S5EXF/LhzEZu2mecUnh0LO4OlGtiG9d957i
         DxEFHttekA0OR2aAcbo5v3uRb73u9HolmvH/sYh0zGr42Jv8jFfVGKiP8eeiZc7EgpaV
         UrVs9f9SzLX1a+gmf+EZ1GWMLcc1rbhdZsFkfEIi4HuNJzZyBhaWdwOkroV9oP+ro0wt
         cf9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:from:to:subject:references:in-reply-to:content-transfer-encoding
         :mime-version:date:message-id:arc-authentication-results;
        bh=rrw6QYxN+buKfDf/hFZ7VfzKWtoIbYvGmFszo2RBB8Q=;
        b=DKTb+oIlZ5qHygPlGQn5sR9iPxt4MKaXGcqw0wRgUicq5ilORvgiPgCEGGtXcsMfA8
         EMuZb7TUdOrPOqZ3Wh7XLinDwMNgOYMwYJZJFnm0jPBoZaAzi1y1bT0ToDHGyRK8tzT8
         Hb0R3Ys4Vim99o4hHxt8rv7UXFrCF3CjF31hoy60lS5A/DmB6U23zyWedIrCc+zgDGrx
         QGUPRjErqd0Va1NZ0PzFmHhbMLco/NAOl9zjSoj5zV/tMh4iS+6AMBM/rFb9NVbT/BM7
         2x0U1wmhbO6ENBEVKd/DajLTB0/5jPGXso0nqFf2PVx5cV+ICu9f/UTccrrfn3UAGkCR
         S7rw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of bot@kernelci.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=bot@kernelci.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of bot@kernelci.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=bot@kernelci.org
X-Google-Smtp-Source: AIpwx4+KaRLY1Yd7CSGCydIi/SftQlRnPm9LzIJjU1cBz/1yKbgZCkdUOlnN63k9Wh2Nu9OrbjcYGw==
Message-ID: <5acd8420.9d4a1c0a.46373.4317@mx.google.com>
Date: Tue, 10 Apr 2018 20:42:24 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.14.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: boot
X-Kernelci-Kernel: v4.14.33-139-gb8a8fc70e6b2
In-Reply-To: <20180410212902.121524696@linuxfoundation.org>
References: <20180410212902.121524696@linuxfoundation.org>
Subject: Re: [PATCH 4.14 000/138] 4.14.34-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org
From: kernelci.org bot <bot@kernelci.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net,
 shuahkh@osg.samsung.com, patches@kernelci.org, ben.hutchings@codethink.co.uk,
 lkft-triage@lists.linaro.org, stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597400299930471454?=
X-GMAIL-MSGID: =?utf-8?q?1597419704970798787?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

stable-rc/linux-4.14.y boot: 82 boots: 5 failed, 74 passed with 3 untried/u=
nknown (v4.14.33-139-gb8a8fc70e6b2)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.14.y/kernel/v4.14.33-139-gb8a8fc70e6b2/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.14.=
y/kernel/v4.14.33-139-gb8a8fc70e6b2/

Tree: stable-rc
Branch: linux-4.14.y
Git Describe: v4.14.33-139-gb8a8fc70e6b2
Git Commit: b8a8fc70e6b2de144668a066f87e4f94203c0caf
Git URL: http://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git
Tested: 40 unique boards, 15 SoC families, 15 builds out of 185

Boot Regressions Detected:

arm:

    multi_v5_defconfig:
        at91sam9x25ek:
            lab-free-electrons: new failure (last pass: v4.14.33-100-g0538e=
3088854)

    multi_v7_defconfig:
        imx6ul-pico-hobbit_rootfs:nfs:
            lab-pengutronix: new failure (last pass: v4.14.33-100-g0538e308=
8854)
        sama5d36ek:
            lab-free-electrons: new failure (last pass: v4.14.33-100-g0538e=
3088854)

    mvebu_v7_defconfig:
        armada-xp-linksys-mamba:
            lab-free-electrons: new failure (last pass: v4.14.33-100-g0538e=
3088854)

    sunxi_defconfig:
        sun8i-a83t-allwinner-h8homlet-v2:
            lab-free-electrons: failing since 1 day (last pass: v4.14.32-68=
-g78c25922bb37 - first fail: v4.14.33-87-g3f2310a574a9)

Boot Failures Detected:

arm:

    sunxi_defconfig
        sun8i-a83t-allwinner-h8homlet-v2: 1 failed lab

    multi_v7_defconfig
        imx6ul-pico-hobbit_rootfs:nfs: 1 failed lab
        sama5d36ek: 1 failed lab

    multi_v5_defconfig
        at91sam9x25ek: 1 failed lab

    mvebu_v7_defconfig
        armada-xp-linksys-mamba: 1 failed lab

---
For more info write to <info@kernelci.org>
