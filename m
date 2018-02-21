Return-Path: <arndbergmann@gmail.com>
X-Cyrus-Session-Id: sloti22d1t05-1474421-1519216078-2-12231416555263704561
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
    t=1519216077; b=azYTcvDbpdDTjMAVuPzz6qXO0nFOJx1WQL+T/EXyrdlToda
    yUs/Ocdw/LVXmPCNN0OyhyzoXCFVo9qXE22IUgaDJHhLfHmxVrx4tssCCHrS88gN
    a9xzjMB8oPH1zGXf00Fit30pdJ5e90hdicCkeRfPfyxT+N1dVMHWLBSMQHlUyVcZ
    o+XBUi0EEF3mKMOpz9CiWZqDyU8spoKM35Uzg7FzRbOnCjev+rYq9HUFRWaM5TI0
    Yl34g9iAXGlDxE2EIKFts4mPg7mvS/04COEUt0mJTsXc3a2yNRAoKugNnFYiFJQi
    K9sS8c2YUywdhsYY1k9gPCIwGLMm5nwExJlis3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:sender:in-reply-to
    :references:from:date:message-id:subject:to:cc:content-type; s=
    arctest; t=1519216077; bh=o+1IGTFOP283yByugGjDvFxKghEaYg3I4muAP2
    kI8PQ=; b=K1LU+rGjL066rHRVvi0uJNm/GxlWBJMpCfC6l0LFQSG3bBVHWV9m5I
    yr2lsjHhUZsfvY7J1KQrg7XYt8oj5UalyQaW2bR1iIoI/Zay/eXUXiRHy6Lmoz5H
    gAP9RZUvSw5uOiq3Vb5t11rYlEIsvD+Vu+2oDOfpwtNodonvB10G7rj+cFUsJQgR
    gB67jm/9uGpnn9sU3IPS7NWgfJ7E+EOKalEw1UVir2mr6my1erLnTQelwodfOHwt
    T1jp6OxKOJWxcJUb0LG0Lw5cefzWpWxremFAKMI+YYbXGyuSz3ODeNYD9/awYOG8
    MWnoMZ8Z9ksGEPv7qeoanO/t9k7Rk6MQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=aeeUVjE/ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.85.220.193 (mail-qk0-f193.google.com);
    spf=pass smtp.mailfrom=arndbergmann@gmail.com smtp.helo=mail-qk0-f193.google.com;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=BLP1+nXQ;
    x-ptr=pass x-ptr-helo=mail-qk0-f193.google.com x-ptr-lookup=mail-qk0-f193.google.com;
    x-return-mx=pass smtp.domain=gmail.com smtp.result=pass smtp_is_org_domain=yes header.domain=arndb.de header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=aeeUVjE/ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.85.220.193 (mail-qk0-f193.google.com);
    spf=pass smtp.mailfrom=arndbergmann@gmail.com smtp.helo=mail-qk0-f193.google.com;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=BLP1+nXQ;
    x-ptr=pass x-ptr-helo=mail-qk0-f193.google.com x-ptr-lookup=mail-qk0-f193.google.com;
    x-return-mx=pass smtp.domain=gmail.com smtp.result=pass smtp_is_org_domain=yes header.domain=arndb.de header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Google-Smtp-Source: AG47ELukxpkLdeIiNngh341biYvTKPAWqrIjGRvUqX4+7INx2R4Kwrw2HjhYy3DL2urqv40suAZ+ZDpEfG5KbDMnfbM=
MIME-Version: 1.0
Sender: arndbergmann@gmail.com
In-Reply-To: <CAEbi=3eCfWYXZiN+5uaSqDKcEs1Kf3Av=ua6LCZmy2jAy5-Fdw@mail.gmail.com>
References: <cover.1518505384.git.greentime@andestech.com> <4bb01fd533c66c357f3dc23a64f56414109a2aad.1518505384.git.greentime@andestech.com>
 <CAK8P3a1MYopHeyWAs974zHRmfe5z8RS7G1mVQyC+iJXqa28EfA@mail.gmail.com> <CAEbi=3eCfWYXZiN+5uaSqDKcEs1Kf3Av=ua6LCZmy2jAy5-Fdw@mail.gmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 21 Feb 2018 13:27:55 +0100
X-Google-Sender-Auth: HNeiYGoSKfX6iqH8KQlpX2u05MI
Message-ID: <CAK8P3a19k92HhqEVBYO7wqx77k5PN6t_-9UbbU-DDYfZrnUUhA@mail.gmail.com>
Subject: Re: [PATCH v7 03/37] sparc: io: To use the define of
 ioremap_[nocache|wc|wb] in asm-generic/io.h
To: Greentime Hu <green.hu@gmail.com>
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

On Wed, Feb 21, 2018 at 9:05 AM, Greentime Hu <green.hu@gmail.com> wrote:
> 2018-02-14 22:43 GMT+08:00 Arnd Bergmann <arnd@arndb.de>:
>> On Tue, Feb 13, 2018 at 10:09 AM, Greentime Hu <green.hu@gmail.com> wrote:
>>> A commit for the nds32 architecture bootstrap("asm-generic/io.h: move
>>> ioremap_nocache/ioremap_uc/ioremap_wc/ioremap_wt out of ifndef CONFIG_MMU")
>>> will move the ioremap_nocache out of the CONFIG_MMU ifdef. This means that
>>> in order to suppress re-definition errors we need to remove the #define
>>> in io_32.h.
>>>
>>> Also, the change adds a prototype for ioremap where size is size_t and
>>> offset is phys_addr_t so fix that as well.
>>>
>>> Signed-off-by: Greentime Hu <greentime@andestech.com>
>>
>> This patch should have been addressed to the sparclinux mailing list to
>> the maintainers can see it, otherwise they are unlikely to notice.
>>
>> Added it to Cc now.
>>
>> Can you confirm that the patches are ordered correctly in your series so that
>> at no point, sparc is in a state that fails to be build cleanly?
>>
>> If not, this may have to get merged into the other patch.
>
> Hi, Arnd:
>
> These 2 patch will cause sparc building error in any order.


>
> Should I merge them together like this?
>
> asm-generic/io.h: move ioremap_nocache/ioremap_uc/ioremap_wc/ioremap_wt out of
> ifndef CONFIG_MMU
>
> It allows some architectures to use this generic macro instead of
> defining theirs.
>
> sparc: io: To use the define of ioremap_[nocache|wc|wb] in asm-generic/io.h
> It will move the ioremap_nocache out of the CONFIG_MMU ifdef. This means that
> in order to suppress re-definition errors we need to remove the #define
> in arch/sparc/include/asm/io_32.h. Also, the change adds a prototype for
> ioremap where size is size_t and offset is phys_addr_t so fix that as well.
>
> Signed-off-by: Greentime Hu <greentime@andestech.com>

That looks reasonable since both patches are fairly small, yes.

For a more complex patch that requires interdependent changes
in different areas of the kernel, it may be necessary instead to
come up with a way to stage out the changes differently so they
are truly independent. Getting that right requires a bit practice
but is usually possible.

       Arnd
