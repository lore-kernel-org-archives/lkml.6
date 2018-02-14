Return-Path: <arndbergmann@gmail.com>
X-Cyrus-Session-Id: sloti22d1t05-3076253-1518620220-2-4115608370398526239
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.195, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_NONE -0.0001,
  RCVD_IN_MSPIKE_H3 -0.01, RCVD_IN_MSPIKE_WL -0.01, SPF_PASS -0.001,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.85.218.66', Host='mail-oi0-f66.google.com', Country='US',
  FromHeader='de', MailFrom='com'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: arndbergmann@gmail.com
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518620218; b=EFm3U/enTkUTG5m0ZG5+Bo4gRREKzRuG/CEJbEKvYY2fuxD
    ujQzp2c6vZNVQMRWuF1EIdUADvGBvPynkoUK7ura5A3KhEjBCML77f6HWPLVA9HV
    PH/+btg2Y2RQyF0nw4gLFvHGpuvV96QruGRZQKLsAxLUs+YQW3aISpyJrNLtDW4x
    zFvtVky1/AInEIM+87x5/RAOrU6giE6nwhSANJ1l+la6J796oR1vvqUJFB5VE6AJ
    82mqMxCx1kqJIMSlrkRPEZR4uQqh7Xrr/GUYXCxrQqThXId4XiON48J4UP8B4bSp
    Ol4ujcMf6afLD9wOIyrWv6fvFvEKZu1fdqRJbpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:sender:in-reply-to
    :references:from:date:message-id:subject:to:cc:content-type; s=
    arctest; t=1518620218; bh=P8HbTIohzMyFeNHPHkBrMJXCJfjW5V4ojYQ6Qu
    8VudE=; b=gmeJ8/1fUcBN/aBNaTxmakUya2XlOAgjcpf0oc79uT4R6k5Uz9KFQr
    vi5xp+TkEMmkrfA1AsZ2CBvw1sl6SJv8GMrNluwZhWVltxdVfbAgLKicw7GkTmiV
    qpFHbruRuAGWxAqzxZ05u0IiiuP42Z4AR/q9AVo18eR0wuK4eP4aTDOvsx/knmlf
    FWDkE6dfsMsfog0sGnYQxdkE59oxDV99b6BgR7LhoTL0ToozM3g8GxBnQPGto/fu
    ysxD2lDs7KgDg7M3hqgJjGKxCmtfF0YKtfKImywwlYsGFbWaoa9Tq2syx0W2DoNt
    hxIdHiA71dwSJXjTnQZS5WcN9bXG23eQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=tY2XoSxL x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.85.218.66 (mail-oi0-f66.google.com);
    spf=pass smtp.mailfrom=arndbergmann@gmail.com smtp.helo=mail-oi0-f66.google.com;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=O6Voy2w4;
    x-ptr=pass x-ptr-helo=mail-oi0-f66.google.com x-ptr-lookup=mail-oi0-f66.google.com;
    x-return-mx=pass smtp.domain=gmail.com smtp.result=pass smtp_is_org_domain=yes header.domain=arndb.de header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=tY2XoSxL x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.85.218.66 (mail-oi0-f66.google.com);
    spf=pass smtp.mailfrom=arndbergmann@gmail.com smtp.helo=mail-oi0-f66.google.com;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=O6Voy2w4;
    x-ptr=pass x-ptr-helo=mail-oi0-f66.google.com x-ptr-lookup=mail-oi0-f66.google.com;
    x-return-mx=pass smtp.domain=gmail.com smtp.result=pass smtp_is_org_domain=yes header.domain=arndb.de header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Google-Smtp-Source: AH8x226h8MnK4o60sp86IPD1ppoNRSDfzflBXHgeyZkWhaZpUc1Oel3rv4jnuQHepOz1r+fpaH3RXLJtAQYs2AL/MhY=
MIME-Version: 1.0
Sender: arndbergmann@gmail.com
In-Reply-To: <cover.1513577007.git.green.hu@gmail.com>
References: <cover.1513577007.git.green.hu@gmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 14 Feb 2018 15:56:56 +0100
X-Google-Sender-Auth: VRoeqFaYpcWJw-uaGIu9GHKIeBY
Message-ID: <CAK8P3a29LyG9erZ0L4vF-JNxirCyhrYb98ujDaV-P3R_r-B5Cg@mail.gmail.com>
Subject: Re: [PATCH v4 00/36] Andes(nds32) Linux Kernel
To: Greentime Hu <green.hu@gmail.com>
Cc: Greentime <greentime@andestech.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>,
	Marc Zyngier <marc.zyngier@arm.com>, Rob Herring <robh+dt@kernel.org>,
	Networking <netdev@vger.kernel.org>, Vincent Chen <deanbo422@gmail.com>,
	DTML <devicetree@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>,
	David Howells <dhowells@redhat.com>, Will Deacon <will.deacon@arm.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>, linux-serial@vger.kernel.org,
	Geert Uytterhoeven <geert.uytterhoeven@gmail.com>, Linus Walleij <linus.walleij@linaro.org>,
	Mark Rutland <mark.rutland@arm.com>, Greg KH <greg@kroah.com>, Guo Ren <ren_guo@c-sky.com>,
	Philippe Ombredanne <pombredanne@nexb.com>, Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Dec 18, 2017 at 7:46 AM, Greentime Hu <green.hu@gmail.com> wrote:
> This is the 4th version patchset to add the Linux kernel port for Andes(nds32)
> processors. Almost all of the feedbacks from v3 patchseries has been addressed.
> Thanks to everyone who provided feedback on the previous version.
>
>
> This patchset adds core architecture support to Linux for Andestech's
> N13, N15, D15, N10, D10 processor cores.
>
> Based on the 16/32-bit AndeStar RISC-like architecture, we designed the
> configurable AndesCore series of embedded processor families. AndesCores
> range from highly performance-efficient small-footprint cores for
> microcontrollers and deeply-embedded applications to 1GHz+ cores running
> Linux, covering general-purpose N-series cores for a wide range of computing
> need, DSP-capable D-series cores for digital signal control,
> instruction-extensible E-series cores for application-specific acceleration,
> and secure S-series cores for best protection of the most valuable.
>
> The patches are based on v4.14-rc8, and can also be found in the
> following git tree:
>   https://github.com/andestech/linux.git nds32-4.14-rc8-v4
>
> The build script and toolchain repositories are able to be found here:
>   https://github.com/andestech/build_script.git
>
> Freely available instruction set and architecture overview documents can
> be found on the following page:
>   http://www.andestech.com/product.php?cls=9
>
>
> Vincent Ren-Wei Chen and I will maintain this port. Thanks to everyone who
> helped us and contributed to it. :) Any feedback is welcome.

Aside from the missing Ack on the sparc patch, everything looks good to
get merged from my side this time.

I would suggest as next steps:

- ask Daniel to include the clocksource driver patches in his tree
- Provide a git tree with all the patches you plan to send for inclusion,
  based on v4.16-rc1.
- Add any further changes on top of that branch, without rebasing
  any further.
- give Stephen the git URL for inclusion in linux-next

      Arnd
