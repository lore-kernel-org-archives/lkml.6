Return-Path: <bot@kernelci.org>
ARC-Seal: i=1; a=rsa-sha256; t=1524008609; cv=none;
        d=google.com; s=arc-20160816;
        b=lZRDa9n/13hJvcbRNfua4aha5jG1Vv1u973OJfz0cQr+YCIFbikPiUqW3wCqvJpZV9
         BxmfWYWLO3/C6sY31aV9CEQKuQQNp1JKWLwXcoq48jvAWolKd9xgRAgFNK6I31fdYRGx
         owaymhlbOps4BxFZj/o1ihO6P2CqV6Yb4VJujq8P8r01I9tzYlZdREHH8KzekGD2hHAk
         1PoxVh/4E4dtAdI/3vvvX0Z89numnrYU1vJm8HxplUfs0iIZMwsceaBv22/wKsn5PDJB
         cBI6PpEqMcgU/FCG9YsRA9ZnJa4vI0QTLg0FN+jjsV3kmWbUoyn07TGqqlmtSQE8qvk1
         WSQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:from:to:subject:references:in-reply-to:content-transfer-encoding
         :mime-version:date:message-id:arc-authentication-results;
        bh=3K0jgmWGTBPhHIgC64jwjAcnJGELz+H4P5FfPunnn6Q=;
        b=B5OTmOdWPuKB/GMEfvS5NTgzyn5DHSMkuZmaNi/p8I+VZSfPaD8lxN6uV9z4Lm9WP9
         F6UdRCfqfHIAgiPI0ZKzb+pEfo55iX8PCmFjVtIaXSeVDWyafkWqZNbdOCmpIdLGvDeJ
         VWwEtsJa2Npy2/210jK3H2d0+IntOKOUM/rekevz+F2fYPBTAfSJAsYeb8WkDmUIIBSB
         3TPSbF0LeHD+ltYrOL+QLt+WxgLqA/4i65hZ2v4iNrcnn5V+As7Zjt2+v/ubPuoaU8q7
         Ry4m5vtrRak6mFEDiGGXmS5MxuQ0eBIlzgfthk/HcSJGUNbip5Uv84k/63Ny/W8Fa3qX
         PgAg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of bot@kernelci.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=bot@kernelci.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of bot@kernelci.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=bot@kernelci.org
X-Google-Smtp-Source: AIpwx4/JR+Lo02FKHthj3yUYPGpUrsns3+O0dni/R3zV8nhya7Yugr9N1OAlyknJqZGLoiQR2TbgCw==
Message-ID: <5ad686a0.6ca0df0a.801f5.5f4b@mx.google.com>
Date: Tue, 17 Apr 2018 16:43:28 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.16.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: boot
X-Kernelci-Kernel: v4.16.2-69-g8485fd17d21b
In-Reply-To: <20180417155749.341779147@linuxfoundation.org>
References: <20180417155749.341779147@linuxfoundation.org>
Subject: Re: [PATCH 4.16 00/68] 4.16.3-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org
From: kernelci.org bot <bot@kernelci.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net,
 shuahkh@osg.samsung.com, patches@kernelci.org, ben.hutchings@codethink.co.uk,
 lkft-triage@lists.linaro.org, stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598009758027814100?=
X-GMAIL-MSGID: =?utf-8?q?1598038851047159483?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

stable-rc/linux-4.16.y boot: 54 boots: 1 failed, 51 passed with 2 untried/u=
nknown (v4.16.2-69-g8485fd17d21b)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.16.y/kernel/v4.16.2-69-g8485fd17d21b/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.16.=
y/kernel/v4.16.2-69-g8485fd17d21b/

Tree: stable-rc
Branch: linux-4.16.y
Git Describe: v4.16.2-69-g8485fd17d21b
Git Commit: 8485fd17d21b5d9a07b276f1c35c90a5ed529a36
Git URL: http://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git
Tested: 28 unique boards, 11 SoC families, 13 builds out of 186

Boot Regressions Detected:

arm:

    sunxi_defconfig:
        sun5i-gr8-chip-pro:
            lab-free-electrons: failing since 5 days (last pass: v4.16.1-19=
-g132318e83781 - first fail: v4.16.2)

Boot Failure Detected:

arm:

    sunxi_defconfig
        sun5i-gr8-chip-pro: 1 failed lab

---
For more info write to <info@kernelci.org>
