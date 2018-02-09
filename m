Return-Path: <bot@kernelci.org>
ARC-Seal: i=1; a=rsa-sha256; t=1518197786; cv=none;
        d=google.com; s=arc-20160816;
        b=TqwvdAabBt/XEDkH5I6HB0KgKO5/0coJ+29I56FJ98MvpHqrlRkpB05i4K8ipyuHZI
         bDxK6OtJt1VNF6xHSJcH1N6sEukp8q66hulPVQj4PV4KdJVRn3BU0w+IQxlMR2SSixGb
         3kneVWwTOvzrf3qv/xnStkx0UBWsT8pJpqsFR+F5NjyFD7wTvlEaGL0sgC95+IuzKDi/
         pixKHo0Qe2Ek+6td+pQTM6/If/C6k9Kj2fkJJrCV5DqQ57zIiRa5oGn5d/d4/rpbmCUC
         A+VHN90uL+yN5JDcE6BeD/MHw4EdpRbo0AqcCXF2GpQOYvV4yMe3C1k6CwZAF0fvIfCO
         HJKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:from:to:subject:references:in-reply-to:content-transfer-encoding
         :mime-version:date:message-id:arc-authentication-results;
        bh=He6D6rD5L8EyjYzwrbw8wlEenUh42+8GXCU14IarfXY=;
        b=FEdECIGBLmHajeUgTFqzMpx0FTUpfpPXhPEcW9vUEfwEBiYrM9txxoQYjo/qm/Rh59
         o6Qz3bK/olIVW3cTXhZL/lMFF6LYmaW42zkQGDZR4Tb3EG5CdhFRO2zqmGL3MnaLTwA5
         uTBoLx+a9Y4p21VmsuUWoupieyXdehYoi9Z2uAROP2MDPLSGm9By2AQ48qEReyz5dvJL
         wMIMNcDKfEPJTlu78NP4GvtDjvUAHVe1y7WFDhJY6X9yugtUGlHvCfBPy5yW1+uXOIWG
         mfE3VAmSLnuVYqFnbrXXn8pxXNpTyVjqJMIbxDxbLCM5eWfJ/WuUdM891Cj/DkSmrlHs
         U0pg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of bot@kernelci.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=bot@kernelci.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of bot@kernelci.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=bot@kernelci.org
X-Google-Smtp-Source: AH8x226TN0zuNZSTrNS84MzycUwf+GJvl2bDmnuFRdwlDFslHoQbK+FkMLY3ENggVV7Mn1cwXyNa3g==
Message-ID: <5a7ddc18.25addf0a.b442a.7eab@mx.google.com>
Date: Fri, 09 Feb 2018 09:36:24 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v4.15.2-23-g1b51f4a14c4b
X-Kernelci-Report-Type: boot
X-Kernelci-Branch: linux-4.15.y
X-Kernelci-Tree: stable-rc
In-Reply-To: <20180209133938.366024920@linuxfoundation.org>
References: <20180209133938.366024920@linuxfoundation.org>
Subject: Re: [PATCH 4.15 00/23] 4.15.3-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org
From: kernelci.org bot <bot@kernelci.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net,
 shuahkh@osg.samsung.com, patches@kernelci.org, ben.hutchings@codethink.co.uk,
 lkft-triage@lists.linaro.org, stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591931344572458017?=
X-GMAIL-MSGID: =?utf-8?q?1591945761326559510?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

stable-rc/linux-4.15.y boot: 25 boots: 0 failed, 25 passed (v4.15.2-23-g1b5=
1f4a14c4b)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.15.y/kernel/v4.15.2-23-g1b51f4a14c4b/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.15.=
y/kernel/v4.15.2-23-g1b51f4a14c4b/

Tree: stable-rc
Branch: linux-4.15.y
Git Describe: v4.15.2-23-g1b51f4a14c4b
Git Commit: 1b51f4a14c4b2c676e78dec23fa93c00711a8db2
Git URL: http://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git
Tested: 20 unique boards, 11 SoC families, 4 builds out of 77

---
For more info write to <info@kernelci.org>
