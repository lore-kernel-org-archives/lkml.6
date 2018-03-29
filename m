Return-Path: <bot@kernelci.org>
ARC-Seal: i=1; a=rsa-sha256; t=1522360880; cv=none;
        d=google.com; s=arc-20160816;
        b=cpAVNFWmnPFxYTA4Z9VK0WI6CXuVtrNfpPNUOfnHCaTwvyYsJ5aObktfutwVIRe2OU
         Zw+JlQyYjG+mpUPjAakwpJblAApLw6kuMHlguinKuyCLcYpRxM3OPlC69wpddu/AoL/J
         Xnutx7zy/mhDcL3+DSCRd+yWHqVRSPTJUv/tzlWTQfzAHMF9JMjPUVJmgPqXT+wYZMia
         CXTsdpzpAEfUImZ7UhIRJQJVs92Bg5RrGoU7L9dyYhXWN7i0d9dIcIrbcPnyaENdnioY
         BSxb4u3wraSubh5u0D4GBglG8jCjNqI0lou6tCPEMeQe27YZjMZ+xTsNDWT8xJsdExT3
         9m8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:from:to:subject:references:in-reply-to:content-transfer-encoding
         :mime-version:date:message-id:arc-authentication-results;
        bh=u2oT/Cmb87eJrMV1pjcNWcWFj7X6qUtQKYKAoWDW8Z8=;
        b=dCDefssVCKReEwryXOO2zYfdhc7i4OIIZHpvJa5Z60yLVbJejwn9CoIxRifS7q1V6X
         Og1e0gMJus7nMQRcEo/km3nGP4p53gIj1Y9fC57K675DfitCM1NNU/bRjp5xP6cB1CcD
         GuFd0QaS6dy8YNf7a+TxhxYxbNHVRnbvbZEWp9qW8XLwfgprI4EpSVe0yXbS4e/2ZVAl
         4x+zBH27K5fwzC1oaR+o6CT9aH5pXv5gTFaPaNiA68uJsDw/7FvIkBwba8HO2gO29irR
         MQgWpLJQMH5jEpQKFeBpcZP5rdduhjleANnMrJaiq6jrOuWyH0KhLGZTfwLB/GEiGcOS
         bapA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of bot@kernelci.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=bot@kernelci.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of bot@kernelci.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=bot@kernelci.org
X-Google-Smtp-Source: AIpwx489DohCldhYf/bvfh00M73F58l/KxC6jsBgloT20/afoksq3yijzrQFWwcAbdVgF+g/KbX3MA==
Message-ID: <5abd622f.cb98df0a.3c8b9.f18b@mx.google.com>
Date: Thu, 29 Mar 2018 15:01:19 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.4.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: boot
X-Kernelci-Kernel: v4.4.125-21-g290572f02954
In-Reply-To: <20180329175741.886181131@linuxfoundation.org>
References: <20180329175741.886181131@linuxfoundation.org>
Subject: Re: [PATCH 4.4 00/20] 4.4.126-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org
From: kernelci.org bot <bot@kernelci.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net,
 shuahkh@osg.samsung.com, patches@kernelci.org, ben.hutchings@codethink.co.uk,
 lkft-triage@lists.linaro.org, stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596296410346468938?=
X-GMAIL-MSGID: =?utf-8?q?1596311083052470048?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

stable-rc/linux-4.4.y boot: 105 boots: 1 failed, 92 passed with 10 offline,=
 2 untried/unknown (v4.4.125-21-g290572f02954)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.4.y/kernel/v4.4.125-21-g290572f02954/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.4.y=
/kernel/v4.4.125-21-g290572f02954/

Tree: stable-rc
Branch: linux-4.4.y
Git Describe: v4.4.125-21-g290572f02954
Git Commit: 290572f02954767c84991efa816fbfb56c7da9df
Git URL: http://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git
Tested: 53 unique boards, 20 SoC families, 16 builds out of 177

Boot Regressions Detected:

arm:

    at91_dt_defconfig:
        at91sam9261ek:
            lab-free-electrons: failing since 6 days (last pass: v4.4.123 -=
 first fail: v4.4.123-97-g3054df73e9af)

Boot Failure Detected:

arm:

    at91_dt_defconfig
        at91sam9261ek: 1 failed lab

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

    tegra_defconfig:
        tegra20-iris-512: 1 offline lab
        tegra30-beaver: 1 offline lab

---
For more info write to <info@kernelci.org>
