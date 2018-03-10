Return-Path: <bot@kernelci.org>
ARC-Seal: i=1; a=rsa-sha256; t=1520666378; cv=none;
        d=google.com; s=arc-20160816;
        b=eNK8srIm96MZujRyX1v3PTSc5zAGYGmPiB/ZYJ61EJbSXPrtxGA4d9ORcWhXGfXQms
         8D/RBBVqtxbWE8dhtkNkiljmE0Mzm2RRHWBOWO7nt3YnKmk64Dd/p2ZiZRwDekXhee+h
         xcYpHp7O/b46G/sG5e4WsSbyf+SnBurNFwv55TSXkxgGiBrvqDsXXHfinxEDbYbE1md4
         RHs7n8Dqey2W5HKhs+5eIQcqVsdCgxpY4yxbc3vwH4BZigkcx4dZX2sODNn2X9WEqqOa
         bA55pQc6WsIfWNRRGcZKrutnrRRj2vxYYGkoKguncMaG9iB+mtMa+giAM0xGbfwSUdif
         rJKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:from:to:subject:references:in-reply-to:content-transfer-encoding
         :mime-version:date:message-id:arc-authentication-results;
        bh=9PHF98nDX910B+p39IdlUBYTFtMPcALJ9E1fbLHcs+s=;
        b=fDAHXa5ewUqpGN9TCHOFPCQI29ji4Q1/m7FGyUJfDOxNnb3PHmI9wEWTJW41Q2JiJW
         Al6oSWgCXWHC6vscdzvOW5jqXvRfqwzhFIzyLzuOS5mZHjOlcQRLLAN9pjUcHWHA4R3v
         ayZ/DJKe32A5w+Heb2ksk6f/RQ+ApEN2SromH3PiKx1BjGVWtRttf8vKDF60/rI/Jhdr
         vUVXJd+1PJ2qpbPZ520mZfYnaJBBN1FnOYFMNv6pTVvZQOXa3FojMc+VkcfMEjl4D52/
         OTa/mwvLx+ZUFR/nS0pXT85uYwhiT0KvxyYgAQLfAjYtfpM1UOKYKvUPE1k+QFtaOWfk
         fI7Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of bot@kernelci.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=bot@kernelci.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of bot@kernelci.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=bot@kernelci.org
X-Google-Smtp-Source: AG47ELvKsqYXkZ5ykv/p+/xm82cUuOqhfO7VULan7P0OU/31GVJRY8asBqCY492Tmk3UNbZLcXDWow==
Message-ID: <5aa38708.90b4500a.8fb5a.8b08@mx.google.com>
Date: Fri, 09 Mar 2018 23:19:36 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.4.y
X-Kernelci-Kernel: v4.4.120-37-gce7ba34ae77c
X-Kernelci-Report-Type: boot
X-Kernelci-Tree: stable-rc
In-Reply-To: <20180310001807.213987241@linuxfoundation.org>
References: <20180310001807.213987241@linuxfoundation.org>
Subject: Re: [PATCH 4.4 00/36] 4.4.121-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org
From: kernelci.org bot <bot@kernelci.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net,
 shuahkh@osg.samsung.com, patches@kernelci.org, ben.hutchings@codethink.co.uk,
 lkft-triage@lists.linaro.org, stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594507896678991964?=
X-GMAIL-MSGID: =?utf-8?q?1594534268303205396?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

stable-rc/linux-4.4.y boot: 116 boots: 1 failed, 108 passed with 5 offline,=
 2 untried/unknown (v4.4.120-37-gce7ba34ae77c)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.4.y/kernel/v4.4.120-37-gce7ba34ae77c/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.4.y=
/kernel/v4.4.120-37-gce7ba34ae77c/

Tree: stable-rc
Branch: linux-4.4.y
Git Describe: v4.4.120-37-gce7ba34ae77c
Git Commit: ce7ba34ae77cd9c453322684a048f2ea9fef4cb5
Git URL: http://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git
Tested: 59 unique boards, 20 SoC families, 16 builds out of 178

Boot Regressions Detected:

arm:

    mvebu_v7_defconfig:
        armada-375-db:
            lab-free-electrons: new failure (last pass: v4.4.120)

Boot Failure Detected:

arm:

    mvebu_v7_defconfig
        armada-375-db: 1 failed lab

Offline Platforms:

arm:

    multi_v7_defconfig:
        exynos5410-odroidxu: 1 offline lab
        meson8b-odroidc1: 1 offline lab
        vf610-colibri-eval-v3: 1 offline lab

    exynos_defconfig:
        exynos5410-odroidxu: 1 offline lab

    imx_v6_v7_defconfig:
        vf610-colibri-eval-v3: 1 offline lab

---
For more info write to <info@kernelci.org>
