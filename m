Return-Path: <green.hu@gmail.com>
X-Cyrus-Session-Id: sloti22d1t05-1383150-1519214605-2-18237501840238685617
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FROM 0.001, RCVD_IN_DNSWL_NONE -0.0001,
  RCVD_IN_MSPIKE_H3 -0.01, RCVD_IN_MSPIKE_WL -0.01, SPF_PASS -0.001,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.85.213.67', Host='mail-vk0-f67.google.com', Country='US',
  FromHeader='com', MailFrom='com'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: green.hu@gmail.com
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519214605; b=RwH9zpTnfqbsavoWVPWc7ApieDul8jg2Sd+YolkRZF6WtEA
    i3WBVFzFMNdqaO46KUMZilkMehyLAdLhTyM64maGIlQBtDinCU2vWMMyrziqjjF7
    cqZXlSCyDGlxDIbuNf6RapVDP2MGv7HINHhy+EKLs0QzdJlZ9hxLw+AcwZ/Gzqsg
    8P85rnYA5DIsUFGoBScS2RNf4vNQPlR0AWrWU0fLYiJ0Oq/qbjmOp5Q7ijt1W2MQ
    nAn8rZjYbcSqOMe5YgnZniCUtI/xWrA6WT8Y9rnTGdE4tkcsxaq/Yf/nKRsfg1dt
    RioE9syrsGDTLoIHv6qjFag/+Fs6kRbEifSebwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type; s=arctest; t=
    1519214605; bh=bK+7d3XPkx/Nx3V4acWSI0/vEokMTsGZlKqOpeTQPsU=; b=d
    zEiPIQ9FRzNa2yqheivPltg/hDc9QuFH8oYdSljmmbS1SJQYELqn0BE4zGWagTxJ
    O4qfEDyEbLNWoDpXuRZOeJukLYJrba0QH17g45VBexdX56POYWsJcvdidvBaNDZp
    rGe/+1MtjrEI24vV8sv8Gwl+xQAQltaOzoaOv2PKYXl9B7l0GCdq1ydko5VeS2LA
    5xDUJKS4YPsWd4nKq5C6tTHQCq4+ryHhkPDrAdtqiESU7g33Zhu30A/+yygVlcWa
    PyK53rPM9yDdIW+EDKGVRP5lYVrMHsD2RrGheQWqoGrmmcg9m57YKv67+pKrAJ7q
    TrTNXye9RaAtoVHLf/bJw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=Owj9/wy0 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.85.213.67 (mail-vk0-f67.google.com);
    spf=pass smtp.mailfrom=green.hu@gmail.com smtp.helo=mail-vk0-f67.google.com;
    x-aligned-from=pass;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=k9QIFynK;
    x-ptr=pass x-ptr-helo=mail-vk0-f67.google.com x-ptr-lookup=mail-vk0-f67.google.com;
    x-return-mx=pass smtp.domain=gmail.com smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=Owj9/wy0 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.85.213.67 (mail-vk0-f67.google.com);
    spf=pass smtp.mailfrom=green.hu@gmail.com smtp.helo=mail-vk0-f67.google.com;
    x-aligned-from=pass;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=k9QIFynK;
    x-ptr=pass x-ptr-helo=mail-vk0-f67.google.com x-ptr-lookup=mail-vk0-f67.google.com;
    x-return-mx=pass smtp.domain=gmail.com smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Google-Smtp-Source: AH8x224VdHpFDOpgn8vhS5MtgBZTdcw2kOVWU2XIGUWiRxlW8ytyZSi2XpAGbm8WjIBt8bttXdYQKo+v1+goEqBjgxY=
MIME-Version: 1.0
In-Reply-To: <CAK8P3a2pQTFiJ9Sr9pLFx-qFv1PAAs+KyPiRuB3qTLmtY2ZhYw@mail.gmail.com>
References: <ff404658ececd53f1bf111067c587c4e3eb695af.1518505384.git.greentime@andestech.com>
 <201802161853.FKQRlYLX%fengguang.wu@intel.com> <CAEbi=3fMVLgqMxg5ru=Nd7YHTHs7YvirorT-zEtdBpMkuWHLyg@mail.gmail.com>
 <CAK8P3a2pQTFiJ9Sr9pLFx-qFv1PAAs+KyPiRuB3qTLmtY2ZhYw@mail.gmail.com>
From: Greentime Hu <green.hu@gmail.com>
Date: Wed, 21 Feb 2018 20:02:42 +0800
Message-ID: <CAEbi=3eAkOeB=Hb93ekPwqBLENNDxWutxJnJHaC=3KAV_P6kJA@mail.gmail.com>
Subject: Re: [PATCH v7 02/37] asm-generic/io.h: move ioremap_nocache/ioremap_uc/ioremap_wc/ioremap_wt
 out of ifndef CONFIG_MMU
To: Arnd Bergmann <arnd@arndb.de>
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

2018-02-21 19:37 GMT+08:00 Arnd Bergmann <arnd@arndb.de>:
> On Wed, Feb 21, 2018 at 12:21 PM, Greentime Hu <green.hu@gmail.com> wrote:
>> 2018-02-16 18:47 GMT+08:00 kbuild test robot <lkp@intel.com>:
>
>>
>> From: Greentime Hu <greentime@andestech.com>
>> Date: Wed, 21 Feb 2018 14:21:23 +0800
>> Subject: [PATCH] xtensa: add ioremap_nocache declaration before include
>>  asm-generic/io.h.
>>
>> A future commit for the nds32 architecture bootstrap("asm-generic/io.h:
>> move ioremap_nocache/ioremap_uc/ioremap_wc/ioremap_wt out of ifndef
>> CONFIG_MMU") will move the ioremap_nocache out of the CONFIG_MMU ifdef.
>> This means that in order to suppress re-definition errors we need to
>> setup #define's before importing asm-generic/io.h.
>>
>> Signed-off-by: Greentime Hu <greentime@andestech.com>
>
> Don't you need to override both ioremap and ioremap_nocache?

Hi, Arnd:

It can fix the building error to override ioremap_nocache.
Why should I override ioremap?

Do you mean remove this implementation
"
static inline void __iomem *ioremap(unsigned long offset, unsigned long size)
{
        return ioremap_nocache(offset, size);
}
"
and replace it with
#define ioremap ioremap_nocache

Because I think this patch is just used to fix the build error.
Thank you.

>> ---
>>  arch/xtensa/include/asm/io.h | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/xtensa/include/asm/io.h b/arch/xtensa/include/asm/io.h
>> index c38e5a732d86..acc5bb2cf1c7 100644
>> --- a/arch/xtensa/include/asm/io.h
>> +++ b/arch/xtensa/include/asm/io.h
>> @@ -52,6 +52,7 @@ static inline void __iomem *ioremap_cache(unsigned
>> long offset,
>>                 return xtensa_ioremap_cache(offset, size);
>>  }
>>  #define ioremap_cache ioremap_cache
>> +#define ioremap_nocache ioremap_nocache
>>
>>  #define ioremap_wc ioremap_nocache
