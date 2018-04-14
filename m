Return-Path: <SRS0=f0e2=HD=amacapital.net=luto@kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3054875-1523745728-2-13113496110893938240
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='198.145.29.99', Host='mail.kernel.org', Country='US', FromHeader='net',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: SRS0=f0e2=HD=amacapital.net=luto@kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523745728; b=lPT2KwCCMKSl5h4+2i3Zwz86MRyoLTyu7P9GLf9+aKDSbUeQSg
    nr4gh0WKVN1hM7QbeN+tcWFnE918LBuODPa7pwQ1z169mNLYUhFiWA0glAVMhZsF
    SIDuqEPZVi1+U50/YyzFPFFSyygC3B29zX53GAjPIq57qZ7wDWdbF54HA0xfYx/J
    jhiNgk0iCYLeiaafSjnSYMNJFEOcXrox2m0dEulyEXzLoRLl8+SiSYpQyscHrg9L
    QGf61wupykwyIji4ZelJLfKIpC9h2IHiUNtS/16mtVHHNWhLgFoysIQK6Xg45iuT
    xpnL8XKbyhJv1FDitxYKqWNY39EjCdlDycWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type; s=fm2; t=
    1523745728; bh=+EkvA5/u+89pt+cHOknxdWTjitXb4zzTAiUvawvww9U=; b=T
    8vqzfCYiD949JV2y4/s6nd+YfZnb4ymXTxBkAihOxDA9PJ/7YHYoVyvQOVNyI/wh
    zov/ogIbRD/qrXipHU6BuRiuYrfea/ER7UIW/8wOq4POUugZ9MYXIEuuwBDQ/TRE
    ZlrlZxmKgg8ID1T6nznwpC/iq4CLdvhUX/RkX1feHGotfoE6ujHBXn/t6hPDlOca
    bh0YNHDiw8ngqBLghy9zqPsvI9U0yWIoLv5BZBPLsCphw6fP5SKmC7YmWJ98pOoZ
    ZRH1O+PRs8F5G7JOa6YVqGRb6NWWPRjdvXWlLaOUJvCHGpM6iGW8Kk/0ZGSkVVAx
    XmWfENBbyqvKm6E0ytswg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b=ZzneQYrW x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,d=none) header.from=amacapital.net;
    iprev=pass policy.iprev=198.145.29.99 (mail.kernel.org);
    spf=none smtp.mailfrom="SRS0=f0e2=HD=amacapital.net=luto@kernel.org" smtp.helo=mail.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=MnQ28v4G;
    x-ptr=pass x-ptr-helo=mail.kernel.org x-ptr-lookup=mail.kernel.org;
    x-return-mx=pass smtp.domain=kernel.org smtp.result=pass smtp_is_org_domain=yes header.domain=amacapital.net header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b=ZzneQYrW x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,d=none) header.from=amacapital.net;
    iprev=pass policy.iprev=198.145.29.99 (mail.kernel.org);
    spf=none smtp.mailfrom="SRS0=f0e2=HD=amacapital.net=luto@kernel.org" smtp.helo=mail.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=MnQ28v4G;
    x-ptr=pass x-ptr-helo=mail.kernel.org x-ptr-lookup=mail.kernel.org;
    x-return-mx=pass smtp.domain=kernel.org smtp.result=pass smtp_is_org_domain=yes header.domain=amacapital.net header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHbIg4sEq5buWnh+E/FR7RD1Fx9+l73J2pn/jut795zw4a1qhhybGZb25XFE+t89KM/2KQ/xsBqqAm8Ss6MImkno5YS9WZA38lNvHAMnBTKiP5LW6Zfi
    osZ8LHgZKBHy8d0f0LYj4SZNCTo+xz5lMuTGe/aQoGbQmxfd5gZb2rfm7i7oheArD2DqpfO/XL16/hmwKFM3y3J+jWRDVBhLsDI=
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=czNdAM+YcK12vDHDihaDnQ==:117
    a=czNdAM+YcK12vDHDihaDnQ==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=pGLkceISAAAA:8 a=_7TZGqwV7vo2APlQocYA:9 a=QEXdDO2ut3YA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
X-Remote-Delivered-To: security@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9EEF2177F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=luto@amacapital.net
X-Google-Smtp-Source: AIpwx4+E1bVw++XrzjFC3WNc3fIWhYyyZU1SyV6MCU2V+WhAKJX8WmxENQ8NKB0A2LbtNC/34whu6ulYPLjo1NX3d3Q=
MIME-Version: 1.0
In-Reply-To: <20180414195921.GA10437@avx2>
References: <20180414195921.GA10437@avx2>
From: Andy Lutomirski <luto@amacapital.net>
Date: Sat, 14 Apr 2018 15:41:42 -0700
Message-ID: <CALCETrV2NdGnVose-xRRPG2jDCo6K9MTayYR8XUZFw5j6nU2hg@mail.gmail.com>
Subject: Re: repeatable boot randomness inside KVM guest
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, "Ted Ts'o" <tytso@mit.edu>,
	kvm list <kvm@vger.kernel.org>, security@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, Apr 14, 2018 at 12:59 PM, Alexey Dobriyan <adobriyan@gmail.com> wrote:
> SLAB allocators got CONFIG_SLAB_FREELIST_RANDOM option which randomizes
> allocation pattern inside a slab:
>
>
>         #ifdef CONFIG_SLAB_FREELIST_RANDOM
>         /* Pre-initialize the random sequence cache */
>         static int init_cache_random_seq(struct kmem_cache *s)
>         {
>                 ...
>
> Then I printed actual random sequences for each kmem cache.
> Turned out they were all the same for most of the caches and
> they didn't vary across guest reboots.
>
>         int cache_random_seq_create(struct kmem_cache *cachep, unsigned int count, gfp_t gfp)
>         {
>                 ...
>                 /* Get best entropy at this stage of boot */
>                 prandom_seed_state(&state, get_random_long());
>
> Then I searched internet and turned out KVM can pass randomness via
> virtio-rng or something. So I linked /dev/urandom.
>
> And it didn't help!
>
> The only way to get randomness for SLAB is to enable RDRAND inside guest.
>
> Is it KVM bug?
>
> For the record I'm using qemu 2.11.1-r2 and whatever F27 ships now.

virtio-rng doesn't really do that.  I have an ancient patch set to do
exactly what you want, and I should dust it off.
