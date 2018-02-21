Return-Path: <green.hu@gmail.com>
X-Cyrus-Session-Id: sloti22d1t05-1004140-1519200384-2-8231193740466894610
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FROM 0.001, RCVD_IN_DNSWL_NONE -0.0001,
  RCVD_IN_MSPIKE_H3 -0.01, RCVD_IN_MSPIKE_WL -0.01, SPF_PASS -0.001,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.85.217.194', Host='mail-ua0-f194.google.com', Country='US',
  FromHeader='com', MailFrom='com'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: green.hu@gmail.com
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519200383; b=rI+pb3W/ZdK3e3NzAqxpUbohmnacGetPa0cOGTx4nkIOG/7
    5VlqYo+iF7lI9v2ayUPpChnPmrDnFN3aBinI7nA4WBjH/0lL7Qmn9Lt4h+aCe0CZ
    eGX1M+LETNSQ56+S+KTkr+E42hjyrsM6pq6QJ4g8CsGgcg4HB3EQZ4NtFiQ9e46Q
    TW8haqwbXAVI18KJnJVJCtmIyTfBEfMnz0e+RfP55WYEEZuiqLYropHaBcwvvnR6
    +mZtoBVCg8JiWplezF8xdefk7+b7QX1NHuyD9T7F0BgAinLl5jvHcFtySKt6oaHN
    iX0ErPephnusEM4OMmHvsf4EpgDLMjLVTEKrYnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type; s=arctest; t=
    1519200383; bh=66w+IwqlKT57vGzrBOvOhRA59G6ydw1m73ICcLCZqC4=; b=P
    GDGrELvukyIiIhv/bPeSA1I5ZGb7SCua6qEYui1sJx+ezXRBVJjbPnil+mE6pdEN
    ImxioSadkSPuxLLWe3cFkhqwS2Gdx/WzRtVol7jxy6en7N2vsNJjL4F75UN7x34U
    3/PS1ApHGEHvUNYIPbSXG7xLtDJd0d2rdhXcqED1CIxe+vPFKEZkGP7Pvv71xu2H
    4hFEQecP8flXFbHvXVj16py1knpafHOdz/iK44Cy1VE5lZf2rs2IPxWN0xBEUYQU
    THMCBPCaJKkU/IrxAgjMzIsdfqiO/eM38Ty6mX7+nulbaQwLwhlXwXUmrVhP7Z3T
    +TkESy4ug3rrOpvF8MsJg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=q5CZ44qy x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.85.217.194 (mail-ua0-f194.google.com);
    spf=pass smtp.mailfrom=green.hu@gmail.com smtp.helo=mail-ua0-f194.google.com;
    x-aligned-from=pass;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=Y10P3nos;
    x-ptr=pass x-ptr-helo=mail-ua0-f194.google.com x-ptr-lookup=mail-ua0-f194.google.com;
    x-return-mx=pass smtp.domain=gmail.com smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=q5CZ44qy x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.85.217.194 (mail-ua0-f194.google.com);
    spf=pass smtp.mailfrom=green.hu@gmail.com smtp.helo=mail-ua0-f194.google.com;
    x-aligned-from=pass;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=Y10P3nos;
    x-ptr=pass x-ptr-helo=mail-ua0-f194.google.com x-ptr-lookup=mail-ua0-f194.google.com;
    x-return-mx=pass smtp.domain=gmail.com smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Google-Smtp-Source: AH8x225xtsSC9D8rymOPBI53zYJk4JzawhmKFxOrvV70g4G7hcYqvZvAlxaRy/JmsvTH/edNEGjbkn0Lu59GFRBIbs4=
MIME-Version: 1.0
In-Reply-To: <CAK8P3a1MYopHeyWAs974zHRmfe5z8RS7G1mVQyC+iJXqa28EfA@mail.gmail.com>
References: <cover.1518505384.git.greentime@andestech.com> <4bb01fd533c66c357f3dc23a64f56414109a2aad.1518505384.git.greentime@andestech.com>
 <CAK8P3a1MYopHeyWAs974zHRmfe5z8RS7G1mVQyC+iJXqa28EfA@mail.gmail.com>
