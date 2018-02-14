Return-Path: <arndbergmann@gmail.com>
X-Cyrus-Session-Id: sloti22d1t05-3010894-1518619423-2-14506282903742953468
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.195, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_NONE -0.0001,
  RCVD_IN_MSPIKE_H3 -0.01, RCVD_IN_MSPIKE_WL -0.01, SPF_PASS -0.001,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.85.220.193', Host='mail-qk0-f193.google.com', Country='US',
  FromHeader='de', MailFrom='com'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: arndbergmann@gmail.com
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518619422; b=fxtao6xBuwWcjf0tTU++vvS+YUrqoHWLttZWwBbK3tRTO+V
    edpjLZhIT99So4awNJcU1SqejC+sInYDAJQhrTZQgQSPP9DqwD7vgFTTcwFmxKSZ
    VFgODchNBoDd5x49vAHJaOw0dIUDgPAyJNVXAzRvaLUdGkFrnKEv5VQOck+l3Gql
    DFbaBWqnKtzy8GLEk9knzPTKvy7PLP0atFiIEkwCyIE+4gfkuFLbUdLLOXwomXHg
    DaG3xWC0296ie7HXSR5NIiVsIzYpW44zw+Xe0ihmTZ4a4piqRjVhlqNs58zSlCLg
    eDopxj0bngAR9sVHc8J4ysSGjlMWqmOd5NnAvmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:sender:in-reply-to
    :references:from:date:message-id:subject:to:cc:content-type; s=
    arctest; t=1518619422; bh=dwjexOclrDp/WjGNLxuHS9uz0K/xMRTJGYbQcA
    ev384=; b=VIVQ8/1RiasmjliTCH1zzKBTF3pINZNTEGXzspfQ3nJulfIlgUwOf9
    BFYdELA2YiQO4NosZr+8MnrfNMoPTqnhItmzlmKyx/IuPzfKmvrKpTVKOCESz0rP
    rPt6SF/yitdLll6hoO9S+D2/BhSObKiAWH/yWi+L5DiI13uEULKZRNs65IlBtsoF
    VANNB2X9WrnY4n3LvoVQ8PZDMSpl86FW+hi6u4muu2l2SC/bTBKdQDCNjQlo4gQ0
    nKOYMnCahO9J2CJel8w+vQ3KSlxEYjFJoREiJk1JRDLpa14vKAxJgxiGOHb29zYR
    6HhVnVEdfwZz4OPQ5z8Njc2Wdg4Dp2tw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=ocmzZdR0 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.85.220.193 (mail-qk0-f193.google.com);
    spf=pass smtp.mailfrom=arndbergmann@gmail.com smtp.helo=mail-qk0-f193.google.com;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=NfXaBX4Y;
    x-ptr=pass x-ptr-helo=mail-qk0-f193.google.com x-ptr-lookup=mail-qk0-f193.google.com;
    x-return-mx=pass smtp.domain=gmail.com smtp.result=pass smtp_is_org_domain=yes header.domain=arndb.de header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=ocmzZdR0 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.85.220.193 (mail-qk0-f193.google.com);
    spf=pass smtp.mailfrom=arndbergmann@gmail.com smtp.helo=mail-qk0-f193.google.com;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=NfXaBX4Y;
    x-ptr=pass x-ptr-helo=mail-qk0-f193.google.com x-ptr-lookup=mail-qk0-f193.google.com;
    x-return-mx=pass smtp.domain=gmail.com smtp.result=pass smtp_is_org_domain=yes header.domain=arndb.de header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Google-Smtp-Source: AH8x22695meuoMVj3YIAyD7w/rN2ahxluOhugnH1TYPpHKCLSs9IamGxeNxXQmcOByHyQ/JfFPOSwu0iuvqVHYcRPUg=
