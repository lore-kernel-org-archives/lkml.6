Return-Path: <bot@kernelci.org>
ARC-Seal: i=1; a=rsa-sha256; t=1523040130; cv=none;
        d=google.com; s=arc-20160816;
        b=Tm88hHmVHW6aP93x95UUQBuSA2TA31EXxGMfh97qqQRsNhAxdMC6G63R3lF82XRv3B
         ZM2A286pBovQV2/4iQkx/URlhCopul/Fu5ooZoVHg6droKrVwbaiUYtb1hvRcqXVqZ6a
         RWxkyEmJrSl5+cfjql4gtoXoF3YcbRqr4fQcTZwKN+HP3SPDOMos3bU8ek3YTWZ1w1Bo
         NPpnRr/Ha45SN24usXPXEw7OnOGdcTEjjyWJywGyonleSs6l9pgo1C6t9WMScHe5lCmG
         CuZ0Xk7fo0JOMrAbcmNUBifeCQaks8R8KG3SOxgPKbAocg6trcJ9vjgASFl5uE7GzxcK
         UdXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:from:to:subject:references:in-reply-to:content-transfer-encoding
         :mime-version:date:message-id:arc-authentication-results;
        bh=vyGSyZws81ws7eGjcEad1Uph57ryqk3ot66BMu1wVhI=;
        b=FtgJeB6F7Nca3vEBJH0l6obbn94zvR+9T0Ui4uTqtwwSaW4wbMdmJtlXCyEmGv1V6k
         ZkCXWs/+2OC1YAAmccfUxWg2cRVLLB1pc3l8megLS1dZOk9RDgwHUxWJlruxqws5xra2
         CTKJb5faX7wLndw2R/neDy2pVLvMqkyh8NFpRbJcfmC8fhy/YQRQdY8wN/j+lht6NT1h
         SkTXxUoZT4yAobdtqAwv2hiaE7BejsDcoyr6rF44tCYOOs19U5qC1NhqRTHsywKEOqhK
         X5yTik0KXalhmkFoCof75obm5oL0ExydL7MwUhaeT7yACVepGEEGCWEEcy9qTpBgC1v8
         +hUA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of bot@kernelci.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=bot@kernelci.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of bot@kernelci.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=bot@kernelci.org
X-Google-Smtp-Source: AIpwx4+JS92IOdUPcPtj8P8Cq2SPWzpwCGS3FsTSeoHSJ6KkXt3Iytr8p+XdpfrdKfsNI01iIzUrLA==
Message-ID: <5ac7bf81.91acdf0a.c9f24.716b@mx.google.com>
Date: Fri, 06 Apr 2018 11:42:09 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.16.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: boot
X-Kernelci-Kernel: v4.16-32-g30380aa57922
In-Reply-To: <20180406084340.999820380@linuxfoundation.org>
References: <20180406084340.999820380@linuxfoundation.org>
Subject: Re: [PATCH 4.16 00/31] 4.16.1-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org
From: kernelci.org bot <bot@kernelci.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net,
 shuahkh@osg.samsung.com, patches@kernelci.org, ben.hutchings@codethink.co.uk,
 lkft-triage@lists.linaro.org, stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597004673616987143?=
X-GMAIL-MSGID: =?utf-8?q?1597023328107822062?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

stable-rc/linux-4.16.y boot: 65 boots: 1 failed, 62 passed with 2 untried/u=
nknown (v4.16-32-g30380aa57922)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.16.y/kernel/v4.16-32-g30380aa57922/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.16.=
y/kernel/v4.16-32-g30380aa57922/

Tree: stable-rc
Branch: linux-4.16.y
Git Describe: v4.16-32-g30380aa57922
Git Commit: 30380aa579224caf6a737160802151f466fe3953
Git URL: http://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git
Tested: 32 unique boards, 14 SoC families, 15 builds out of 186

Boot Failure Detected:

arm:

    mvebu_v7_defconfig
        armada-375-db: 1 failed lab

---
For more info write to <info@kernelci.org>
