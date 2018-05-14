Return-Path: <bot@kernelci.org>
ARC-Seal: i=1; a=rsa-sha256; t=1526298333; cv=none;
        d=google.com; s=arc-20160816;
        b=ctZp0oZouFTpr2/fzxYsWurqH76xlP/OQCi0kV6njY0a6+b6t7c5PBTO6wONWPfJA0
         PEdvYseJHJk+6WlO7jmyZf4PvNgiwAKjYyoCKRqujNhgVBG4hF1XEZCU44bO/BdVGIYv
         9wWXvSLQsKjjD/l+xOAXZzRxIv5Hr12wL1kXsjyPTW/AsHJoVw5YV0nhWgwwfL8fi2XW
         e12xPr24gDnYSu8mi+IAu+0Mg22y6BBkuVthSHCw2ieB7ZDoT6QTG8TMGSx8O0RrS54H
         nkCe26F+gMv+g5eZW1CPwzstsAeGXsga0v9sWEdxVe/1Ipdba94k4jHR01SSqyQfMwiE
         ylSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:from:to:subject:references:in-reply-to:content-transfer-encoding
         :mime-version:date:message-id:arc-authentication-results;
        bh=iXNjM28VtVrgttnatNFsOODRXFhdYenoKNHeBMFJzW4=;
        b=eeD2JOfpzF3VDq65J/OOILCBFqa6IjFkmZdaHgJLKmeBA0dIkPrWNHlu0mx+VbrK8P
         z+zfBfCa/NaDytkksRaXiUuL9TIufb6+Cfjo0b20CMay5wylcZmhaXJ5b0q8ZTI15VzQ
         QOMFJK3UYvnps+W2B03JYze8s7cFQs6r/ulHVpab9xm9VllTN6ok0e1qzAAMS5POk3LZ
         jA79cI1SgEbisIDnf0F60hIVNSIe/Bb+3aMAR/Di6hK5eYiMRz6ab8oTL3meClZ8SdA6
         Nt1LryJDk88uti63V8/fTwAx8fdyEubjiFpwuEbioAzOvGvfiTJpedX+QMdLmJertqnz
         0i+A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of bot@kernelci.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=bot@kernelci.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of bot@kernelci.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=bot@kernelci.org
X-Google-Smtp-Source: AB8JxZplA0DWXlRYY7ZEiNHQeVsa4Ip0KBV5Z1Uy5so4kNyxUHWajTePuxI775BnCuDY0eOrMh3B0A==
Message-ID: <5af976dc.1c69fb81.b5d25.dea9@mx.google.com>
Date: Mon, 14 May 2018 04:45:32 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-3.18.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: boot
X-Kernelci-Kernel: v3.18.108-24-ge49426a0ea55
In-Reply-To: <20180514064704.046463679@linuxfoundation.org>
References: <20180514064704.046463679@linuxfoundation.org>
Subject: Re: [PATCH 3.18 00/23] 3.18.109-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org
From: kernelci.org bot <bot@kernelci.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net,
 shuah@kernel.org, patches@kernelci.org, ben.hutchings@codethink.co.uk,
 lkft-triage@lists.linaro.org, stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600421228954413853?=
X-GMAIL-MSGID: =?utf-8?q?1600439801608108428?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

stable-rc/linux-3.18.y boot: 57 boots: 0 failed, 57 passed (v3.18.108-24-ge=
49426a0ea55)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-3.18.y/kernel/v3.18.108-24-ge49426a0ea55/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-3.18.=
y/kernel/v3.18.108-24-ge49426a0ea55/

Tree: stable-rc
Branch: linux-3.18.y
Git Describe: v3.18.108-24-ge49426a0ea55
Git Commit: e49426a0ea55769beb5106053bc70e453c8919a2
Git URL: http://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git
Tested: 24 unique boards, 11 SoC families, 13 builds out of 167

---
For more info write to <info@kernelci.org>
