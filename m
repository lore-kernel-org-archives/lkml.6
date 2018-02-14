Return-Path: <arndbergmann@gmail.com>
X-Cyrus-Session-Id: sloti22d1t05-3010894-1518618707-2-10971461793903367681
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.195, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_NONE -0.0001,
  RCVD_IN_MSPIKE_H3 -0.01, RCVD_IN_MSPIKE_WL -0.01, SPF_PASS -0.001,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.85.216.196', Host='mail-qt0-f196.google.com', Country='US',
  FromHeader='de', MailFrom='com'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: arndbergmann@gmail.com
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518618706; b=uZxgbzNiIPsF2wNG6zTHnIe7cKNrpQOBG69MrnXGfd4MtvQ
    rBhNfwKbtnDjLIzwPwgaNIgAs1QURJMSoNuySZOxnK3wu3ZG2NEDCE7Mk3osWFf4
    uS8q5mgOMMOFJ7kZscuoieYX4s143LM70Wr8xu038bAzrCv4kwrrYWlf1Tp7D9BR
    o6enOmf9nWzR9tGt+jF65nAE4VgyZBjAKguOdfBAu+9CdEO+LV5K2HiLWd864PF0
    tbL+OVDYaqyhqurMoOjoPfpAZCAHZ9bHAig8klS4C0gvicoH5cXPOchrmHgvwzxf
    gr85JfI1qVoc680fRpt/34BJBWoiDj78/rR/oTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:sender:in-reply-to
    :references:from:date:message-id:subject:to:cc:content-type; s=
    arctest; t=1518618706; bh=mhxZ4Q3FQPpH4CvQJgV371Arcj9ZAF7LMV5uBd
    d6/ac=; b=KmxsG3aYMrPdQzl7OSYsXefywP3z+ioHXWWG3fJd23otigjK8Kfy4T
    P1h9rlS0ENi85iEFMQAneDgEFZBa14gSgWcyXzfK2bNd/Tw0CtbtzNPfTlu4Fxqx
    vyWNnK+GDIfDqGNF5X+n8HzRC8eXfEDv74f+2g3lkHByl2J8M8ACFsr4HGkIGQCH
    vYzON4x/BiyDPgaHznUsdKB51DOo4Wlm1fkyg7s7D5dJ0j3A5tRuJca97C657REo
    jHCl4W03J4LbgaEskeEq685VFzhJbHzB/3HAeC/0XQaduL1ga9EgnEUr/70rc+ur
    LIhPnkh9E+EpPhJv8rtsKetOhwS26UxQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=CFw7hwb5 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.85.216.196 (mail-qt0-f196.google.com);
    spf=pass smtp.mailfrom=arndbergmann@gmail.com smtp.helo=mail-qt0-f196.google.com;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=VyloyW+H;
    x-ptr=pass x-ptr-helo=mail-qt0-f196.google.com x-ptr-lookup=mail-qt0-f196.google.com;
    x-return-mx=pass smtp.domain=gmail.com smtp.result=pass smtp_is_org_domain=yes header.domain=arndb.de header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=CFw7hwb5 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.85.216.196 (mail-qt0-f196.google.com);
    spf=pass smtp.mailfrom=arndbergmann@gmail.com smtp.helo=mail-qt0-f196.google.com;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=VyloyW+H;
    x-ptr=pass x-ptr-helo=mail-qt0-f196.google.com x-ptr-lookup=mail-qt0-f196.google.com;
    x-return-mx=pass smtp.domain=gmail.com smtp.result=pass smtp_is_org_domain=yes header.domain=arndb.de header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Google-Smtp-Source: AH8x227fDQHQ4groEFz8MSbAYnfYqY7C8iu27FtRWG7jFr9Afmd43uPBs/Yqv5rKFglAJvy1lDW0L6D1mbjUGVB52jU=
MIME-Version: 1.0
Sender: arndbergmann@gmail.com
In-Reply-To: <5d7538f6cad0763594f968d58625c7c7a99f3225.1518505384.git.greentime@andestech.com>
References: <cover.1518505384.git.greentime@andestech.com> <5d7538f6cad0763594f968d58625c7c7a99f3225.1518505384.git.greentime@andestech.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 14 Feb 2018 15:31:44 +0100
X-Google-Sender-Auth: m5O1fEBk9Iu9K2f2fl7bb4_SDPU
Message-ID: <CAK8P3a3hnHVrMJuTfDwWcy1R3C=o9UzDVN=OtsZdUzXboYPT5w@mail.gmail.com>
Subject: Re: [PATCH v7 08/37] nds32: Exception handling
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
	Randy Dunlap <rdunlap@infradead.org>, David Miller <davem@davemloft.net>,
	Jonas Bonn <jonas@southpole.se>,
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, Stafford Horne <shorne@gmail.com>,
	Vincent Chen <vincentc@andestech.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Feb 13, 2018 at 10:09 AM, Greentime Hu <green.hu@gmail.com> wrote:
> This patch includes the exception/interrupt entries, pt_reg structure and
> related accessors.
>
> /* Unaligned accessing handling*/
> Andes processors cannot load/store information which is not naturally
> aligned on the bus, i.e., loading a 4 byte data whose start address must
> be divisible by 4. If unaligned data accessing is happened, data
> unaligned exception will be triggered and user will get SIGSEGV or
> kernel oops according to the unaligned address. In order to make user be
> able to load/store data from an unaligned address, software load/store
> emulation is implemented in arch/nds32/mm/alignment.c to address data
> unaligned exception.
>
> Unaligned accessing handling is disabled by default because it is not a
> normal case. User can enable this feature by following steps.
>
> A. Compile time:
>     1. Enable kernel config CONFIG_ALIGNMENT_TRAP
> B. Run time:
>     1. Enter /proc/sys/nds32/unaligned_acess folder
>     2. Write 1 to file enable_mode to enable unaligned accessing
>        handling. User can disable it by writing 0 to this file.
>     3. Write 1 to file debug to show which unaligned address is under
>        processing. User can disable it by writing 0 to this file.
>
> However, unaligned accessing handler cannot work if this unaligned
> address is not accessible such as protection violation. On this
> condition, the default behaviors for addressing data unaligned exception
> still happen
>
> Signed-off-by: Vincent Chen <vincentc@andestech.com>
> Signed-off-by: Greentime Hu <greentime@andestech.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>