MIME-Version: 1.0
Sender: arndbergmann@gmail.com
In-Reply-To: <4bb01fd533c66c357f3dc23a64f56414109a2aad.1518505384.git.greentime@andestech.com>
References: <cover.1518505384.git.greentime@andestech.com> <4bb01fd533c66c357f3dc23a64f56414109a2aad.1518505384.git.greentime@andestech.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 14 Feb 2018 15:43:40 +0100
X-Google-Sender-Auth: Im_Y4NqW0p4OGUuLlI2SPmaBl-w
Message-ID: <CAK8P3a1MYopHeyWAs974zHRmfe5z8RS7G1mVQyC+iJXqa28EfA@mail.gmail.com>
Subject: Re: [PATCH v7 03/37] sparc: io: To use the define of
 ioremap_[nocache|wc|wb] in asm-generic/io.h
To: Greentime Hu <green.hu@gmail.com>, sparclinux <sparclinux@vger.kernel.org>
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
	Randy Dunlap <rdunlap@infradead.org>, David Miller <davem@davemloft.net>,
	Jonas Bonn <jonas@southpole.se>,
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, Stafford Horne <shorne@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Feb 13, 2018 at 10:09 AM, Greentime Hu <green.hu@gmail.com> wrote:
> A commit for the nds32 architecture bootstrap("asm-generic/io.h: move
> ioremap_nocache/ioremap_uc/ioremap_wc/ioremap_wt out of ifndef CONFIG_MMU")
> will move the ioremap_nocache out of the CONFIG_MMU ifdef. This means that
> in order to suppress re-definition errors we need to remove the #define
> in io_32.h.
>
> Also, the change adds a prototype for ioremap where size is size_t and
> offset is phys_addr_t so fix that as well.
>
> Signed-off-by: Greentime Hu <greentime@andestech.com>

This patch should have been addressed to the sparclinux mailing list to
the maintainers can see it, otherwise they are unlikely to notice.

Added it to Cc now.

Can you confirm that the patches are ordered correctly in your series so that
at no point, sparc is in a state that fails to be build cleanly?

If not, this may have to get merged into the other patch.

        Arnd

> ---
>  arch/sparc/include/asm/io_32.h | 5 -----
>  arch/sparc/kernel/ioport.c     | 4 ++--
>  2 files changed, 2 insertions(+), 7 deletions(-)
>
> diff --git a/arch/sparc/include/asm/io_32.h b/arch/sparc/include/asm/io_32.h
> index cd51a89b393c..df2dc1784673 100644
> --- a/arch/sparc/include/asm/io_32.h
> +++ b/arch/sparc/include/asm/io_32.h
> @@ -127,12 +127,7 @@ static inline void sbus_memcpy_toio(volatile void __iomem *dst,
>   * Bus number may be embedded in the higher bits of the physical address.
>   * This is why we have no bus number argument to ioremap().
>   */
> -void __iomem *ioremap(unsigned long offset, unsigned long size);
> -#define ioremap_nocache(X,Y)   ioremap((X),(Y))
> -#define ioremap_wc(X,Y)                ioremap((X),(Y))
> -#define ioremap_wt(X,Y)                ioremap((X),(Y))
>  void iounmap(volatile void __iomem *addr);
> -
>  /* Create a virtual mapping cookie for an IO port range */
>  void __iomem *ioport_map(unsigned long port, unsigned int nr);
>  void ioport_unmap(void __iomem *);
> diff --git a/arch/sparc/kernel/ioport.c b/arch/sparc/kernel/ioport.c
> index 7eeef80c02f7..3bcef9ce74df 100644
> --- a/arch/sparc/kernel/ioport.c
> +++ b/arch/sparc/kernel/ioport.c
> @@ -122,12 +122,12 @@ static void xres_free(struct xresource *xrp) {
>   *
>   * Bus type is always zero on IIep.
>   */
> -void __iomem *ioremap(unsigned long offset, unsigned long size)
> +void __iomem *ioremap(phys_addr_t offset, size_t size)
>  {
>         char name[14];
>
>         sprintf(name, "phys_%08x", (u32)offset);
> -       return _sparc_alloc_io(0, offset, size, name);
> +       return _sparc_alloc_io(0, (unsigned long)offset, size, name);
>  }
>  EXPORT_SYMBOL(ioremap);
>
> --
> 2.16.1
>
