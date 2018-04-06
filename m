Return-Path: <bot@kernelci.org>
ARC-Seal: i=1; a=rsa-sha256; t=1523035331; cv=none;
        d=google.com; s=arc-20160816;
        b=YG6+pCAGUSi+s6kuuEM/WSMTFSB6vv7tkE4toChHdJ9w9jvtbvnkmbCke8JTnaENBw
         bgY8xW4cIwPgGSialRbFR5Xt3iro7Q6Z0Ep1O4E0EqAQE8Z0VDb/fFLuVpqSg0p5+ZSB
         88CBf4Cb1fZSZTLQ7p/T8MV2JgaAM7Dq+ilkV8tig+ftHH4/pOW03OMEYBuZl280Z3+K
         md5lSU5ioEl4hShhxLNiWM+fbbgimvq2GVh5TbWHf7JcGmmjx/iWQwAT1jKPabp4Tz+I
         fMmha4QqbYMEd4adq7zVKoIiUNGG2pyA7qeATsjUxztcy8s3K3SUHuZIcFTqyQiecS6S
         xmmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:from:to:subject:references:in-reply-to:content-transfer-encoding
         :mime-version:date:message-id:arc-authentication-results;
        bh=DYrmTLaKZD2h4lwOndDHk2LUjS7ObxuWxTmMMmp9wcA=;
        b=BkC1weCo0c+SSGesvoBFAFK7wLdQQKx4JR+sJL4PFhqh4eZsGvHGl5vsZ5s9IHmM7+
         S1yCe23ZSP94xsBKB+awBM6zAtkHKKQEbkl/5lDu979w2EHdHctmhCGHSFHJbhOyNOLZ
         BwpDZDJUrBUBOcyixZx5A9wdBFmoOR3ocOyiCIE6I4knUIiQA6ploXomheXhm9kZVugz
         mBQc0XVK09iI3a6Tc6xJNKsU9TL2QDKapPyLe95oh2xdcR3Jz1xWwKil+jaGSde0sdM5
         11MHqRi9fTFSmDSrXybRaFHQcEfyrczk7Xp4lUj8SIGdInAJZl2tR8kRPopx787ixAOG
         Apgw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of bot@kernelci.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=bot@kernelci.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of bot@kernelci.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=bot@kernelci.org
X-Google-Smtp-Source: AIpwx4/lCOsZWwinbQ7//s1wGMR5cOoY/sr2sNsNTLGJCxjlCFhTiWSuCP7ECaKZXAl65OWOHoIZ1w==
Message-ID: <5ac7acc0.8edbdf0a.e7b7.2008@mx.google.com>
Date: Fri, 06 Apr 2018 10:22:08 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.9.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: boot
X-Kernelci-Kernel: v4.9.92-103-g7eea6c2b79f0
In-Reply-To: <20180406084331.507038179@linuxfoundation.org>
References: <20180406084331.507038179@linuxfoundation.org>
Subject: Re: [PATCH 4.9 000/102] 4.9.93-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org
From: kernelci.org bot <bot@kernelci.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net,
 shuahkh@osg.samsung.com, patches@kernelci.org, ben.hutchings@codethink.co.uk,
 lkft-triage@lists.linaro.org, stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597003940861807257?=
X-GMAIL-MSGID: =?utf-8?q?1597018295834828727?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

stable-rc/linux-4.9.y boot: 61 boots: 0 failed, 59 passed with 2 untried/un=
known (v4.9.92-103-g7eea6c2b79f0)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.9.y/kernel/v4.9.92-103-g7eea6c2b79f0/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.9.y=
/kernel/v4.9.92-103-g7eea6c2b79f0/

Tree: stable-rc
Branch: linux-4.9.y
Git Describe: v4.9.92-103-g7eea6c2b79f0
Git Commit: 7eea6c2b79f0c0f15f8a519cd2797bcfffc47d4a
Git URL: http://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git
Tested: 30 unique boards, 14 SoC families, 17 builds out of 183

---
For more info write to <info@kernelci.org>
