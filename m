Return-Path: <bot@kernelci.org>
ARC-Seal: i=1; a=rsa-sha256; t=1523035330; cv=none;
        d=google.com; s=arc-20160816;
        b=WivZV2wkjsZ6w9lG2KOVMFjV6YpfUaVDftRR0A9QhdbMqN8MqhTgFVt+FaAWRH1f0N
         MdpqYq3LFSVI6aUuCpkxQtK4+98oZx/YATGp2z/7wajwUFrhn5eGoBGil3WkAGNseWOh
         K2X5CISSUCp9R+ffp00ThGxojfIg6mGYf7Sa/uwpfmCn9N1W31pDuEYZYJ8fDoplVLW5
         4q8bskyY9vVwgmlYxwd6Oi2nIw3/zAF+efN28/5s/JKP8lBgysfdgUI7bieQkkyWSJJV
         eBsGvR28448fRWPOKnU9PierXMewn7n+ma9ksjp0qNPM8+TJLMF70Dvc3Xfv9efUyHV0
         /HUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:from:to:subject:references:in-reply-to:content-transfer-encoding
         :mime-version:date:message-id:arc-authentication-results;
        bh=7U8AloC/NEraWrxF8H3paAcTmPxaJpe8EV/5TXfrTQ4=;
        b=mDBfklVgv2OHKpE45Imz12rsLckzk8dm6nDH4iwHSVU5rx1sOyfAGB6IELyHBRHJM+
         x+TD/8tqWKWseryo3xw63eCT3iIlJ21/P0tyAZEP9vALPLRc4eZGVrHpGRJXORIzEyiX
         ewxFEp04h2faSnnXnOBkuobefNEoEANZW6YXfmJ7EM/IhrNOoyzTpzuhH8Tvbfwx3JdP
         QRiQJrk/S6KEkyua0O2DQfmAoAZ0ohdlFeKP0sGee2L4O+brHZ4OIsIPjLEjeISRrnEu
         dZusjxZkx8wlgXDTaS/bUl0Y8kYK1EkJRvBi2+OzIDZyguFER0bdlfeDJDkTQR88JfmE
         wKhw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of bot@kernelci.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=bot@kernelci.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of bot@kernelci.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=bot@kernelci.org
X-Google-Smtp-Source: AIpwx4/lRfGerGtURKrQwMqMhJXH5JW7GBV2I8DYPAlxeYhw3nopI25S6q/hH2gfy4i7SvctTHmJlA==
Message-ID: <5ac7acc0.96e81c0a.8518b.113f@mx.google.com>
Date: Fri, 06 Apr 2018 10:22:08 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-3.18.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: boot
X-Kernelci-Kernel: v3.18.102-94-ge51aafcc98be
In-Reply-To: <20180406084224.918716300@linuxfoundation.org>
References: <20180406084224.918716300@linuxfoundation.org>
Subject: Re: [PATCH 3.18 00/93] 3.18.103-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org
From: kernelci.org bot <bot@kernelci.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net,
 shuahkh@osg.samsung.com, patches@kernelci.org, ben.hutchings@codethink.co.uk,
 lkft-triage@lists.linaro.org, stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597003409912492787?=
X-GMAIL-MSGID: =?utf-8?q?1597018294489255093?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

stable-rc/linux-3.18.y boot: 17 boots: 0 failed, 17 passed (v3.18.102-94-ge=
51aafcc98be)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-3.18.y/kernel/v3.18.102-94-ge51aafcc98be/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-3.18.=
y/kernel/v3.18.102-94-ge51aafcc98be/

Tree: stable-rc
Branch: linux-3.18.y
Git Describe: v3.18.102-94-ge51aafcc98be
Git Commit: e51aafcc98be6a446a32b6f6cbee28b91d81bbf0
Git URL: http://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git
Tested: 9 unique boards, 7 SoC families, 9 builds out of 167

---
For more info write to <info@kernelci.org>
