Return-Path: <bot@kernelci.org>
ARC-Seal: i=1; a=rsa-sha256; t=1527177988; cv=none;
        d=google.com; s=arc-20160816;
        b=czCy5q1zcaHXAi6vCnOX83hZtY2UVKQTt9l/dlwCbBx65aKWk7V4X4kohGPz1Ndwga
         HU/3sKO/N4dqmBW1XmAOIa3H0sqfTH/WY760J2RXZjSHD06KcGg8/izw6GfVYR5hU6Ky
         eJttoiV1YmptlzIrxilQna8Z5E+j9/6+FMZYB2hOE747Zcjp4H5K7/aO+AG4HaxGEXcl
         o/CNRlTLMz5G9huqD1LVZIAtMVj3kMo9PyxZXSGrS+PrqFMj5tLeMQWGrMYTX7TPImmn
         Lq/tZCyo8BInHBzd9Q3aDEai4iTg17gQcmBhjjYHJP3UoyovaVy7CFRTsrb2Jf0SYn3f
         FkCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:from:to:subject:references:in-reply-to:content-transfer-encoding
         :mime-version:date:message-id:arc-authentication-results;
        bh=xFaTcI/BWJuc9kG+FN9hladAcFwS+j9P92HdWdF4zfA=;
        b=sfMv6mWc5nNGbkL9E3UJavKKfahQFhuKS5UfrjqcyS6htNVIQpEbVIbt/xM+b9tCdj
         9wSTQIZSpHI8X6AaShCk+y+JGzSEwkCi6MOw/mIDBXAnK/MKnr59YZ/5Y+eoZmfQ7yJ2
         enEqcFE7W9PdyoEZrTyUdGD15NraVzVSucDbVGpxfwRdReQhsf1ck0VCJU+Ell7X+4lG
         lbhDhXlaJUWjI2sTj+6Ky8AgM+tkdVt8jSA1qurO8S/C4SjEDwbaOmGFLANMNKaNZiRJ
         ph23lJBau3yHlVZ4H8x0b0sCq/PZQ0znU3QFpboXl3i5sGjcbep0unMyW1yM+mq85glo
         SDmg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of bot@kernelci.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=bot@kernelci.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of bot@kernelci.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=bot@kernelci.org
X-Google-Smtp-Source: AB8JxZpucykrjps4hI5oseg/v9KLleNQa/o7h4vFU78mwGk3LIJffX2wC2NlQqByf+XlV0P3WoUoQw==
Message-ID: <5b06e302.1c69fb81.98afb.362d@mx.google.com>
Date: Thu, 24 May 2018 09:06:26 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: stable-rc
X-Kernelci-Branch: linux-3.18.y
X-Kernelci-Report-Type: boot
X-Kernelci-Kernel: v3.18.109-46-gacd79130b74c
In-Reply-To: <20180524093120.599252450@linuxfoundation.org>
References: <20180524093120.599252450@linuxfoundation.org>
Subject: Re: [PATCH 3.18 00/45] 3.18.110-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org
From: kernelci.org bot <bot@kernelci.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net,
 shuah@kernel.org, patches@kernelci.org, ben.hutchings@codethink.co.uk,
 lkft-triage@lists.linaro.org, stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1601337967363702894?=
X-GMAIL-MSGID: =?utf-8?q?1601362186328113516?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

stable-rc/linux-3.18.y boot: 62 boots: 0 failed, 61 passed with 1 conflict =
(v3.18.109-46-gacd79130b74c)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-3.18.y/kernel/v3.18.109-46-gacd79130b74c/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-3.18.=
y/kernel/v3.18.109-46-gacd79130b74c/

Tree: stable-rc
Branch: linux-3.18.y
Git Describe: v3.18.109-46-gacd79130b74c
Git Commit: acd79130b74c1ab369ef4cb2b5c01c8b2fd7c10a
Git URL: http://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git
Tested: 27 unique boards, 12 SoC families, 14 builds out of 183

Boot Regressions Detected:

x86:

    x86_64_defconfig:
        qemu:
            lab-baylibre: new failure (last pass: v3.18.109-38-g6dc0d861287=
e)

Conflicting Boot Failure Detected: (These likely are not failures as other =
labs are reporting PASS. Needs review.)

x86:

    x86_64_defconfig:
        qemu:
            lab-mhart: PASS
            lab-collabora: PASS
            lab-baylibre: FAIL

---
For more info write to <info@kernelci.org>
