Return-Path: <khilman@baylibre.com>
ARC-Seal: i=1; a=rsa-sha256; t=1518811655; cv=none;
        d=google.com; s=arc-20160816;
        b=M6f1EcJ6rLXnw9SJt8Sf7IVfZLHNPvYVNePx+EyxW+XdtG8M7d3T7SYV8cg8cl/geq
         noo7r//BGyAwDWc4KA9Q6+RtFdCrZPQOJPMUtMHaMZggzFg+MNPz1N/HfvTBQu2gfJlx
         owi0T5IB2QwPvheYJ2ibcgGckT4RsrT/GTmIRGHELKeeQ08xvb+pB2eHWX+Yv9wmJUwA
         bIJvmeNjCVaeNhBFZECgFw7V8sbcJ97j3AMfBjPoVpWz/L6WbhvDFi8WsHN9Y0xf5rmy
         mnGY8m4lTq96NjExTF9IXWdAMj//231oX2faQ65MHVCQCkdGsiub0rl7mssJ5pcSP9BW
         OnZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :organization:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=4k/1CoMKD0YCWlrHpMthSi7nnj8A1yiNrmWgMDbH1FE=;
        b=uaxpwxNZXB1JuWddiOIPm1gstaJL0zN2HoNtvbABwcRrbnys1RLFTy6HLIDpsd3hz3
         HXX3yFo5AjzhuOazbrWYDazSdT1tjBxvfl+QmjvSVuxnXFzoCSk0ZuxWEG9bLe+Qbt4z
         6IvIQylQe7WVmGpOnnJA4i0LbOA7vTAxLohX7zC6xodeuJMWcNxk2i1eMX4RKur3I50t
         fOSNfJOvu+jVyDimck1aUxrDbN/cpMZzZyEg3Nl5iupsS2HQzG1zLjRPiTUesJBEMvXe
         pLsuPfjMhAYSADADg2axfO5AGwg+azOznxqAzJWwzS/mxugILd6WfSQ29VQhBWQTe2Od
         yIHg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@baylibre-com.20150623.gappssmtp.com header.s=20150623 header.b=XpSNE3yQ;
       spf=softfail (google.com: domain of transitioning khilman@baylibre.com does not designate 209.85.220.65 as permitted sender) smtp.mailfrom=khilman@baylibre.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@baylibre-com.20150623.gappssmtp.com header.s=20150623 header.b=XpSNE3yQ;
       spf=softfail (google.com: domain of transitioning khilman@baylibre.com does not designate 209.85.220.65 as permitted sender) smtp.mailfrom=khilman@baylibre.com
X-Google-Smtp-Source: AH8x2261ySTbOPnafV8if/iuT06Vi32GHxXLglQcd2EBPTtnBeBAuvdBWqq+3ZvFKwdsouDGSEPKWw==
From: Kevin Hilman <khilman@baylibre.com>
To: kernelci.org bot <bot@kernelci.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,  linux-kernel@vger.kernel.org,  torvalds@linux-foundation.org,  akpm@linux-foundation.org,  linux@roeck-us.net,  shuahkh@osg.samsung.com,  patches@kernelci.org,  ben.hutchings@codethink.co.uk,  lkft-triage@lists.linaro.org,  stable@vger.kernel.org
Subject: Re: [PATCH 3.18 00/45] 3.18.95-stable review
Organization: BayLibre
References: <20180215144115.863307741@linuxfoundation.org>
	<5a85dcaa.42e61c0a.bc4d0.dd5f@mx.google.com>
Date: Fri, 16 Feb 2018 12:07:32 -0800
In-Reply-To: <5a85dcaa.42e61c0a.bc4d0.dd5f@mx.google.com> (kernelci org bot's
	message of "Thu, 15 Feb 2018 11:16:58 -0800 (PST)")
Message-ID: <7hsha03dh7.fsf@baylibre.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592480703978774067?=
X-GMAIL-MSGID: =?utf-8?q?1592589450190187152?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

kernelci.org bot <bot@kernelci.org> writes:

> stable-rc/linux-3.18.y boot: 63 boots: 2 failed, 51 passed with 5 offline, 5 conflicts (v3.18.94-46-g72255f521206)
>
> Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux-3.18.y/kernel/v3.18.94-46-g72255f521206/
> Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-3.18.y/kernel/v3.18.94-46-g72255f521206/
>
> Tree: stable-rc
> Branch: linux-3.18.y
> Git Describe: v3.18.94-46-g72255f521206
> Git Commit: 72255f5212068a6f4936e55b7089aa8e76d3b4ce
> Git URL: http://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
> Tested: 29 unique boards, 12 SoC families, 13 builds out of 183

TL;DR;  All is well.

> Boot Regressions Detected:
>
> arm:
>
>     multi_v7_defconfig:
>         am335x-boneblack:
>             lab-collabora: new failure (last pass: v3.18.91-37-gd5790feb0d8a)
>         dra7-evm:
>             lab-baylibre: new failure (last pass: v3.18.94-27-gc19bd79392f2)
>         qemu:
>             lab-baylibre: new failure (last pass: v3.18.94-27-gc19bd79392f2)
>
>     omap2plus_defconfig:
>         dra7-evm:
>             lab-baylibre: new failure (last pass: v3.18.94-27-gc19bd79392f2)
>
>     vexpress_defconfig:
>         qemu:
>             lab-baylibre: new failure (last pass: v3.18.94-27-gc19bd79392f2)
>
> arm64:
>
>     defconfig:
>         qemu:
>             lab-baylibre: new failure (last pass: v3.18.94-27-gc19bd79392f2)
>
> x86:
>
>     x86_64_defconfig:
>         qemu:
>             lab-baylibre: new failure (last pass: v3.18.94-27-gc19bd79392f2)

These are all lab infrastructure issues.  Most of them from the BayLibre
lab which was (mistakenly) upgraded in the middle of a batch of jobs.
Oops.

Kevin
