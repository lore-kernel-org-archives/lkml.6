Return-Path: <khilman@baylibre.com>
ARC-Seal: i=1; a=rsa-sha256; t=1520553904; cv=none;
        d=google.com; s=arc-20160816;
        b=t1FtM82fq7F1bkk8ZF1cAQgd9/lyqLddONhUgeEXoMmiGTIBBo3nv31451uzuvpp0K
         LMi9i3yx1HH6GjYvuQu2Xvcc7aYKJukhVnkDUbdhIiQdZH6HNXCQ4bYuxjKy7Do+Ok90
         8GgLbZN/fM1j8P27rCVYqRsj9YJTCmGQLQZuKqBoS/hy4V1FV8C/WvuubF4L1ZzzOcQu
         ykBCBtKBu9kUY2ejHvLStXml0wgLqpWo5F4QMg+YtGv4iaC+3v4qwsmqedS3GTPny4Cl
         ZcPYn0rgq+aazdE+CGsV+hXPuQkJSOhS/80pLlS+V4qlmarFI2dPG1ynnW+1FM25dOJl
         9EnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :organization:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=fUow6JTXcrRvLkL/c47bJ8tbHISRt5A0Cq9oNY27GVg=;
        b=uaOPdPyI7ObnRYlmtyCC7HrI7Tx3AFOpUTas6mOpMESbWzpT3bc2kvcFFtmeMNWue6
         mAvyEX1bJDVyz9GN7zdR72qEYYCqa9FGXMSfTVnlgPyyIzErXod7NKZS0MCr1zFX1zS9
         KA6otS1un5tDbllWA5vZnedadjqzfgFEeqohNRZlh9BSn43tQaixASHq4xfy/c7Sdfvv
         3/+SQK8DZ2lgtOFN3N5Qpuw5a80fSrJv2U+pRQSi/yGSHXMI/tNDGB+PkkhJWVVdYohr
         ItQk6bwZgoG139qc176X0yThLCp9hGG3hhGux8doa3pR3+cU6C0zIApYzXMPE9rBHynw
         FIdg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@baylibre-com.20150623.gappssmtp.com header.s=20150623 header.b=2PfhC+3a;
       spf=softfail (google.com: domain of transitioning khilman@baylibre.com does not designate 209.85.220.65 as permitted sender) smtp.mailfrom=khilman@baylibre.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@baylibre-com.20150623.gappssmtp.com header.s=20150623 header.b=2PfhC+3a;
       spf=softfail (google.com: domain of transitioning khilman@baylibre.com does not designate 209.85.220.65 as permitted sender) smtp.mailfrom=khilman@baylibre.com
X-Google-Smtp-Source: AG47ELuZEjl3BLMxmg9CvBE4TfSOkiPqJhQJ7mbthj48ADDPt6w7xYjaSs9FZM9I6A/g072S3csKEw==
From: Kevin Hilman <khilman@baylibre.com>
To: kernelci.org bot <bot@kernelci.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,  linux-kernel@vger.kernel.org,  torvalds@linux-foundation.org,  akpm@linux-foundation.org,  linux@roeck-us.net,  shuahkh@osg.samsung.com,  patches@kernelci.org,  ben.hutchings@codethink.co.uk,  lkft-triage@lists.linaro.org,  stable@vger.kernel.org, kernelci@free-electrons.com
Subject: Re: [PATCH 4.14 000/110] 4.14.25-stable review
Organization: BayLibre
References: <20180307191039.748351103@linuxfoundation.org>
	<5aa0b9c4.f8aedf0a.117e1.748d@mx.google.com>
Date: Thu, 08 Mar 2018 16:05:01 -0800
In-Reply-To: <5aa0b9c4.f8aedf0a.117e1.748d@mx.google.com> (kernelci org bot's
	message of "Wed, 07 Mar 2018 20:19:16 -0800 (PST)")
Message-ID: <7h4llqf70y.fsf@baylibre.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594309365480057936?=
X-GMAIL-MSGID: =?utf-8?q?1594416330904914121?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

kernelci.org bot <bot@kernelci.org> writes:

> stable-rc/linux-4.14.y boot: 148 boots: 4 failed, 133 passed with 7 offline, 3 untried/unknown, 1 conflict (v4.14.24-111-g66060ac1dfa0)
>
> Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux-4.14.y/kernel/v4.14.24-111-g66060ac1dfa0/
> Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.14.y/kernel/v4.14.24-111-g66060ac1dfa0/
>
> Tree: stable-rc
> Branch: linux-4.14.y
> Git Describe: v4.14.24-111-g66060ac1dfa0
> Git Commit: 66060ac1dfa02f02646a55f6ed888c0f2001623e
> Git URL: http://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
> Tested: 76 unique boards, 23 SoC families, 17 builds out of 182

TL;DR; All is well.

> Boot Regressions Detected:
>
> arm:
>
>     davinci_all_defconfig:
>         da850-evm:
>             lab-baylibre-seattle: failing since 1 day (last pass: v4.14.4-76-gf91a57b206e0 - first fail: v4.14.24)

Operator error in my lab.

>     multi_v7_defconfig:
>         armada-375-db:
>             lab-free-electrons: new failure (last pass: v4.14.24)
>         sun8i-h3-orangepi-pc:
>             lab-free-electrons: failing since 1 day (last pass: v4.14.18-23-g8d861f5b27b0 - first fail: v4.14.24)
>
>     sunxi_defconfig:
>         sun8i-h3-orangepi-pc:
>             lab-free-electrons: failing since 5 days (last pass: v4.14.18-23-g8d861f5b27b0 - first fail: v4.14.23-116-g0ae11358b0bd)

These three are also not kernel issues.  Seems the lab having problems
connecting to the boards.  Cc'd Free Electrons team for closer look.

Kevin
