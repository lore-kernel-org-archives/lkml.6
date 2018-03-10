Return-Path: <bot@kernelci.org>
ARC-Seal: i=1; a=rsa-sha256; t=1520662777; cv=none;
        d=google.com; s=arc-20160816;
        b=ADgcJxiWBo+4RCm1pOgiZ9ciq0loSyVF7muWT1bKfHCMRPsT7whI/dixaqXilcK5UM
         tXE8luXkHc9isNlKqjbDcUrrmrzENUE5nbXrnFKu9JF03zSWYIX+rWQ+vHEhBdXFMXxZ
         0bpa19TUaropZlacnkwhMesT4M8z/XFvyikyfkrsQACe/o7nEuCLDQll9xnS1i8dVFbP
         sch5df06w8NH/mnkvMQTs9wE+iFZ/Mj4AstERuyX4FgS3O2T0EJd7vR3v1AhDqIQXsnH
         UtzVOwJHQ19zeUVhRSaSw+rd+f0eNNdldwu4z0YdpEc8f7J8XIwHcGtTmHwfdltBfk18
         y31g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:from:to:subject:references:in-reply-to:content-transfer-encoding
         :mime-version:date:message-id:arc-authentication-results;
        bh=wS725UCASPCKKRlSxbYG/DsBoD71z+9uJHniXUj0h8M=;
        b=NIvee+VOnVPh7/eFRd1LBEb4Wtti5evSlsAtnyLzuw3POkt++eK3v6i68tprqTeuCX
         TAPStJHxUdmFo5S98GtuhIs2hVjfBgHQt/uJq0ZqS2fOZcjls5/G4qXbollK6hscr5NR
         9Jt7Uqk+yIVkYtHatJkc5kLTRtlnYjPAgmyxA7LgHSJxe1opQhawb1F8B63ySHYcwlzH
         gx0xocJckEJT9ZPDQdvW1fBH1TV6lTRsWk02idgGovuctNcV+YSUufwNX6GdCHodedT6
         sQkz4gQjISalrLOp2MR1ZHNsKOHxTkI1FqJdTYmor/NOFcmtaapYDGeifhynmI7bay+m
         LGdg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of bot@kernelci.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=bot@kernelci.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of bot@kernelci.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=bot@kernelci.org
X-Google-Smtp-Source: AG47ELu4EynulSOnVYOtDgZNh7AVlpmSQOv/O51xePiOerNWZ5nG1aU/sLTt1AIbs+yLzG9FroOy2Q==
Message-ID: <5aa378f8.09c9500a.15ad5.7e34@mx.google.com>
Date: Fri, 09 Mar 2018 22:19:36 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-3.18.y
X-Kernelci-Kernel: v3.18.98-22-g62ba861931e1
X-Kernelci-Report-Type: boot
X-Kernelci-Tree: stable-rc
In-Reply-To: <20180310001801.045114869@linuxfoundation.org>
References: <20180310001801.045114869@linuxfoundation.org>
Subject: Re: [PATCH 3.18 00/21] 3.18.99-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org
From: kernelci.org bot <bot@kernelci.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net,
 shuahkh@osg.samsung.com, patches@kernelci.org, ben.hutchings@codethink.co.uk,
 lkft-triage@lists.linaro.org, stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594507787184257773?=
X-GMAIL-MSGID: =?utf-8?q?1594530493080977865?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

stable-rc/linux-3.18.y boot: 68 boots: 1 failed, 65 passed with 2 offline (=
v3.18.98-22-g62ba861931e1)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-3.18.y/kernel/v3.18.98-22-g62ba861931e1/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-3.18.=
y/kernel/v3.18.98-22-g62ba861931e1/

Tree: stable-rc
Branch: linux-3.18.y
Git Describe: v3.18.98-22-g62ba861931e1
Git Commit: 62ba861931e17e91ad9450e72ec94128191a6370
Git URL: http://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git
Tested: 34 unique boards, 12 SoC families, 15 builds out of 167

Boot Regressions Detected:

arm:

    exynos_defconfig:
        exynos5420-arndale-octa:
            lab-baylibre-seattle: failing since 4 days (last pass: v3.18.96=
-14-g9fdaa6623e85 - first fail: v3.18.98)

Boot Failure Detected:

arm:

    exynos_defconfig
        exynos5420-arndale-octa: 1 failed lab

Offline Platforms:

arm:

    multi_v7_defconfig:
        exynos5410-odroidxu: 1 offline lab

    exynos_defconfig:
        exynos5410-odroidxu: 1 offline lab

---
For more info write to <info@kernelci.org>
