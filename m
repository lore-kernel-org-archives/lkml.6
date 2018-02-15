Return-Path: <bot@kernelci.org>
ARC-Seal: i=1; a=rsa-sha256; t=1518734220; cv=none;
        d=google.com; s=arc-20160816;
        b=fphzOETC8mOXt4phYsTIai4FgMkuIupgkKSoK2IMKJ9b2Fyh5Mf0NYzv/icGuJpuUl
         qZgMy5Ia13NGS5y2REvdwfVX87qllGoSicSWbGGrqJkGa35GVqXF8fO/LfZYnxmt/t9c
         gZKhour88i5KsgCSjKDOQjT2blgtJ2h2G5mpnQrwbVf0r29nd2/4/5vPn5CevW/g1+RS
         uQyDtdsZ+DA558SqzD//RpdZoMtCOMlAVkeKd3CM39hclveb+JlBXmfAz3LQh9QRup6s
         m9PRTpunRYfH+W9xXoBK8w0Cqaa/2RS2d6PUwHpdFmV4pt7L2bHDUbOCDzHss8QxQUF8
         sQLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:from:to:subject:references:in-reply-to:content-transfer-encoding
         :mime-version:date:message-id:arc-authentication-results;
        bh=gvZ3sx7KcIPmOZjFeWh51OXR7+2Mbmwba688grfCMqc=;
        b=UkWwdgSnG6cFCZmghKaLDT7hm+xnjxU8wWfLexTZVD/YoqhAniLZdOvXz1LeEBIDz0
         vtPiRzMxXyXnbToYcTQ9vHeiIkml+oL/1yy1vla3Muz+QjOU6Snfg1QDm2f1mKDqUzGN
         mh/kzWwPllTvxH76aQPYySVLzr9HSsGM5V0+lNHOctoVDVzj0Jop4PJdluWxZDAHfNi+
         uAdSzn54iFDcFf9udIQhXaAAc74KEcQL0ZU7l3+wWbX65lIijPE3q0iX2p1YtDaYkn40
         dbNQoQofC8V0z+PJUiImHuSESmR7rBh6awVA2Tg9gLe71BWvih0/IjrKqPnkvim78j9u
         E9GQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of bot@kernelci.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=bot@kernelci.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of bot@kernelci.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=bot@kernelci.org
X-Google-Smtp-Source: AH8x227muzQeNKtbf+7/kTOHbecYKw2nIeV5aqJ7rtnS8YkP19ZFQf5QFa3aBWDBbIhsfvJSdijNvg==
Message-ID: <5a860b8b.1386df0a.ac7fc.c39a@mx.google.com>
Date: Thu, 15 Feb 2018 14:36:59 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v4.9.81-89-gd521208d35b1
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: boot
X-Kernelci-Branch: linux-4.9.y
In-Reply-To: <20180215151222.437136975@linuxfoundation.org>
References: <20180215151222.437136975@linuxfoundation.org>
Subject: Re: [PATCH 4.9 00/88] 4.9.82-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org
From: kernelci.org bot <bot@kernelci.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net,
 shuahkh@osg.samsung.com, patches@kernelci.org, ben.hutchings@codethink.co.uk,
 lkft-triage@lists.linaro.org, stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592481165175216146?=
X-GMAIL-MSGID: =?utf-8?q?1592508253781936693?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

stable-rc/linux-4.9.y boot: 98 boots: 0 failed, 93 passed with 5 offline (v=
4.9.81-89-gd521208d35b1)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.9.y/kernel/v4.9.81-89-gd521208d35b1/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.9.y=
/kernel/v4.9.81-89-gd521208d35b1/

Tree: stable-rc
Branch: linux-4.9.y
Git Describe: v4.9.81-89-gd521208d35b1
Git Commit: d521208d35b18752ce67294386370c0dc6af5316
Git URL: http://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git
Tested: 52 unique boards, 20 SoC families, 15 builds out of 183

Offline Platforms:

arm64:

    defconfig:
        meson-gxbb-odroidc2: 1 offline lab

arm:

    multi_v7_defconfig:
        exynos5410-odroidxu: 1 offline lab
        sun4i-a10-cubieboard: 1 offline lab

    sunxi_defconfig:
        sun4i-a10-cubieboard: 1 offline lab

    exynos_defconfig:
        exynos5410-odroidxu: 1 offline lab

---
For more info write to <info@kernelci.org>