From: Greentime Hu <green.hu@gmail.com>
Date: Wed, 21 Feb 2018 16:05:41 +0800
Message-ID: <CAEbi=3eCfWYXZiN+5uaSqDKcEs1Kf3Av=ua6LCZmy2jAy5-Fdw@mail.gmail.com>
Subject: Re: [PATCH v7 03/37] sparc: io: To use the define of
 ioremap_[nocache|wc|wb] in asm-generic/io.h
To: Arnd Bergmann <arnd@arndb.de>
Cc: sparclinux <sparclinux@vger.kernel.org>, Greentime <greentime@andestech.com>,
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

2018-02-14 22:43 GMT+08:00 Arnd Bergmann <arnd@arndb.de>:
> On Tue, Feb 13, 2018 at 10:09 AM, Greentime Hu <green.hu@gmail.com> wrote:
>> A commit for the nds32 architecture bootstrap("asm-generic/io.h: move
>> ioremap_nocache/ioremap_uc/ioremap_wc/ioremap_wt out of ifndef CONFIG_MMU")
>> will move the ioremap_nocache out of the CONFIG_MMU ifdef. This means that
>> in order to suppress re-definition errors we need to remove the #define
>> in io_32.h.
>>
>> Also, the change adds a prototype for ioremap where size is size_t and
>> offset is phys_addr_t so fix that as well.
>>
>> Signed-off-by: Greentime Hu <greentime@andestech.com>
>
> This patch should have been addressed to the sparclinux mailing list to
> the maintainers can see it, otherwise they are unlikely to notice.
>
> Added it to Cc now.
>
> Can you confirm that the patches are ordered correctly in your series so that
> at no point, sparc is in a state that fails to be build cleanly?
>
> If not, this may have to get merged into the other patch.

Hi, Arnd:

These 2 patch will cause sparc building error in any order.

commit af84603e339a6832052071aca1f2a16b8963cc2e
Author: Greentime Hu <green.hu@gmail.com>
Date:   Tue Feb 13 17:09:07 2018 +0800

    sparc: io: To use the define of ioremap_[nocache|wc|wb] in asm-generic/io.h

    A commit for the nds32 architecture bootstrap("asm-generic/io.h: move
    ioremap_nocache/ioremap_uc/ioremap_wc/ioremap_wt out of     ifndef
CONFIG_MMU")
    will move the ioremap_nocache out of the CONFIG_MMU ifdef. This means that
    in order to suppress re-definition errors we need to remove the #define
    in io_32.h.

    Also, the change adds a prototype for ioremap where size is size_t and
    offset is phys_addr_t so fix that as well.

    Signed-off-by: Greentime Hu <greentime@andestech.com>

commit 1995b30ea6628b261192662741940c22ac978884
Author: Greentime Hu <green.hu@gmail.com>
Date:   Tue Feb 13 17:09:06 2018 +0800

    asm-generic/io.h: move
ioremap_nocache/ioremap_uc/ioremap_wc/ioremap_wt out of ifndef
CONFIG_MMU

    It allows some architectures to use this generic macro instead of
    defining theirs.

    Signed-off-by: Vincent Chen <vincentc@andestech.com>
    Signed-off-by: Greentime Hu <greentime@andestech.com>
    Acked-by: Arnd Bergmann <arnd@arndb.de>

Should I merge them together like this?

asm-generic/io.h: move ioremap_nocache/ioremap_uc/ioremap_wc/ioremap_wt out of
ifndef CONFIG_MMU

It allows some architectures to use this generic macro instead of
defining theirs.

sparc: io: To use the define of ioremap_[nocache|wc|wb] in asm-generic/io.h
It will move the ioremap_nocache out of the CONFIG_MMU ifdef. This means that
in order to suppress re-definition errors we need to remove the #define
in arch/sparc/include/asm/io_32.h. Also, the change adds a prototype for
ioremap where size is size_t and offset is phys_addr_t so fix that as well.

Signed-off-by: Greentime Hu <greentime@andestech.com>
