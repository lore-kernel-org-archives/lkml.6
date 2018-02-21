Return-Path: <arndbergmann@gmail.com>
X-Cyrus-Session-Id: sloti22d1t05-1361518-1519213065-2-12750566206558360500
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.195, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_NONE -0.0001,
  RCVD_IN_MSPIKE_H3 -0.01, RCVD_IN_MSPIKE_WL -0.01, SPF_PASS -0.001,
  LANGUAGES enroda, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.85.216.194', Host='mail-qt0-f194.google.com', Country='US',
  FromHeader='de', MailFrom='com'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: arndbergmann@gmail.com
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519213065; b=kfBt4LnEY8jbspBU60nCy1LctBC2TQA08AacAFA+kx1UKOn
    7SGChBaPMCE12aSVFPmgZ/Vzw+80v21CsI8e3yE6Tg08yfpjpONH2HCP1oCR8oBq
    8Y3w93PtRPZ8LOSoVXJbB0zr7gddRvvHTR2SPW9lveUmF9RRgZo7Hcp647BQ9sZm
    xui9D2pIf7QzMdg4MkiKWSqXqrMq3sKyf+HaKzL9NUSRvXLBugbvtB3Imc6CDS1B
    SvkmGNouCJPTTapMJQC+17igWmrV7gN6SvM05KyesOSXdG+5sTUORjPH+RVG7j+i
    kREYMc4gf6MexjXatWgeIiXGSIZOXcgKvG1Mzjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:sender:in-reply-to
    :references:from:date:message-id:subject:to:cc:content-type; s=
    arctest; t=1519213065; bh=WelYqCdFvzOu9sJtrCYFPM1B6+4V5PgaD6IdzX
    Xib7Q=; b=O/V80wMSiOBagbo/BMkXSoB5AKg2cUPaQQQ3BDC1pEJOExGTIWBQWx
    mxv+n3ulUUubuDglL0NU/Y3WwKN5pVmdLaD65vKRt6u8nW7tYyce1jcFEqwwUiWK
    VfQpzKRThslGIL3qg2KNXE86TWOQjOwVD0+wO4ZiKTORLj288rSUreNs4tfbGuOy
    IaAVYEMbcYh7VJ2vKgf8P9AnjyhxEmUe8cLzYzWJ1vvb9xENbyp4AqV4dct0EP3V
    0xlrQc0GaWbjcWMi0FDluFtiUgk7jUttQEDcWduexnWHAG7tgbzbdDvKxm6ladaS
    GZuPKn9askC5ZwhR46P/sR3pqIt4Eqkg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=SsupP/z3 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.85.216.194 (mail-qt0-f194.google.com);
    spf=pass smtp.mailfrom=arndbergmann@gmail.com smtp.helo=mail-qt0-f194.google.com;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=sf7xOg8F;
    x-ptr=pass x-ptr-helo=mail-qt0-f194.google.com x-ptr-lookup=mail-qt0-f194.google.com;
    x-return-mx=pass smtp.domain=gmail.com smtp.result=pass smtp_is_org_domain=yes header.domain=arndb.de header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=SsupP/z3 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.85.216.194 (mail-qt0-f194.google.com);
    spf=pass smtp.mailfrom=arndbergmann@gmail.com smtp.helo=mail-qt0-f194.google.com;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=sf7xOg8F;
    x-ptr=pass x-ptr-helo=mail-qt0-f194.google.com x-ptr-lookup=mail-qt0-f194.google.com;
    x-return-mx=pass smtp.domain=gmail.com smtp.result=pass smtp_is_org_domain=yes header.domain=arndb.de header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Google-Smtp-Source: AH8x225M1RbbNNuAOW11kS5VBUKohE8+1Vg3Y9GIZhlHO0Sd2k5OO3fP4dn5cC6RrY9MgjB67DbqW2uoGRiJ+Oi3VgM=
MIME-Version: 1.0
Sender: arndbergmann@gmail.com
In-Reply-To: <CAEbi=3fMVLgqMxg5ru=Nd7YHTHs7YvirorT-zEtdBpMkuWHLyg@mail.gmail.com>
References: <ff404658ececd53f1bf111067c587c4e3eb695af.1518505384.git.greentime@andestech.com>
 <201802161853.FKQRlYLX%fengguang.wu@intel.com> <CAEbi=3fMVLgqMxg5ru=Nd7YHTHs7YvirorT-zEtdBpMkuWHLyg@mail.gmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 21 Feb 2018 12:37:43 +0100
X-Google-Sender-Auth: Xpm7diPXRO0K7b3R_L5vsG0BGJw
Message-ID: <CAK8P3a2pQTFiJ9Sr9pLFx-qFv1PAAs+KyPiRuB3qTLmtY2ZhYw@mail.gmail.com>
Subject: Re: [PATCH v7 02/37] asm-generic/io.h: move ioremap_nocache/ioremap_uc/ioremap_wc/ioremap_wt
 out of ifndef CONFIG_MMU
To: Greentime Hu <green.hu@gmail.com>
Cc: kbuild test robot <lkp@intel.com>, kbuild-all@01.org, Greentime <greentime@andestech.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>,
	Marc Zyngier <marc.zyngier@arm.com>, Rob Herring <robh+dt@kernel.org>,
	netdev <netdev@vger.kernel.org>, Vincent Chen <deanbo422@gmail.com>,
	DTML <devicetree@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>,
	David Howells <dhowells@redhat.com>, Will Deacon <will.deacon@arm.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>, linux-serial@vger.kernel.org,
	Geert Uytterhoeven <geert.uytterhoeven@gmail.com>, Linus Walleij <linus.walleij@linaro.org>,
	Mark Rutland <mark.rutland@arm.com>, Greg KH <greg@kroah.com>, Guo Ren <ren_guo@c-sky.com>,
	Randy Dunlap <rdunlap@infradead.org>, David Miller <davem@davemloft.net>,
	Jonas Bonn <jonas@southpole.se>,
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, Stafford Horne <shorne@gmail.com>,
	Vincent Chen <vincentc@andestech.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Feb 21, 2018 at 12:21 PM, Greentime Hu <green.hu@gmail.com> wrote:
> 2018-02-16 18:47 GMT+08:00 kbuild test robot <lkp@intel.com>:

>
> From: Greentime Hu <greentime@andestech.com>
> Date: Wed, 21 Feb 2018 14:21:23 +0800
> Subject: [PATCH] xtensa: add ioremap_nocache declaration before include
>  asm-generic/io.h.
>
> A future commit for the nds32 architecture bootstrap("asm-generic/io.h:
> move ioremap_nocache/ioremap_uc/ioremap_wc/ioremap_wt out of ifndef
> CONFIG_MMU") will move the ioremap_nocache out of the CONFIG_MMU ifdef.
> This means that in order to suppress re-definition errors we need to
> setup #define's before importing asm-generic/io.h.
>
> Signed-off-by: Greentime Hu <greentime@andestech.com>

Don't you need to override both ioremap and ioremap_nocache?

> ---
>  arch/xtensa/include/asm/io.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/xtensa/include/asm/io.h b/arch/xtensa/include/asm/io.h
> index c38e5a732d86..acc5bb2cf1c7 100644
> --- a/arch/xtensa/include/asm/io.h
> +++ b/arch/xtensa/include/asm/io.h
> @@ -52,6 +52,7 @@ static inline void __iomem *ioremap_cache(unsigned
> long offset,
>                 return xtensa_ioremap_cache(offset, size);
>  }
>  #define ioremap_cache ioremap_cache
> +#define ioremap_nocache ioremap_nocache
>
>  #define ioremap_wc ioremap_nocache
