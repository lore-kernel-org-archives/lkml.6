Return-Path: <bot@kernelci.org>
ARC-Seal: i=1; a=rsa-sha256; t=1522360880; cv=none;
        d=google.com; s=arc-20160816;
        b=oGrEIxJ6+xDSll6QSNusqvbHrugdm7Kc+NF0hd7/3tdSqYOyJhPKEAFi11r9cZLLHO
         /N2ZgGLWC0s+6KUwYgNPzJ8w9893fhgbWHSBF14rkc6Q7HC4taAnz7Kc9luJ5ko1ki27
         3HK7Zp2Hneie7xfLT1PcYCdeQuVtUhMT1kIyo0/EfwdbCIeLawPe6elaYokdFnyfHIou
         L3s7PAPuW+eoVGicrWuJviq5+1rvLWt+saWFt2OtOGPMQVuhJaoC6b2siul1Z8LaOTZN
         OW7s3Kc9DKUNzVCarzgKGPpLo6nVgdK6amo4+uTgFVj1XCzelIXDqgmN+nmAfaDIC7b/
         5YKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:from:to:subject:references:in-reply-to:content-transfer-encoding
         :mime-version:date:message-id:arc-authentication-results;
        bh=lxj9/q5IXJbw6y4vAa1KdmUhVYL9u/rK76dZofJCFh0=;
        b=tRUjxJYCpMoMghK99b6xqIMFMoB76UtUerct59sqO+37t4mUqzITddSb8UkJn/pLWj
         WvSf7Iy/FvKh6GbYku/Wh98ptbYsbtFz8EtHW/8L8nuTgbTgdWIzgouODTUxPh+9Yo0H
         HzfLlMM7Z8JUDXdYvbj/wTEyeGmm/gDH0dHe9svxOLHXafeao+BoY/m9+jnQgHkOBM/d
         i94YMf/lgJJYbD0+RIfkO55/gtKbqjYGvHm6od2RrYNzeNCRk7qJ38LbvYv2gQ1YFWZQ
         zhj+JvEY4MTP6zxMgOVID5rAgAK5uhupf6YGLZqJFr1UbC86K4ZSSl/62k9CCV5z6sne
         R0xA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of bot@kernelci.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=bot@kernelci.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of bot@kernelci.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=bot@kernelci.org
X-Google-Smtp-Source: AIpwx4+a62PYv7xCaQ4EWHe547Bx9XG9hIjmFtEUCybPP3z2k2tVjfW8Q9sK+85WQGgbQNzVARC/JA==
Message-ID: <5abd622e.5b88df0a.be1c9.da43@mx.google.com>
Date: Thu, 29 Mar 2018 15:01:18 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.9.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: boot
X-Kernelci-Kernel: v4.9.91-29-gcdf42b7a5c27
In-Reply-To: <20180329175733.447823703@linuxfoundation.org>
References: <20180329175733.447823703@linuxfoundation.org>
Subject: Re: [PATCH 4.9 00/28] 4.9.92-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org
From: kernelci.org bot <bot@kernelci.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net,
 shuahkh@osg.samsung.com, patches@kernelci.org, ben.hutchings@codethink.co.uk,
 lkft-triage@lists.linaro.org, stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596296370676575757?=
X-GMAIL-MSGID: =?utf-8?q?1596311082190663980?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

stable-rc/linux-4.9.y boot: 122 boots: 1 failed, 104 passed with 14 offline=
, 3 untried/unknown (v4.9.91-29-gcdf42b7a5c27)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.9.y/kernel/v4.9.91-29-gcdf42b7a5c27/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.9.y=
/kernel/v4.9.91-29-gcdf42b7a5c27/

Tree: stable-rc
Branch: linux-4.9.y
Git Describe: v4.9.91-29-gcdf42b7a5c27
Git Commit: cdf42b7a5c277bc4a4dd0853f6e2155a3ead8b02
Git URL: http://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git
Tested: 63 unique boards, 22 SoC families, 19 builds out of 183

Boot Regressions Detected:

arm:

    multi_v7_defconfig:
        sun8i-a33-sinlinx-sina33:
            lab-free-electrons: new failure (last pass: v4.9.91)

Boot Failure Detected:

arm:

    multi_v7_defconfig
        sun8i-a33-sinlinx-sina33: 1 failed lab

Offline Platforms:

arm:

    sunxi_defconfig:
        sun5i-r8-chip: 1 offline lab
        sun7i-a20-cubietruck: 1 offline lab

    multi_v7_defconfig:
        exynos5410-odroidxu: 1 offline lab
        exynos5800-peach-pi: 1 offline lab
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

---
For more info write to <info@kernelci.org>
