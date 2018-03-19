Return-Path: <bot@kernelci.org>
ARC-Seal: i=1; a=rsa-sha256; t=1521496824; cv=none;
        d=google.com; s=arc-20160816;
        b=KxomHiUWa5xPGWilusQ9jyK4zntLlM1/LKDuDz3VFlB0ZOFkjcxSeiXXr2rs24MpAx
         Nrubu/hx0H/18ihBXCEzPc9V1uekyumBhvEc2qtXjrVOwKOYER6glUd+eOFNVzvbihVc
         53bHQoO9szSm4liWsX8Mlj/SHXcDHbbZbACAaVvxCBm4FVa2GA1wR4X6a4D5U3R61JTN
         3u2DqDWeQhIn21szA/vOEK4vnJ0214QPSmi3a1lIw4ocy1tI3T+VcwMBp6PxNrQDZ67t
         gOwCu4l/OYZkZ446KX8Ej+Qtzzs5Boi3QE+h+IzmZAGvd6TdvTnHOQj8b49krMX+W6Jy
         WgXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:from:to:subject:references:in-reply-to:content-transfer-encoding
         :mime-version:date:message-id:arc-authentication-results;
        bh=b+UbD+u48pJ38PskcIJLgraCnLsI/koKCSp8Td5BD3k=;
        b=SDH6LEJEOHTyUexQkiCDAeq/u0/i6a9maGfVmFWgLyXhKCC0STpYVYXs2kOQiXxieh
         wF/yp25yyycoDOqylqyUZa5WgZkrR7MzZCs68X8LmpMCkbf7+nAfRHdPPOpeCE3VQWwM
         UJLWgeyI8J/FLNVqb6PWasWiFx7oJPkyiSvO0IIELnUYv42KoMqdvaha+ZdheMpTGiI/
         JpcDrOaz/Sl/ZezZVsEzFYp12cdyMESJC281ErMZYIiNNS70VZm/Wn/APUtAdrLjsSIt
         mcyobyf4arq95LfxwrE1ORgZsJNF5L3DxwYDUU1PslQ7fiz3V1A5nNCLBTduhMXIs4AD
         gk+w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of bot@kernelci.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=bot@kernelci.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of bot@kernelci.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=bot@kernelci.org
X-Google-Smtp-Source: AG47ELuJGYSnKxul1sy/6b29n9Tlph23qxYnkwuD+csoTsxKvnaDVxNYgJTTa0jGD9c+v7eUaNgJAQ==
Message-ID: <5ab032f7.01b9df0a.fdb52.1652@mx.google.com>
Date: Mon, 19 Mar 2018 15:00:23 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-3.18.y
X-Kernelci-Kernel: v3.18.100-69-g0933cb9a7412
X-Kernelci-Report-Type: boot
X-Kernelci-Tree: stable-rc
In-Reply-To: <20180319171827.899658615@linuxfoundation.org>
References: <20180319171827.899658615@linuxfoundation.org>
Subject: Re: [PATCH 3.18 00/68] 3.18.101-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org
From: kernelci.org bot <bot@kernelci.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net,
 shuahkh@osg.samsung.com, patches@kernelci.org, ben.hutchings@codethink.co.uk,
 lkft-triage@lists.linaro.org, stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595390591416246104?=
X-GMAIL-MSGID: =?utf-8?q?1595405054116189762?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

stable-rc/linux-3.18.y boot: 29 boots: 1 failed, 25 passed with 3 offline (=
v3.18.100-69-g0933cb9a7412)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-3.18.y/kernel/v3.18.100-69-g0933cb9a7412/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-3.18.=
y/kernel/v3.18.100-69-g0933cb9a7412/

Tree: stable-rc
Branch: linux-3.18.y
Git Describe: v3.18.100-69-g0933cb9a7412
Git Commit: 0933cb9a7412b8824a80815f912ea8e4b7b0ad5e
Git URL: http://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git
Tested: 22 unique boards, 9 SoC families, 11 builds out of 167

Boot Regressions Detected:

arm:

    exynos_defconfig:
        exynos5420-arndale-octa:
            lab-baylibre-seattle: failing since 13 days (last pass: v3.18.9=
6-14-g9fdaa6623e85 - first fail: v3.18.98)

Boot Failure Detected:

arm:

    exynos_defconfig
        exynos5420-arndale-octa: 1 failed lab

Offline Platforms:

arm:

    davinci_all_defconfig:
        dm365evm,legacy: 1 offline lab

    exynos_defconfig:
        exynos5410-odroidxu: 1 offline lab
        exynos5800-peach-pi: 1 offline lab

---
For more info write to <info@kernelci.org>
