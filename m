Return-Path: <bot@kernelci.org>
ARC-Seal: i=1; a=rsa-sha256; t=1527171988; cv=none;
        d=google.com; s=arc-20160816;
        b=07CixmRfOMvu2wneVT4DLTcoJaIpIGzsg/pbslrikM29F9n6Wnv4SMmqXBk8O6DQsL
         q9lM/H9pc4QQ9z8AZy/+EyBXeUBPryaBd7ZeHz3z4k4dxSg/DgZU3xFNZ1GqN2Qx8bKs
         xO+3Iea3N+e4+9nyA+Vz+MeqIWBnkTybv2YpJ1XsSzs8J826icalIrQN3WqR82QDb7Ul
         AcZLBFir3FxZGnkYzsYr9znknN/GUq3xwe11Hz8svNpJujL/VuVyoXDOa7dseFLQThIt
         treYX/uC6jJTdCI0/9IlF7RLuRqqKD5F09ua0tqHVU/bOSGWEzORO/DXcyoWOtu43uPd
         3mzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:from:to:subject:references:in-reply-to:content-transfer-encoding
         :mime-version:date:message-id:arc-authentication-results;
        bh=VnoCEDSzaaIIUKhRHa/Bj5ZKNhfGKlyo7z1evf2OG4Q=;
        b=1KgNrRjKJUwIEE+jCv7zN4bIF9FpYyQRjC1GcmH/YUK2ZhVanUr4sQGDMUeZ/GHRCo
         Yr7a/euSShVXogHUxLgV6mxhDuQxbzlQ4cugtAze16tpJxrT2rm9BNItuQXqnmcfxP8E
         Y2Wq6Rm4Bss1IDwK1j1Arg0K76j0jFO8OPHXwkQ/Z/ybizXYLZXON8ue/UURGO4pk/xm
         xhUu+HMKLyhhUwmMCqWGe3wImWocM8Yvh+doi2WhKDKTP1KvBkFJTiZz7MtxrS4Lr5vv
         8Ufrkj0RwwdD6gZt7/SUtuyDN1bAyQEQZ6ixIilAZzzHyZxUxy3M8qZnNU/5WcnLSSRP
         fj8Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of bot@kernelci.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=bot@kernelci.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of bot@kernelci.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=bot@kernelci.org
X-Google-Smtp-Source: AB8JxZpHs7WdW4dYDG1dbfo+To2nYiIOKC54+ZJuOV9oPWhrmdK4HN++LQBnvXp7vqqDl6go5n4hDw==
Message-ID: <5b06cb93.1c69fb81.6088d.282e@mx.google.com>
Date: Thu, 24 May 2018 07:26:27 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: stable-rc
X-Kernelci-Branch: linux-4.9.y
X-Kernelci-Report-Type: boot
X-Kernelci-Kernel: v4.9.102-97-g190b92e2b8d4
In-Reply-To: <20180524093605.602125311@linuxfoundation.org>
References: <20180524093605.602125311@linuxfoundation.org>
Subject: Re: [PATCH 4.9 00/96] 4.9.103-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org
From: kernelci.org bot <bot@kernelci.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net,
 shuah@kernel.org, patches@kernelci.org, ben.hutchings@codethink.co.uk,
 lkft-triage@lists.linaro.org, stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1601338380744330487?=
X-GMAIL-MSGID: =?utf-8?q?1601355894815196230?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

stable-rc/linux-4.9.y boot: 111 boots: 1 failed, 107 passed with 3 offline =
(v4.9.102-97-g190b92e2b8d4)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.9.y/kernel/v4.9.102-97-g190b92e2b8d4/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.9.y=
/kernel/v4.9.102-97-g190b92e2b8d4/

Tree: stable-rc
Branch: linux-4.9.y
Git Describe: v4.9.102-97-g190b92e2b8d4
Git Commit: 190b92e2b8d4d190a6b059732180a71f1ff17c4d
Git URL: http://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git
Tested: 55 unique boards, 23 SoC families, 18 builds out of 183

Boot Failure Detected:

arm64:

    defconfig
        synquacer-acpi: 1 failed lab

Offline Platforms:

arm:

    imx_v6_v7_defconfig:
        imx7s-warp: 1 offline lab

    multi_v7_defconfig:
        imx7s-warp: 1 offline lab

arm64:

    defconfig:
        meson-gxbb-p200: 1 offline lab

---
For more info write to <info@kernelci.org>
