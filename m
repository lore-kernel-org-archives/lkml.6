Return-Path: <bot@kernelci.org>
ARC-Seal: i=1; a=rsa-sha256; t=1524004985; cv=none;
        d=google.com; s=arc-20160816;
        b=kfsjl//O7JaifkevEsuHFW0jv9W9FkZad5QyqzPsUvEWQmfVEWOyEBYxoVJzpe+wOi
         4bbrT8HLGV+fELiDh4vbrl3xKpgndeyMIAlOmGAKNmNsLQpP0WFrmMTO5tLKuO/Z/kRX
         RVvCl+AKY8XqFG96GMxa90neydpfkjIl1M7vnrssYM3KLfw4OW5HLUPydC/Es88CGYbK
         1zdTZ1nDAr4EVFN9a4O4m1k22O8Twmpapw+amk5EeWkrqXmoGvYQWiUVr03Q7paCrzUj
         pSAC5/oa7gSlulI/k/Q5bigW7hk9RAvv6isoGa+5T/9+HYfEI9ZgpI3H3neUpuKmtLZ9
         /YWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:from:to:subject:references:in-reply-to:content-transfer-encoding
         :mime-version:date:message-id:arc-authentication-results;
        bh=x+nd/UN/HMSPg8MfM2yFST2ecWbM048Dmuqqhbv149k=;
        b=gpnseQejVLKEIrV46CmCZBpreAtS6EOvKJu2TFbHdCiBOkaVtllhp1T2JItbkfo67J
         4JqL0OiLqZPuXx3F1SxhRsC6+ofXbsU6OiOjRYDrr1rzkrzxn1VbdJo3BU3/FbcSKfw8
         9UPv6ipaIJuDVIPymee3G+rQQ8vfvUWGEZWKY99yu++7p33P4fAtKnyy8mka7Aacp5Ih
         MKsqTzyYzW1QxmzWKrre8yelafoag2pUxCYQxhamD0ST51i5+stGucZrOJWubD1NDYuH
         dFxB1jP5AfMWaORgv0mCokL3b8TBu/EXn/bOmSU43SVWtK2W5oyD9KJX60l6JipJOwVa
         OIRw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of bot@kernelci.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=bot@kernelci.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of bot@kernelci.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=bot@kernelci.org
X-Google-Smtp-Source: AIpwx4+yqTik8QIdHnMOQSNvGKKsOfh8WTIXl1Nt05JKlmKZWx8eTJV/kSTkm9BWROYyDST26RmKoQ==
Message-ID: <5ad67877.530a1c0a.586e2.0786@mx.google.com>
Date: Tue, 17 Apr 2018 15:43:03 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.14.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: boot
X-Kernelci-Kernel: v4.14.34-50-gadacb0d81317
In-Reply-To: <20180417155715.032245882@linuxfoundation.org>
References: <20180417155715.032245882@linuxfoundation.org>
Subject: Re: [PATCH 4.14 00/49] 4.14.35-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org
From: kernelci.org bot <bot@kernelci.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net,
 shuahkh@osg.samsung.com, patches@kernelci.org, ben.hutchings@codethink.co.uk,
 lkft-triage@lists.linaro.org, stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598010122739110875?=
X-GMAIL-MSGID: =?utf-8?q?1598035051712982025?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

stable-rc/linux-4.14.y boot: 54 boots: 0 failed, 52 passed with 2 untried/u=
nknown (v4.14.34-50-gadacb0d81317)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.14.y/kernel/v4.14.34-50-gadacb0d81317/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.14.=
y/kernel/v4.14.34-50-gadacb0d81317/

Tree: stable-rc
Branch: linux-4.14.y
Git Describe: v4.14.34-50-gadacb0d81317
Git Commit: adacb0d813172896acb603b9af86907f1ee62a1f
Git URL: http://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git
Tested: 28 unique boards, 11 SoC families, 13 builds out of 184

---
For more info write to <info@kernelci.org>
