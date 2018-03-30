Return-Path: <khilman@baylibre.com>
ARC-Seal: i=1; a=rsa-sha256; t=1522454177; cv=none;
        d=google.com; s=arc-20160816;
        b=QONIKvyPG8AFyLmEvs+5VdDtHPiK/TU0ENxjU05FHIIB1nqov7f+DGSp9a20pOagl2
         L6EN9PVPQgbVs9OTLRn6uYGL8Z7ycI39lfDHeHSLHtwVxNGIh6XfwpupijaU9r01FE9X
         w0LAZXRPC9jngQoCkCuk/+4c9hL8hRP+wVTQwdVvGFzWB7EvY7LyEO1ci853VOi7jKX3
         2Y2nNaD5xrEaODiiq2bPrROMFPmBg0MowUBPjqm2lp3FcNl4BcsBrOFc8SsEB86RwLPI
         SW1wqocJVsSAHoLp6kF8tldfe9G6AbRs8Ud+/cmphb/RCu+dCCpkoSrGXrSjDs4rwG+D
         kxOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :organization:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=ZoDrbFZ0FVF6lhIh9ipxbno6CMyWIA2QVMuSNBITDq4=;
        b=MWqNWxM4kKaCYN80+vU1ScwjO0CnsaF452CYblJUqXHoowhrQYgm7piQkP7h7kFf4O
         wSVStm+CWZqjfLBH7xTSia8T8WI66kAAi7o1RPyg7KRqcaloslnpEjwY5d3HxpX1/VAv
         7t5XlVjSfy6HwyY7VUDiOxZc1T7Cp/ZuSGzcYKn/IZkvh7lWtcIuvJU3W0BLSoGERunm
         yFgTBbH/SMR5GC2505rMAicetIpEgtLdFKWKi0tJPZGocAP8LsH+9jNEtwp2GRbR7l4A
         UpC4ZU2Irrgg7IS2NyOTEAU31t7zEFOIXCKYfL2fuCk3yT8fE+Dl67veXsWW8VbmQYEj
         zY4A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@baylibre-com.20150623.gappssmtp.com header.s=20150623 header.b=WmFhpXmb;
       spf=softfail (google.com: domain of transitioning khilman@baylibre.com does not designate 209.85.220.41 as permitted sender) smtp.mailfrom=khilman@baylibre.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@baylibre-com.20150623.gappssmtp.com header.s=20150623 header.b=WmFhpXmb;
       spf=softfail (google.com: domain of transitioning khilman@baylibre.com does not designate 209.85.220.41 as permitted sender) smtp.mailfrom=khilman@baylibre.com
X-Google-Smtp-Source: AIpwx4+Ni8OnL2sNc1hIxALknT89CxxkgZJ4fEnFFCEC3k58FFjiFnQ6a+/jJhYmsExvc33xD60B+Q==
From: Kevin Hilman <khilman@baylibre.com>
To: kernelci.org bot <bot@kernelci.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,  linux-kernel@vger.kernel.org,  torvalds@linux-foundation.org,  akpm@linux-foundation.org,  linux@roeck-us.net,  shuahkh@osg.samsung.com,  patches@kernelci.org,  ben.hutchings@codethink.co.uk,  lkft-triage@lists.linaro.org,  stable@vger.kernel.org, kernelci@bootlin.com
Subject: Re: [PATCH 4.4 00/43] 4.4.125-stable review
Organization: BayLibre
References: <20180327162716.407986916@linuxfoundation.org>
	<5abae002.12ed1c0a.739b4.cbfe@mx.google.com>
Date: Fri, 30 Mar 2018 16:56:13 -0700
In-Reply-To: <5abae002.12ed1c0a.739b4.cbfe@mx.google.com> (kernelci org bot's
	message of "Tue, 27 Mar 2018 17:21:22 -0700 (PDT)")
Message-ID: <7htvsx5d9e.fsf@baylibre.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596108971471558440?=
X-GMAIL-MSGID: =?utf-8?q?1596408910954891135?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

kernelci.org bot <bot@kernelci.org> writes:

> stable-rc/linux-4.4.y boot: 98 boots: 2 failed, 37 passed with 56 offline, 3 untried/unknown (v4.4.124-44-g9d0ab5d17182)
>
> Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux-4.4.y/kernel/v4.4.124-44-g9d0ab5d17182/
> Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.4.y/kernel/v4.4.124-44-g9d0ab5d17182/
>
> Tree: stable-rc
> Branch: linux-4.4.y
> Git Describe: v4.4.124-44-g9d0ab5d17182
> Git Commit: 9d0ab5d17182f9bbe3a4c1d8412f387302bc82d0
> Git URL: http://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
> Tested: 51 unique boards, 20 SoC families, 15 builds out of 174

TL;DR;  All is well.

> Boot Regressions Detected:
>
> arm:
>
>     at91_dt_defconfig:
>         at91sam9261ek:
>             lab-free-electrons: failing since 5 days (last pass: v4.4.123 - first fail: v4.4.123-97-g3054df73e9af)
>
>     sama5_defconfig:
>         sama5d36ek:
>             lab-free-electrons: new failure (last pass: v4.4.124)

These have been reported to Bootlin lab awhile back and appear to be lab
issues, but haven't heard back from them yet.

Kevin
