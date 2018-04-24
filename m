Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751582AbeDXQAD convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 12:00:03 -0400
Received: from gauss.credativ.com ([93.94.130.89]:41212 "EHLO
        gauss.credativ.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751155AbeDXQAA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 12:00:00 -0400
Date: Tue, 24 Apr 2018 17:59:54 +0200 (CEST)
From: Sedat Dilek <sedat.dilek@credativ.de>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>
Message-ID: <1841878132.11493.1524585595039@ox.credativ.com>
In-Reply-To: <CAK7LNATsJ2kvw4JMS-2WsU7a9wrqcYLmfHPBwQDwbAEVFa8E1g@mail.gmail.com>
References: <20180424084408.28034-1-sedat.dilek@credativ.de>
 <CAK7LNATsJ2kvw4JMS-2WsU7a9wrqcYLmfHPBwQDwbAEVFa8E1g@mail.gmail.com>
Subject: Re: [PATCH] Makefile: Fix typo s/HOST_LOADLIBES/HOST_LOADLIBS
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Priority: 3
Importance: Medium
X-Mailer: Open-Xchange Mailer v7.8.4-Rev24
X-Originating-IP: 2003:5b:203b:100:56e1:adff:fea0:6ba0
X-Originating-Client: open-xchange-appsuite
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Masahiro Yamada <yamada.masahiro@socionext.com> hat am 24. April 2018 um 17:51 geschrieben:
> 
> 
> 2018-04-24 17:44 GMT+09:00 Sedat Dilek <sedat.dilek@credativ.de>:
> > Signed-off-by: Sedat Dilek <sedat.dilek@credativ.de>
> > ---
> >  Makefile | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/Makefile b/Makefile
> > index 83b6c541565a..e1869dc08288 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -366,7 +366,7 @@ HOSTCFLAGS   := -Wall -Wmissing-prototypes -Wstrict-prototypes -O2 \
> >                 -fomit-frame-pointer -std=gnu89 $(HOST_LFS_CFLAGS)
> >  HOSTCXXFLAGS := -O2 $(HOST_LFS_CFLAGS)
> >  HOSTLDFLAGS  := $(HOST_LFS_LDFLAGS)
> > -HOST_LOADLIBES := $(HOST_LFS_LIBS)
> > +HOST_LOADLIBS := $(HOST_LFS_LIBS)
> >
> >  # Make variables (CC, etc...)
> >  AS             = $(CROSS_COMPILE)as
> > @@ -433,7 +433,7 @@ LDFLAGS :=
> >  GCC_PLUGINS_CFLAGS :=
> >
> >  export ARCH SRCARCH CONFIG_SHELL HOSTCC HOSTCFLAGS CROSS_COMPILE AS LD CC
> > -export CPP AR NM STRIP OBJCOPY OBJDUMP HOSTLDFLAGS HOST_LOADLIBES
> > +export CPP AR NM STRIP OBJCOPY OBJDUMP HOSTLDFLAGS HOST_LOADLIBS
> >  export MAKE LEX YACC AWK GENKSYMS INSTALLKERNEL PERL PYTHON PYTHON2 PYTHON3 UTS_MACHINE
> >  export HOSTCXX HOSTCXXFLAGS LDFLAGS_MODULE CHECK CHECKFLAGS
> >
> 
> Why is this a typo?
> 
> 
> Our Makefiles use HOST_LOADLIBES consistently.
> 

OK. Do you happen to know why it is LOADLIB*E*S?

- Sedat -

> 
> $ git grep HOST_LOADLIB
> Makefile:HOST_LOADLIBES := $(HOST_LFS_LIBS)
> Makefile:export CPP AR NM STRIP OBJCOPY OBJDUMP HOSTLDFLAGS HOST_LOADLIBES
> scripts/Makefile.host:          $(HOST_LOADLIBES) $(HOSTLOADLIBES_$(@F))
> scripts/Makefile.host:                    $(HOST_LOADLIBES)
> $(HOSTLOADLIBES_$(@F))
> scripts/Makefile.host:                    $(HOST_LOADLIBES)
> $(HOSTLOADLIBES_$(@F))
> scripts/Makefile.host:                    $(HOST_LOADLIBES)
> $(HOSTLOADLIBES_$(@F))
> scripts/Makefile.host:                    $(HOST_LOADLIBES)
> $(HOSTLOADLIBES_$(@F))
> 
> 
> 
> 
> -- 
> Best Regards
> Masahiro Yamada

-- 
Mit freundlichen Grüssen, 
Sedat Dilek 

Telefon: +49 2166 9901-153 
E-Mail: sedat.dilek@credativ.de 
Internet: https://www.credativ.de/ 

GPG-Fingerprint: EA6D E17D D269 AC7E 101D C910 476F 2B3B 0AF7 F86B

credativ GmbH, Trompeterallee 108, 41189 Mönchengladbach
Handelsregister: Amtsgericht Mönchengladbach, HR-Nummer: HRB 12080, UID-Nummer: DE204566209
Geschäftsführung: Dr. Michael Meskes, Jörg Folz, Sascha Heuer

**********************************************
Jetzt neu:
Elephant Shed - PostgreSQL Appliance
PostgreSQL und alles was dazugehört

Von Backup über Monitoring bis Reporting:
https://elephant-shed.io/
**********************************************
