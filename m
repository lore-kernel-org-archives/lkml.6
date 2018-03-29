Return-Path: <bot@kernelci.org>
ARC-Seal: i=1; a=rsa-sha256; t=1522360879; cv=none;
        d=google.com; s=arc-20160816;
        b=RxkzXmm1pYyCYgtKle71mBZic/wn4AZzo1yo7fUzxaSSSeESM2jbF7CJgTNYzH/4En
         qAQ/d/gQXAaarJpjNJ3itVBgODeq3gcB8M6JPbkhVPUTY/SgZCwPrR0YP8Xt2Ru1vKKp
         qBpN9UobzZjgsoKxQKVERAAmFZYGV4z67DJJRWQ6ylXLd2/sqi1oUnY3mtjD5sI3uof+
         MCa0JJQK1rE5wUsdjar0LgvZ2HClrVDh2f1EMyAqnDdD8HxL3v+Kxc63ahUVH+UFL2Rd
         QUF4bouGnudhTImunwhiuWANoxSW+1AA0HGeGN7qDWVBZpB6C/RNONaNqm2SoLbD87A2
         8aOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:from:to:subject:references:in-reply-to:content-transfer-encoding
         :mime-version:date:message-id:arc-authentication-results;
        bh=nwE7AXRDOJJ3Dd3Q7CrWFrSgw1GmXx4+Cbc75RowTfs=;
        b=SV0HmIocq8HRM0tOljozqlRQwSNPVNT1p4dh5HS2r0MsDwEzvA2OpnmBbKThq6TcQ/
         OB6rGrr2SBGFmxNd2cwZkslpD/CLhOAlim9gOihrkh/2Ukom+sUKAyc3wU/FNh0eewFS
         MzaXf9aYYar/XRakEBQiYLKgEU4NqEHp3t5KOpwO1GqYfq0hKbV+yyYv8mMs7gK/bc/G
         JbOSHuskX5JmFT7+euLwqcTn1XVEpoW9iTokL7dvok2K7yY0JMC9MG5iFW0txtOc87FL
         hAmu+0OwncgDKQetI6uuD8D3R6gj5t9bXdNgEPzNebKBYr5bMkF/WUzSpMkVDTaw9QzP
         EMzg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of bot@kernelci.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=bot@kernelci.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of bot@kernelci.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=bot@kernelci.org
X-Google-Smtp-Source: AIpwx4+H9ps12kzZX/37fKgqMNf/d5KDMmxSE2ceqEByrg08eF6DLpLNk0vQZ/Doq+saQQaJFlV0XA==
Message-ID: <5abd622e.3388df0a.8861.e034@mx.google.com>
Date: Thu, 29 Mar 2018 15:01:18 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.14.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: boot
X-Kernelci-Kernel: v4.14.31-44-gcc19592f68f7
In-Reply-To: <20180329175730.190353692@linuxfoundation.org>
References: <20180329175730.190353692@linuxfoundation.org>
Subject: Re: [PATCH 4.14 00/43] 4.14.32-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org
From: kernelci.org bot <bot@kernelci.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net,
 shuahkh@osg.samsung.com, patches@kernelci.org, ben.hutchings@codethink.co.uk,
 lkft-triage@lists.linaro.org, stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596296215155327589?=
X-GMAIL-MSGID: =?utf-8?q?1596311081729505048?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

stable-rc/linux-4.14.y boot: 130 boots: 0 failed, 113 passed with 14 offlin=
e, 2 untried/unknown, 1 conflict (v4.14.31-44-gcc19592f68f7)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.14.y/kernel/v4.14.31-44-gcc19592f68f7/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.14.=
y/kernel/v4.14.31-44-gcc19592f68f7/

Tree: stable-rc
Branch: linux-4.14.y
Git Describe: v4.14.31-44-gcc19592f68f7
Git Commit: cc19592f68f7c1dea0d4c70bfd8169454266b9b5
Git URL: http://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git
Tested: 70 unique boards, 23 SoC families, 17 builds out of 185

Boot Regressions Detected:

arm:

    multi_v7_defconfig:
        exynos5800-peach-pi:
            lab-baylibre-seattle: new failure (last pass: v4.14.31)

Offline Platforms:

arm:

    sunxi_defconfig:
        sun5i-r8-chip: 1 offline lab
        sun7i-a20-cubietruck: 1 offline lab

    multi_v7_defconfig:
        exynos5410-odroidxu: 1 offline lab
        sun5i-r8-chip: 1 offline lab
        sun7i-a20-cubietruck: 1 offline lab
        tegra20-iris-512: 1 offline lab
        tegra30-beaver: 1 offline lab

    exynos_defconfig:
        exynos5410-odroidxu: 1 offline lab
        exynos5800-peach-pi: 1 offline lab

    davinci_all_defconfig:
        dm365evm,legacy: 1 offline lab

    tegra_defconfig:
        tegra20-iris-512: 1 offline lab
        tegra30-beaver: 1 offline lab

arm64:

    defconfig:
        meson-gxbb-odroidc2: 1 offline lab
        meson-gxl-s905d-p230: 1 offline lab

Conflicting Boot Failure Detected: (These likely are not failures as other =
labs are reporting PASS. Needs review.)

arm:

    multi_v7_defconfig:
        exynos5800-peach-pi:
            lab-collabora: PASS
            lab-baylibre-seattle: FAIL

---
For more info write to <info@kernelci.org>
